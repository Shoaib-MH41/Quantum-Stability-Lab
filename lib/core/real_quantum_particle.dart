import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class RealQuantumParticle {
  final int id;
  static bool useClusterLogic = false; // NPU vs GPU سوئچ
  static List<RealQuantumParticle> allParticles = []; // کلسٹرنگ کے لیے

  double currentTime;
  final double targetTime = 20.0;
  int stableCount = 0;

  bool get isStable => (currentTime - targetTime).abs() <= 1.5;
  bool get isFullyStable => stableCount >= 5;

  double environmentalNoise = 0.0;
  double deviceStability = 1.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = 60.0 + Random().nextDouble() * 40.0 {
    _initializeSensors();
    _startQuantumRandomness();
    allParticles.add(this);
  }

  void _initializeSensors() {
    _sensorSub = accelerometerEvents.listen((AccelerometerEvent e) {
      // سنسر ڈیٹا سے شور (Noise) پیدا کرنا
      environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.2;
    });
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      quantumRandomness = Random().nextDouble() * 1.5;
    });
  }

  // 🧠 اصل انٹیلیجنس لاجک
  void apply35msLaw() {
    double step;

    if (useClusterLogic) {
      // 🚀 NPU موڈ: کلسٹرنگ (Group Intelligence)
      // اپنے قریبی 5 پارٹیکلز کا اوسط نکال کر گروپ کی طرح حرکت کرنا
      int start = (id ~/ 10) * 10; 
      double groupSum = 0;
      int count = 0;
      for (int i = start; i < start + 10 && i < allParticles.length; i++) {
        groupSum += allParticles[i].currentTime;
        count++;
      }
      double groupAvg = groupSum / count;
      
      // گروپ کی سمت میں تیزی سے جانا
      step = (targetTime - groupAvg) * 0.25; 
    } else {
      // 🐢 GPU موڈ: انفرادی (Individual Brute Force)
      // ہر پارٹیکل صرف اپنا سوچتا ہے، جس سے شور (Noise) زیادہ اثر کرتا ہے
      step = (targetTime - currentTime) * 0.12;
    }

    // سنسر کا اثر (ماحول کا شور)
    double jitter = (Random().nextDouble() - 0.5) * (quantumRandomness + environmentalNoise);
    
    // اپڈیٹ
    currentTime += step + jitter;

    // 🔓 اسکور اب آزاد ہے (No Clamp)
    
    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(0, stableCount - 1);
    }
  }

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }
}
