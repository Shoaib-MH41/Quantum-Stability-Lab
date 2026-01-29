import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;

  /// true = NPU (Bohr) | false = GPU (Einstein)
  static bool useClusterLogic = false;

  static final List<RealQuantumParticle> allParticles = [];

  double currentTime;
  final double targetTime = 30.0;

  int stableCount = 0;

  // --- Environment ---
  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = 18.0 + Random().nextDouble() * 24.0 {
    _initSensors();
    _initQuantumNoise();
    allParticles.add(this);
  }

  // ------------------ Stability ------------------

  bool get isStable =>
      (currentTime - targetTime).abs() <= 1.5;

  bool get isFullyStable =>
      stableCount >= 3;

  // ------------------ Sensors ------------------

  void _initSensors() {
    _sensorSub = accelerometerEvents.listen((e) {
      environmentalNoise =
          (e.x.abs() + e.y.abs() + e.z.abs()) * 0.08;
    });
  }

  void _initQuantumNoise() {
    _randomTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => quantumRandomness = Random().nextDouble(),
    );
  }

  // ------------------ Core Law ------------------

  applyStabilizationLaw();
    final step = useClusterLogic
        ? _npuStep()
        : _gpuStep();

    final jitter =
        (Random().nextDouble() - 0.5) *
        (environmentalNoise + quantumRandomness);

    currentTime += step + jitter;

    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  // ------------------ GPU (Einstein) ------------------

  double _gpuStep() {
    final distance = targetTime - currentTime;

    final factor =
        distance.abs() > 8 ? 0.12 :
        distance.abs() > 3 ? 0.18 : 0.25;

    return distance * factor;
  }

  // ------------------ NPU (Bohr) ------------------

  double _npuStep() {
    if (allParticles.length < 3) {
      return (targetTime - currentTime) * 0.15;
    }

    // 🔑 index-based neighborhood (NO ID BIAS)
    final index = allParticles.indexOf(this);
    final radius = 5;

    final start = max(0, index - radius);
    final end = min(allParticles.length, index + radius + 1);

    double sum = 0;
    for (int i = start; i < end; i++) {
      sum += allParticles[i].currentTime;
    }

    final groupAvg = sum / (end - start);
    final distance = targetTime - groupAvg;

    final coherence =
        distance.abs() > 6 ? 0.10 :
        distance.abs() > 3 ? 0.16 : 0.22;

    return distance * coherence;
  }

  // ------------------ Cleanup ------------------

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }

  static void clearAll() {
    allParticles.clear();
  }
}
