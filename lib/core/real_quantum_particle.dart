import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class RealQuantumParticle {
  final int id;
  
  // 🔑 انٹیلیجنس سوئچ: یہ ڈیش بورڈ سے کنٹرول ہوگا
  static bool useClusterLogic = false; 
  
  // 🤝 تمام پارٹیکلز کی لسٹ تاکہ وہ ایک دوسرے کو "دیکھ" سکیں
  static List<RealQuantumParticle> allParticles = []; 

  double currentTime;
  final double targetTime = 20.0; // ہدف 20ms
  int stableCount = 0;

  // استحکام کی جانچ
  bool get isStable => (currentTime - targetTime).abs() <= 1.5;
  bool get isFullyStable => stableCount >= 5;

  // ماحولیاتی عوامل
  double environmentalNoise = 0.0;
  double deviceStability = 1.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = 60.0 + Random().nextDouble() * 40.0 {
    _initializeSensors();
    _startQuantumRandomness();
    
    // پارٹیکل کو لسٹ میں شامل کریں
    if (!allParticles.contains(this)) {
      allParticles.add(this);
    }
  }

  // 📡 موبائل سینسرز سے ڈیٹا لینا
  void _initializeSensors() {
    _sensorSub = accelerometerEvents.listen((AccelerometerEvent e) {
      // فون کی حرکت سے شور (Noise) پیدا کرنا
      environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.3;
    });
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      quantumRandomness = Random().nextDouble() * 2.0;
    });
  }

  // 🧠 اصل پروسیسنگ لاجک (NPU vs GPU)
  void apply35msLaw() {
    double step;

    if (useClusterLogic) {
      // 🚀 NPU موڈ: کلسٹرنگ (Group Intelligence)
      // پارٹیکلز 20-20 کے گروپس میں ایک دوسرے کی مدد کرتے ہیں
      int groupSize = 20;
      int start = (id ~/ groupSize) * groupSize; 
      double groupSum = 0;
      int count = 0;
      
      for (int i = start; i < start + groupSize && i < allParticles.length; i++) {
        groupSum += allParticles[i].currentTime;
        count++;
      }
      
      double groupAvg = count > 0 ? groupSum / count : currentTime;
      
      // گروپ لاجک شور (Noise) کو کم کر دیتی ہے
      step = (targetTime - groupAvg) * 0.25; 
    } else {
      // 🐢 GPU موڈ: انفرادی (Individual Brute Force)
      // ہر پارٹیکل تنہا لڑتا ہے، اس لیے شور اسے زیادہ پریشان کرتا ہے
      step = (targetTime - currentTime) * 0.12;
    }

    // 🌪️ شور اور بے ترتیبی کا اثر
    double jitter = (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise);
    
    // وقت اپ ڈیٹ کریں
    currentTime += step + jitter;

    // 🔓 اسکور اب آزاد ہے، کوئی کلیمپ (Clamp) نہیں ہے
    
    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  // میموری صاف کرنا
  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }

  // تمام پارٹیکلز کو صاف کرنے کے لیے (ری اسٹارٹ کے وقت استعمال کریں)
  static void clearAll() {
    allParticles.clear();
  }
}
