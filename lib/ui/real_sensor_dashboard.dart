import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class RealSensorDashboard extends StatefulWidget {
  @override
  State<RealSensorDashboard> createState() =>
      _RealSensorDashboardState();
}

class _RealSensorDashboardState
    extends State<RealSensorDashboard> {

  static const int particleCount = 15;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int attempts = 0;

  String status = "موڈ منتخب کریں";
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  int stableFrames = 0;
  final int requiredStableFrames = 6;

  void start() {
    setState(() {
      attempts = 0;
      stableFrames = 0;
      isRunning = true;
      stopwatch
        ..reset()
        ..start();

      status = isGPUMode
          ? "GPU سینسر لوڈ"
          : "NPU سینسر پیٹرن";
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 80),
      (_) => _tick(),
    );
  }

  void _tick() {
    setState(() {
      attempts++;
      bool stable = true;

      if (isGPUMode) {
        for (int i = 0; i < 20000; i++) {
          double x = i * 0.001;
        }
      }

      for (final p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) stable = false;
      }

      if (stable) {
        stableFrames++;
      } else {
        stableFrames = 0;
      }

      if (stableFrames >= requiredStableFrames) {
        _timer?.cancel();
        stopwatch.stop();
        isRunning = false;
        status =
            "✅ استحکام حاصل\n${stopwatch.elapsed.inSeconds}s";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Real Sensor Test"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text("GPU موڈ",
                style: TextStyle(color: Colors.white)),
            value: isGPUMode,
            onChanged: (v) => setState(() => isGPUMode = v),
          ),
          Text("کوششیں: $attempts",
              style: const TextStyle(color: Colors.white)),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: particles.map((p) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  color: p.isFullyStable
                      ? Colors.green
                      : Colors.red.withOpacity(0.5),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: isRunning ? null : start,
            child: Text(isRunning ? "چل رہا ہے..." : "شروع کریں"),
          ),
          const SizedBox(height: 10),
          Text(status,
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
