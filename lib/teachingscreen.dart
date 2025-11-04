import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'teaching_flow_provider.dart';

class TeachingScreen extends StatefulWidget {
  const TeachingScreen({super.key});

  @override
  State<TeachingScreen> createState() => _TeachingScreenState();
}

class _TeachingScreenState extends State<TeachingScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = "";
  bool _speechAvailable = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        // If status indicates listening stopped but user wants to keep listening,
        // restart listening automatically
        if (_isListening && (status == 'done' || status == 'notListening')) {
          // Restart listening if user still wants it active
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_isListening && mounted) {
              _speech.listen(
                onResult: (result) {
                  setState(() {
                    _transcription = result.recognizedWords;
                  });
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                },
                listenFor: const Duration(hours: 24),
                pauseFor: const Duration(seconds: 3),
                partialResults: true,
                localeId: 'en_US',
                cancelOnError: false,
              );
            }
          });
        }
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Speech recognition error: ${error.errorMsg}')),
          );
        }
      },
    );

    setState(() {
      _speechAvailable = available;
    });
  }

  void _toggleListening() {
    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
      return;
    }

    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    } else {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _transcription = result.recognizedWords;
          });
          // Auto-scroll to bottom when new text is added
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        },
        listenFor: const Duration(hours: 24), // Very long duration - only stops when button is pressed
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'en_US',
        cancelOnError: false, // Don't cancel on errors, keep listening
      );
      setState(() {
        _isListening = true;
      });
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        title: const Text("Live Lesson"),
        actions: [
          IconButton(
            tooltip: 'End',
            onPressed: () {
              _speech.stop();
              context.read<TeachingFlowProvider>().resetToHome();
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Color.fromARGB(20, 0, 0, 0), blurRadius: 8, offset: Offset(0, 4))],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isListening ? Icons.fiber_manual_record : Icons.fiber_manual_record_outlined,
                        color: _isListening ? Colors.red : Colors.grey,
                        size: 12,
                      ),
                      const SizedBox(width: 8),
                      const Text("LIVE TRANSCRIPTION", style: TextStyle(fontWeight: FontWeight.w700)),
                      if (_isListening) ...[
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 8,
                          height: 8,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        _transcription.isEmpty
                            ? "Live transcription of the lecture will appear here in real-time as you speak. The text will automatically scroll as more content is added, allowing you to keep an eye on the accuracy of the transcription without manual intervention."
                            : _transcription,
                        style: TextStyle(
                          color: _transcription.isEmpty ? Colors.black54 : Colors.black87,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Color.fromARGB(20, 0, 0, 0), blurRadius: 8, offset: Offset(0, 4))],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Live Summary", style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text("• Key historical figures in the revolution.\n• Main causes and effects discussed.\n• Timeline of major events from 1775-1783."),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text("Show Visuals"),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Summarize L..."),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: _toggleListening,
                  backgroundColor: _isListening ? Colors.red : const Color(0xFF4C6EF5),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


