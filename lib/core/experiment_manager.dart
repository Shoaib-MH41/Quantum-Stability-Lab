import 'dart:async';
import 'package:flutter/foundation.dart';
// یہاں اپنی باقی فائلوں کو امپورٹ کریں
import 'accident_law.dart';
import 'stability_engine.dart';
import 'fixation_law.dart';

class ExperimentManager extends ChangeNotifier {
  bool _isRunning = false;
  int _totalAttempts = 0;
  int _successfulStabilizations = 0;
  
  // نئے سائنسی میٹرکس (Metrics)
  int _trainAccidents = 0;
  int _carAccidents = 0;
  String _currentSystemStatus = "تیار";
  
  // قوانین کے انسٹنس (Instances)
  final AccidentLaw accidentLaw = AccidentLaw();
  final StabilityEngine stabilityEngine = StabilityEngine();
  final FixationLaw fixationLaw = FixationLaw();

  // گیٹرز (Getters)
  bool get isRunning => _isRunning;
  int get totalAttempts => _totalAttempts;
  int get successfulStabilizations => _successfulStabilizations;
  int get trainAccidents => _trainAccidents;
  int get carAccidents => _carAccidents;
  String get currentStatus => _currentSystemStatus;

  void startExperiment() {
    _isRunning = true;
    _totalAttempts = 0;
    _successfulStabilizations = 0;
    _trainAccidents = 0;
    _carAccidents = 0;
    _currentSystemStatus = "مشاہدہ شروع...";
    notifyListeners();
  }

  // اصل سائنسی لاجک: ہر فریم پر اسے کال کریں
  void runScientificCycle(double currentNpuTime, double light, double magnetic, int particles) {
    if (!_isRunning) return;

    _totalAttempts++;

    // 1. حادثہ پہچانیں (Train or Car?)
    String accidentType = accidentLaw.detectAccidentType(light, magnetic);
    
    if (accidentType == "ٹرین کا حادثہ") _trainAccidents++;
    if (accidentType == "کار کا حادثہ") _carAccidents++;

    // 2. این پی یو کی تثبیت کی قوت حاصل کریں
    double strength = accidentLaw.getFixationStrength(accidentType);

    // 3. قانونِ تثبیت لاگو کریں
    var fixationResult = fixationLaw.applyQuantumFixation(currentNpuTime, strength);

    // 4. استحکام چیک کریں
    bool isStable = stabilityEngine.checkStability(currentNpuTime, particles);
    if (isStable) _successfulStabilizations++;

    _currentSystemStatus = stabilityEngine.getSystemStatus();
    
    notifyListeners();
  }

  void stopExperiment() {
    _isRunning = false;
    _currentSystemStatus = "تجربہ مکمل";
    notifyListeners();
  }
}
