import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class RealQuantumParticle {
  final int id;
  double currentTime;
  double targetTime = 35.0;
  int stableCount = 0;
  bool get isStable => (currentTime >= 30 && currentTime <= 40);
  bool get isFullyStable => stableCount >= 3;
  
  // Real sensor data
  double? accelerometerValue;
  double? gyroscopeValue;
  double? magnetometerValue;
  double batteryLevel = 100.0;
  double networkLatency = 0.0;
  double cpuSimulatedLoad = 0.0;
  
  // Sensor subscriptions
  StreamSubscription? _accelerometerSub;
  StreamSubscription? _gyroscopeSub;
  StreamSubscription? _magnetometerSub;
  StreamSubscription? _batterySub;
  
  // Quantum coherence factors
  double environmentalNoise = 0.0;
  double deviceStability = 1.0;
  double quantumRandomness = 0.0;
  
  // Constructor
  RealQuantumParticle(this.id) : currentTime = Random().nextDouble() * 50 + 10 {
    _initializeSensors();
    _startQuantumRandomness();
  }
  
  void _initializeSensors() {
    // Accelerometer
    _accelerometerSub = accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerValue = (event.x.abs() + event.y.abs() + event.z.abs()) / 3;
      environmentalNoise = (accelerometerValue ?? 0) * 0.5;
    });
    
    // Gyroscope
    _gyroscopeSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroscopeValue = (event.x.abs() + event.y.abs() + event.z.abs()) / 3;
    });
    
    // Magnetometer
    _magnetometerSub = magnetometerEvents.listen((MagnetometerEvent event) {
      magnetometerValue = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z
      );
    });
    
    // Battery
    _batterySub = Battery().onBatteryStateChanged.listen((BatteryState state) {
      Battery().batteryLevel.then((level) {
        batteryLevel = level.toDouble();
        deviceStability = batteryLevel / 100.0;
      });
    });
  }
  
  void _startQuantumRandomness() {
    // Simulate quantum randomness from environment
    Timer.periodic(Duration(seconds: 2), (timer) {
      quantumRandomness = Random().nextDouble() * 10;
    });
  }
  
  Future<void> measureNetworkLatency() async {
    final stopwatch = Stopwatch()..start();
    try {
      final response = await http.get(
        Uri.parse('https://www.google.com'),
        headers: {'Cache-Control': 'no-cache'}
      ).timeout(Duration(seconds: 5));
      
      stopwatch.stop();
      networkLatency = stopwatch.elapsedMilliseconds.toDouble();
      
      // Network quality affects quantum stability
      if (networkLatency > 1000) {
        environmentalNoise += 5.0;
      }
    } catch (e) {
      networkLatency = 9999.0; // Connection failed
      environmentalNoise += 10.0;
    }
  }
  
  void apply35msLaw() {
    // Store previous time for analysis
    final double previousTime = currentTime;
    
    // 1. Base 35ms law (original algorithm)
    double adjustment = (targetTime - currentTime) * 0.1;
    
    // 2. Add real sensor effects
    if (accelerometerValue != null && accelerometerValue! > 1.0) {
      // Movement causes quantum disturbance
      adjustment += Random().nextDouble() * accelerometerValue! * 2;
    }
    
    // 3. Battery effect (low battery = more instability)
    if (batteryLevel < 20) {
      adjustment += Random().nextDouble() * 5;
    }
    
    // 4. Network latency effect
    if (networkLatency > 500) {
      adjustment += networkLatency / 1000;
    }
    
    // 5. Quantum randomness (Heisenberg uncertainty)
    adjustment += (Random().nextDouble() - 0.5) * quantumRandomness;
    
    // 6. Environmental noise
    adjustment += (Random().nextDouble() - 0.5) * environmentalNoise;
    
    // 7. Device stability factor
    adjustment *= deviceStability;
    
    // Apply adjustment
    currentTime += adjustment;
    
    // Ensure bounds
    currentTime = currentTime.clamp(10.0, 60.0);
    
    // Update stable count
    if (isStable) {
      stableCount = min(stableCount + 1, 3);
    } else {
      stableCount = max(stableCount - 1, 0);
    }
    
    // Haptic feedback on significant changes
    if ((currentTime - previousTime).abs() > 10) {
      _triggerQuantumVibration();
    }
  }
  
  void _triggerQuantumVibration() {
    if (isFullyStable) {
      // Success vibration pattern
      Vibration.vibrate(pattern: [50, 100, 50, 100]);
    } else if (isStable) {
      // Stable vibration
      Vibration.vibrate(duration: 50);
    }
  }
  
  double getQuantumCoherence() {
    // Calculate quantum coherence level (0-1)
    double coherence = 1.0;
    
    // Environmental factors reduce coherence
    coherence -= environmentalNoise / 50;
    coherence -= (1.0 - deviceStability) * 0.3;
    
    // Network issues reduce coherence
    if (networkLatency > 1000) coherence -= 0.2;
    
    // Movement reduces coherence
    if (accelerometerValue != null && accelerometerValue! > 2.0) {
      coherence -= 0.1;
    }
    
    return coherence.clamp(0.0, 1.0);
  }
  
  Map<String, dynamic> toSensorData() {
    return {
      'particle_id': id,
      'current_time': currentTime,
      'is_stable': isStable,
      'is_fully_stable': isFullyStable,
      'accelerometer': accelerometerValue,
      'gyroscope': gyroscopeValue,
      'magnetometer': magnetometerValue,
      'battery_level': batteryLevel,
      'network_latency': networkLatency,
      'quantum_coherence': getQuantumCoherence(),
      'environmental_noise': environmentalNoise,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  void dispose() {
    _accelerometerSub?.cancel();
    _gyroscopeSub?.cancel();
    _magnetometerSub?.cancel();
    _batterySub?.cancel();
  }
}
