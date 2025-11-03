import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'teaching_flow_provider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flow = context.watch<TeachingFlowProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9ECF9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.school_outlined, size: 52, color: Color(0xFF4C6EF5)),
              ),
              const SizedBox(height: 24),
              const Text(
                "Teacher Assistant App",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your AI Partner in the Classroom.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 240,
                child: LinearProgressIndicator(
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF4C6EF5),
                  backgroundColor: const Color(0xFFE3E7FF),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                flow.phase == TeachingPhase.splash ? "Preparing your live lesson..." : "",
                style: const TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}


