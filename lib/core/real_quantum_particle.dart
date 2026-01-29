import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart'; // موبائل سینسرز کے لیے

class RealQuantumParticle {
  final int id;
  
  // سوئچ: NPU (Cluster Logic) بمقابلہ GPU (Individual)
  static bool useClusterLogic = false;
  
  // تمام پارٹیکلز کی لسٹ (اجتماعی مشاہدے کے لیے)
  static List<RealQuantumParticle> allParticles = [];

  double currentTime;
  final double targetTime = 30.0; // آپ کا 30ms کا قانون
  int stableCount = 0;

  bool get isStable => (currentTime - targetTime).abs() <= 1.5;
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0; // بیرونی شور (موبائل کی حرکت)
  double quantumRandomness = 0.0; // کوانٹم رینڈم لہریں

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id) : currentTime = 18.0 + Random().nextDouble() * 4.0 {
    _initializeSensors();
    _startQuantumRandomness();
    
    if (!allParticles.contains(this)) {
      allParticles.add(this);
    }
  }

  // سینسرز کو متحرک کرنا (ٹرین یا کار کے حادثے کا ڈیٹا یہاں سے شروع ہوتا ہے)
  void _initializeSensors() {
    try {
      _sensorSub = accelerometerEvents.listen((AccelerometerEvent e) {
        // موبائل کو ہلانے سے پیدا ہونے والی لہروں کا حساب
        environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.1;
      });
    } catch (e) {
      // اگر سینسر کام نہ کرے تو رینڈم ڈیٹا
      environmentalNoise = Random().nextDouble() * 0.5;
    }
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      quantumRandomness = Random().nextDouble() * 1.0;
    });
  }

  // ⚛️ قانونِ تثبیت کا اطلاق (30ms Law)
  void apply35msLaw() {
    double step;

    if (useClusterLogic) {
      // NPU: بوہر کا انداز (گروپ انٹیلی جنس)
      step = _calculateNPUStep();
    } else {
      // GPU: آئنسٹائن کا انداز (انفرادی طاقت)
      step = _calculateGPUStep();
    }

    // جھٹکا (Jitter): سینسرز اور کوانٹم شور کا ملاپ
    double jitter = (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise);
    
    currentTime += step + jitter;

    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  // 🧠 NPU لاجک: پورے گروپ کا مشاہدہ
  double _calculateNPUStep() {
    if (allParticles.length < 2) {
      return (targetTime - currentTime) * 0.15;
    }

    // 10 پارٹیکلز کے گروپ میں معلومات کا تبادلہ
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

  // ⚡ GPU لاجک: انفرادی بروٹ فورس
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
