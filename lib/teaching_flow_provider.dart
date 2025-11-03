import 'dart:async';
import 'package:flutter/foundation.dart';

enum TeachingPhase { home, splash, teaching }

class TeachingFlowProvider extends ChangeNotifier {
  TeachingPhase _phase = TeachingPhase.home;
  Timer? _timer;

  TeachingPhase get phase => _phase;

  void _setPhase(TeachingPhase next) {
    _phase = next;
    notifyListeners();
  }

  void startTeaching() {
    _timer?.cancel();
    _setPhase(TeachingPhase.splash);
    _timer = Timer(const Duration(seconds: 5), () {
      _setPhase(TeachingPhase.teaching);
    });
  }

  void resetToHome() {
    _timer?.cancel();
    _setPhase(TeachingPhase.home);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


