import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;
  
  // سوئچ: NPU vs GPU
  static bool useClusterLogic = false;
  
  // تمام پارٹیکلز کی لسٹ
  static List<RealQuantumParticle> allParticles = [];

  double currentTime;
  final double targetTime = 20.0;
  int stableCount = 0;

  bool get isStable => (currentTime - targetTime).abs() <= 1.5;
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id) : currentTime = 18.0 + Random().nextDouble() * 4.0 {
    _initializeSensors();
    _startQuantumRandomness();
    
    if (!allParticles.contains(this)) {
      allParticles.add(this);
    }
  }

  void _initializeSensors() {
    try {
      _sensorSub = accelerometerEvents.listen((AccelerometerEvent e) {
        environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.1;
      });
    } catch (e) {
      environmentalNoise = Random().nextDouble() * 0.5;
    }
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      quantumRandomness = Random().nextDouble() * 1.0;
    });
  }

  void apply35msLaw() {
    double step;

    if (useClusterLogic) {
      // NPU: گروپ انٹیلی جنس
      step = _calculateNPUStep();
    } else {
      // GPU: انفرادی بروٹ فورس
      step = _calculateGPUStep();
    }

    double jitter = (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise);
    
    currentTime += step + jitter;

    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  double _calculateNPUStep() {
    if (allParticles.length < 2) {
      return (targetTime - currentTime) * 0.15;
    }

    int groupSize = min(10, allParticles.length);
    int start = max(0, id - groupSize ~/ 2);
    int end = min(allParticles.length, start + groupSize);

    double groupSum = 0;
    int count = 0;

    for (int i = start; i < end; i++) {
      groupSum += allParticles[i].currentTime;
      count++;
    }

    double groupAvg = count > 0 ? groupSum / count : currentTime;
    double distance = (targetTime - groupAvg).abs();
    
    double factor = distance > 5 ? 0.1 : 
                    distance > 2 ? 0.15 : 0.2;

    return (targetTime - groupAvg) * factor;
  }

  double _calculateGPUStep() {
    double distance = (targetTime - currentTime).abs();
    
    double factor = distance > 5 ? 0.12 : 
                    distance > 2 ? 0.18 : 0.25;

    return (targetTime - currentTime) * factor;
  }

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }

  static void clearAll() {
    allParticles.clear();
  }
}
