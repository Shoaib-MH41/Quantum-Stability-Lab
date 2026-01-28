import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class RealQuantumParticle {
  final int id;

  // Core quantum state
  double currentTime;
  final double targetTime = 25.0;

  int stableCount = 0;

  // ---- STABILITY (FIXED) ----
  bool get isStable =>
      currentTime >= targetTime - 1.5 &&
      currentTime <= targetTime + 1.5;

  bool get isFullyStable => stableCount >= 5;

  // ---- SENSOR DATA ----
  double? accelerometerValue;
  double? gyroscopeValue;
  double? magnetometerValue;
  double batteryLevel = 100.0;
  double networkLatency = 0.0;

  // ---- QUANTUM FACTORS ----
  double environmentalNoise = 0.0;
  double deviceStability = 1.0;
  double quantumRandomness = 0.0;

  // ---- SUBSCRIPTIONS ----
  StreamSubscription? _accelerometerSub;
  StreamSubscription? _gyroscopeSub;
  StreamSubscription? _magnetometerSub;
  StreamSubscription? _batterySub;

  Timer? _randomTimer;

  // ---- CONSTRUCTOR ----
  RealQuantumParticle(this.id)
      : currentTime = Random().nextDouble() * 20 + 20 {
    _initializeSensors();
    _startQuantumRandomness();
  }

  // ---------------- SENSORS ----------------

  void _initializeSensors() {
    _accelerometerSub =
        accelerometerEvents.listen((AccelerometerEvent e) {
      accelerometerValue =
          (e.x.abs() + e.y.abs() + e.z.abs()) / 3;
      environmentalNoise = (accelerometerValue ?? 0) * 0.3;
    });

    _gyroscopeSub = gyroscopeEvents.listen((GyroscopeEvent e) {
      gyroscopeValue =
          (e.x.abs() + e.y.abs() + e.z.abs()) / 3;
    });

    _magnetometerSub =
        magnetometerEvents.listen((MagnetometerEvent e) {
      magnetometerValue =
          sqrt(e.x * e.x + e.y * e.y + e.z * e.z);
    });

    _batterySub =
        Battery().onBatteryStateChanged.listen((_) async {
      batteryLevel = (await Battery().batteryLevel).toDouble();
      deviceStability = (batteryLevel / 100).clamp(0.4, 1.0);
    });
  }

  void _startQuantumRandomness() {
    _randomTimer =
        Timer.periodic(const Duration(seconds: 2), (_) {
      quantumRandomness = Random().nextDouble() * 2.0;
    });
  }

  // ---------------- NETWORK ----------------

  Future<void> measureNetworkLatency() async {
    final sw = Stopwatch()..start();
    try {
      await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 4));
      sw.stop();
      networkLatency = sw.elapsedMilliseconds.toDouble();
    } catch (_) {
      networkLatency = 3000;
    }
  }

  // ---------------- CORE LAW ----------------

  void apply35msLaw() {
    final double previous = currentTime;

    // ---- CORE PULL (NPU STYLE) ----
    double diff = targetTime - currentTime;

    // Adaptive step (slow near target)
    double step = diff * 0.18;

    // ---- SENSOR DISTURBANCE (LIMITED) ----
    if (!isFullyStable) {
      step += (Random().nextDouble() - 0.5) *
          (quantumRandomness + environmentalNoise) *
          0.4;
    }

    // ---- BATTERY EFFECT ----
    step *= deviceStability;

    // ---- APPLY ----
    currentTime += step;
    currentTime = currentTime.clamp(10.0, 60.0);

    // ---- TIME DOMAIN STABILITY ----
    if (isStable) {
      stableCount++;
    } else {
      stableCount = max(stableCount - 1, 0);
    }

    // ---- DAMPING AFTER STABLE ----
    if (isFullyStable) {
      currentTime += (targetTime - currentTime) * 0.05;
    }

    // ---- HAPTIC ----
    if ((currentTime - previous).abs() > 8) {
      _vibrate();
    }
  }

  void _vibrate() {
    if (isFullyStable) {
      Vibration.vibrate(pattern: [40, 80, 40]);
    } else if (isStable) {
      Vibration.vibrate(duration: 30);
    }
  }

  // ---------------- METRICS ----------------

  double getQuantumCoherence() {
    double c = 1.0;
    c -= environmentalNoise / 30;
    c -= (1.0 - deviceStability) * 0.3;
    if (networkLatency > 1500) c -= 0.2;
    return c.clamp(0.0, 1.0);
  }

  Map<String, dynamic> toSensorData() => {
        'id': id,
        'time': currentTime,
        'stable': isStable,
        'fullyStable': isFullyStable,
        'coherence': getQuantumCoherence(),
      };

  void dispose() {
    _accelerometerSub?.cancel();
    _gyroscopeSub?.cancel();
    _magnetometerSub?.cancel();
    _batterySub?.cancel();
    _randomTimer?.cancel();
  }
}
