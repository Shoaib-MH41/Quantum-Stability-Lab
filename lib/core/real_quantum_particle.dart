import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;

  /// true = NPU (Cluster Logic) | false = GPU (Individual)
  static bool useClusterLogic = false;

  /// تمام پارٹیکلز کی لسٹ
  static final List<RealQuantumParticle> allParticles = [];

  double currentTime;
  final double targetTime = 30.0; // 30ms کا قانون
  int stableCount = 0;

  bool get isStable => (currentTime - targetTime).abs() <= 1.5;
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0; // بیرونی شور
  double quantumRandomness = 0.0; // کوانٹم رینڈم لہریں

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = 18.0 + Random().nextDouble() * 4.0 {
    _initializeSensors();
    _startQuantumRandomness();
    allParticles.add(this);
  }

  // ------------------ سینسرز ------------------

  void _initializeSensors() {
    try {
      _sensorSub = accelerometerEvents.listen((e) {
        environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.1;
      });
    } catch (e) {
      environmentalNoise = Random().nextDouble() * 0.5;
    }
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => quantumRandomness = Random().nextDouble() * 1.0,
    );
  }

  // ------------------ 35ms قانون ------------------

  void apply35msLaw() {
    final step = useClusterLogic ? _calculateNPUStep() : _calculateGPUStep();

    final jitter =
        (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise);

    currentTime += step + jitter;

    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  // ------------------ NPU (گروپ انٹیلی جنس) ------------------

  double _calculateNPUStep() {
    if (allParticles.length < 2) {
      return (targetTime - currentTime) * 0.15;
    }

    // 10 پارٹیکلز کے گروپ میں معلومات کا تبادلہ
    final groupSize = min(10, allParticles.length);
    final start = max(0, id - groupSize ~/ 2);
    final end = min(allParticles.length, start + groupSize);

    double groupSum = 0;
    int count = 0;

    for (int i = start; i < end; i++) {
      groupSum += allParticles[i].currentTime;
      count++;
    }

    final groupAvg = count > 0 ? groupSum / count : currentTime;
    final distance = targetTime - groupAvg;

    final factor = distance.abs() > 5
        ? 0.1
        : distance.abs() > 2
            ? 0.15
            : 0.2;

    return distance * factor;
  }

  // ------------------ GPU (انفرادی) ------------------

  double _calculateGPUStep() {
    final distance = targetTime - currentTime;

    final factor = distance.abs() > 5
        ? 0.12
        : distance.abs() > 2
            ? 0.18
            : 0.25;

    return distance * factor;
  }

  // ------------------ اضافی method اگر ضرورت ہو ------------------
  
  // اگر آپ کو applyStabilizationLaw() کی ضرورت ہے تو:
  void applyStabilizationLaw() {
    // یہ apply35msLaw() کا ہی ایک متبادل نام ہے
    apply35msLaw();
  }

  // ------------------ صفائی ------------------

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }

  static void clearAll() {
    for (var particle in allParticles.toList()) {
      particle.dispose();
    }
    allParticles.clear();
  }
}
