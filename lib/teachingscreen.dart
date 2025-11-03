import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'teaching_flow_provider.dart';

class TeachingScreen extends StatelessWidget {
  const TeachingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        title: const Text("Live Lesson"),
        actions: [
          IconButton(
            tooltip: 'End',
            onPressed: () => context.read<TeachingFlowProvider>().resetToHome(),
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
                children: const [
                  Row(
                    children: [
                      Icon(Icons.fiber_manual_record, color: Colors.red, size: 12),
                      SizedBox(width: 8),
                      Text("LIVE TRANSCRIPTION", style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Live transcription of the lecture will appear here in real-time as you speak...",
                    style: TextStyle(color: Colors.black87),
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
                  onPressed: () {},
                  child: const Icon(Icons.mic),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


