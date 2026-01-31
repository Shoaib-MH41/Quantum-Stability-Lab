import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;

  /// true = NPU (Cluster Logic) | false = GPU (Individual)
  static bool useClusterLogic = false;

  /// تمام پارٹیکلز کی لسٹ
  static final List<RealQuantumParticle> allParticles = [];

  // ==================== نیا: GPU اور NPU کے لیے الگ قوانین ====================
  
  /// GPU کا قانون
  static double gpuLaw = 25.0;
  
  /// NPU کا قانون  
  static double npuLaw = 35.0;
  
  /// موجودہ پراسیسر کے مطابق درست قانون واپس کرتا ہے
  double get targetTime => useClusterLogic ? npuLaw : gpuLaw;
  
  // ==================== اصل کوڈ ====================

  double currentTime;
  int stableCount = 0;

  /// استحکام کی پیمائش
  bool get isStable {
    final tolerance = useClusterLogic ? 2.0 : 1.5;
    return (currentTime - targetTime).abs() <= tolerance;
  }
  
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = useClusterLogic 
          ? 30.0 + Random().nextDouble() * 10.0
          : 20.0 + Random().nextDouble() * 5.0 {
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
      Duration(milliseconds: useClusterLogic ? 1500 : 1000),
      (_) => quantumRandomness = Random().nextDouble() * (useClusterLogic ? 1.2 : 0.8),
    );
  }

  // ------------------ قانون کا اطلاق ------------------

  /// نئی میتھڈ: applyLaw
  void applyLaw() {
    final step = useClusterLogic ? _calculateNPUStep() : _calculateGPUStep();
    
    final jitterMultiplier = useClusterLogic ? 1.3 : 0.7;
    final jitter = (Random().nextDouble() - 0.5) * 
                  (quantumRandomness + environmentalNoise) * jitterMultiplier;

    currentTime += step + jitter;
    
    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  /// پرانی میتھڈ کے لیے: apply35msLaw (تکمیلی)
  void apply35msLaw() {
    applyLaw(); // بس نئی میتھڈ کو کال کر دے
  }

  // ------------------ NPU حساب ------------------

  double _calculateNPUStep() {
    if (allParticles.length < 2) {
      final distance = targetTime - currentTime;
      return distance * 0.12;
    }

    final groupSize = min(12, max(8, allParticles.length ~/ 10));
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

    double factor;
    if (distance.abs() > 8) {
      factor = 0.08;
    } else if (distance.abs() > 4) {
      factor = 0.12;
    } else if (distance.abs() > 2) {
      factor = 0.18;
    } else {
      factor = 0.22 + (quantumRandomness * 0.1);
    }

    return distance * factor;
  }

  // ------------------ GPU حساب ------------------

  double _calculateGPUStep() {
    final distance = targetTime - currentTime;

    double factor;
    if (distance.abs() > 6) {
      factor = 0.15;
    } else if (distance.abs() > 3) {
      factor = 0.22;
    } else if (distance.abs() > 1) {
      factor = 0.28;
    } else {
      factor = 0.32;
    }

    final step = distance * factor;
    
    if (distance.abs() < 0.5) {
      return step * 0.7;
    }
    
    return step;
  }

  // ------------------ سادہ تجرباتی طریقے ------------------

  /// قوانین تبدیل کریں
  static void swapLaws() {
    final temp = gpuLaw;
    gpuLaw = npuLaw;
    npuLaw = temp;
    
    print('قوانین تبدیل: GPU = ${gpuLaw}ms, NPU = ${npuLaw}ms');
  }

  /// پراسیسر تبدیل کریں
  static void switchProcessor(bool useNpu) {
    useClusterLogic = useNpu;
    print('پراسیسر: ${useClusterLogic ? "NPU" : "GPU"}');
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
