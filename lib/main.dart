import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'splashscreen.dart';
import 'teachingscreen.dart';
import 'teaching_flow_provider.dart';


void main() {
  runApp(const Hiasfest_Ai());
}

class Hiasfest_Ai extends StatelessWidget {
  const Hiasfest_Ai({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeachingFlowProvider(),
      child: Consumer<TeachingFlowProvider>(
        builder: (context, flow, _) {
          Widget screen;
          switch (flow.phase) {
            case TeachingPhase.home:
              screen = const Homescreen();
              break;
            case TeachingPhase.splash:
              screen = const Splashscreen();
              break;
            case TeachingPhase.teaching:
              screen = const TeachingScreen();
              break;
          }
          return MaterialApp(
            title: 'Teacher Assistant',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: screen,
          );
        },
      ),
    );
  }
}


