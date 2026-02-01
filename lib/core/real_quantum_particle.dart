import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;

  /// true = NPU ہارڈویئر | false = GPU ہارڈویئر
  static bool useClusterLogic = false;

  /// تمام پارٹیکلز کی لسٹ
  static final List<RealQuantumParticle> allParticles = [];

  // ==================== قوانین (Laws) ====================
  
  static double gpuLaw = 25.0; // آئن سٹائن کا قانون (ابتدا میں)
  static double npuLaw = 35.0; // نیلز بوہر کا قانون (ابتدا میں)
  
  // 🔄 کراس ٹیسٹ لاجک: ہارڈویئر اب قانون کا محتاج نہیں رہا
  double get targetTime => useClusterLogic ? npuLaw : gpuLaw;
  
  // ==================== کور اسٹیٹ ====================

  double currentTime;
  int stableCount = 0;

  bool get isStable {
    // بوہر کی منطق میں لچک (Tolerance) زیادہ ہوتی ہے
    final bool isBohrLaw = targetTime >= 30.0; 
    final tolerance = isBohrLaw ? 2.0 : 1.5;
    return (currentTime - targetTime).abs() <= tolerance;
  }
  
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = (targetTime > 30) 
          ? 30.0 + Random().nextDouble() * 10.0
          : 20.0 + Random().nextDouble() * 5.0 {
    _initializeSensors();
    _startQuantumRandomness();
    allParticles.add(this);
  }

  // ------------------ قانون کا اطلاق (The Cross-Match) ------------------

  void applyLaw() {
    // 🧠 اصل تبدیلی: ہارڈویئر (NPU/GPU) اپنی اپنی لاجک استعمال کریں گے، 
    // لیکن ہدف (Target) وہ ہوگا جو آپ نے سیٹ کیا ہے (بوہر یا آئن سٹائن)
    final step = useClusterLogic ? _calculateNPUStep() : _calculateGPUStep();
    
    // سنسر کا اثر قانون کے مطابق بدلتا ہے
    final bool isBohrLaw = targetTime >= 30.0;
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

  // ------------------ پروسیسر کی اپنی خصوصیات ------------------

  double _calculateNPUStep() {
    // NPU ہمیشہ کلسٹرنگ (گروپ انٹیلیجنس) استعمال کرے گا، چاہے قانون کوئی بھی ہو
    if (allParticles.length < 2) return (targetTime - currentTime) * 0.12;

    final groupSize = 10;
    final start = (id ~/ groupSize) * groupSize;
    final end = min(allParticles.length, start + groupSize);

    double groupSum = 0;
    int count = 0;
    for (int i = start; i < end; i++) {
      groupSum += allParticles[i].currentTime;
      count++;
    }

    final groupAvg = count > 0 ? groupSum / count : currentTime;
    return (targetTime - groupAvg) * 0.18;
  }

  double _calculateGPUStep() {
    // GPU ہمیشہ انفرادی طاقت (Brute Force) استعمال کرے گا، چاہے قانون کوئی بھی ہو
    final distance = targetTime - currentTime;
    return distance * 0.28;
  }

  // ------------------ کنٹرول میتھڈز ------------------

  static void swapLaws() {
    final temp = gpuLaw;
    gpuLaw = npuLaw;
    npuLaw = temp;
    print('قوانین تبدیل: ہدف بدل گئے ہیں!');
  }

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }
}
