import 'dart:async';
import 'package:flutter/foundation.dart';

class ExperimentManager extends ChangeNotifier {
  bool _isRunning = false;
  int _totalAttempts = 0;
  int _successfulStabilizations = 0;
  Timer? _timer;
  
  bool get isRunning => _isRunning;
  int get totalAttempts => _totalAttempts;
  int get successfulStabilizations => _successfulStabilizations;
  
  void startExperiment() {
    _isRunning = true;
    _totalAttempts = 0;
    _successfulStabilizations = 0;
    notifyListeners();
  }
  
  void stopExperiment() {
    _isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }
  
  void incrementAttempts() {
    _totalAttempts++;
    notifyListeners();
  }
  
  void incrementSuccess() {
    _successfulStabilizations++;
    notifyListeners();
  }
}
