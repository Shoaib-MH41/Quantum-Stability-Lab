import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;
  static bool useClusterLogic = false; // NPU vs GPU
  static final List<RealQuantumParticle> allParticles = [];

  // قوانین (Laws)
  static double gpuLaw = 25.0; // آئن سٹائن
  static double npuLaw = 35.0; // نیلز بوہر

  // موجودہ ہدف حاصل کرنے کا فنکشن
  double get currentTarget => useClusterLogic ? npuLaw : gpuLaw;

  double currentTime;
  int stableCount = 0;

  bool get isStable {
    final bool isBohrLaw = currentTarget >= 30.0;
    final tolerance = isBohrLaw ? 2.0 : 1.5;
    return (currentTime - currentTarget).abs() <= tolerance;
  }

  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;
  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  // 🛠️ کنسٹرکٹر: 'this' ایرر کو یہاں ٹھیک کیا گیا ہے
  RealQuantumParticle(this.id) : currentTime = 0.0 {
    // ہدف کی بنیاد پر ابتدائی وقت سیٹ کریں
    currentTime = (currentTarget > 30) 
        ? 30.0 + Random().nextDouble() * 10.0 
        : 20.0 + Random().nextDouble() * 5.0;

    _initializeSensors();
    _startQuantumRandomness();
    allParticles.add(this);
  }

  void _initializeSensors() {
    try {
      _sensorSub = accelerometerEvents.listen((e) {
        environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.1;
      });
    } catch (e) {
      environmentalNoise = 0.5;
    }
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      quantumRandomness = Random().nextDouble() * 1.5;
    });
  }

  void applyLaw() {
    // ہارڈویئر کی اپنی لاجک لیکن ہدف (Target) کراس میچ ہو سکتا ہے
    final step = useClusterLogic ? _calculateNPUStep() : _calculateGPUStep();
    
    final bool isBohrLaw = currentTarget >= 30.0;
    final jitterMultiplier = isBohrLaw ? 1.3 : 0.7;
    
    final jitter = (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise) * jitterMultiplier;
    currentTime += step + jitter;

    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  void apply35msLaw() => applyLaw();

  double _calculateNPUStep() {
    if (allParticles.length < 2) return (currentTarget - currentTime) * 0.12;
    int groupSize = 10;
    int start = (id ~/ groupSize) * groupSize;
    int end = min(allParticles.length, start + groupSize);
    double sum = 0;
    int count = 0;
    for (int i = start; i < end; i++) {
      sum += allParticles[i].currentTime;
      count++;
    }
    double avg = count > 0 ? sum / count : currentTime;
    return (currentTarget - avg) * 0.18;
  }

  double _calculateGPUStep() => (currentTarget - currentTime) * 0.28;

  static void swapLaws() {
    final temp = gpuLaw;
    gpuLaw = npuLaw;
    npuLaw = temp;
  }

  // 🧹 صفائی کا فنکشن (ایرر ختم کرنے کے لیے)
  static void clearAll() {
    for (var p in allParticles) {
      p.dispose();
    }
    allParticles.clear();
  }

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
  }
}
