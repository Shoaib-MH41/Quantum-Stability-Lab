import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class MultiQuantumDashboard extends StatefulWidget {
  @override
  State<MultiQuantumDashboard> createState() =>
      _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState
    extends State<MultiQuantumDashboard> {

  static const int particleCount = 2000;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "2,000 پارٹیکل کوانٹم لیب تیار";
  Color statusColor = Colors.grey;

  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  int stableTicksRequired = 6;
  int currentStableTicks = 0;

  void startExperiment() {
    setState(() {
      // 🔑 کلسٹر لاجک کو یہاں سے کنٹرول کریں
      RealQuantumParticle.useClusterLogic = !isGPUMode;
      
      isRunning = true;
      totalAttempts = 0;
      currentStableTicks = 0;
      stopwatch..reset()..start();

      systemStatus = isGPUMode
          ? "NPU: Extreme Stress (200k Math Load)"
          : "GPU: Parallel Pattern Logic";

      statusColor = isGPUMode ? Colors.redAccent : Colors.blueAccent;
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) => _updateLogic(),
    );
  }

  void _updateLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // 🔥 GPU موڈ میں 5 لاکھ لوپس کا شدید بوجھ
      if (isGPUMode) {
        for (int i = 0; i < 500000; i++) {
          double x = i * 0.0001;
        }
      }

      for (final p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) {
          allStable = false;
        }
      }

      if (allStable) {
        currentStableTicks++;
      } else {
        currentStableTicks = 0;
      }

      if (currentStableTicks >= stableTicksRequired) {
        _timer?.cancel();
        stopwatch.stop();
        isRunning = false;

        systemStatus =
            "🏆 2000 پارٹیکلز مستحکم!\n"
            "وقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $totalAttempts";

        statusColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quantum Core: 2000 Test"),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Column(
        children: [
          _modeSwitch(),
          _topMetrics(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
              ),
              child: _particleGrid(),
            ),
          ),
          _bottomControls(),
        ],
      ),
    );
  }

  Widget _modeSwitch() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("NPU", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          Switch(
            value: isGPUMode,
            activeColor: Colors.red,
            onChanged: isRunning ? null : (v) {
              setState(() {
                isGPUMode = v;
                // 👈 سوئچ بدلتے ہی کلسٹرنگ موڈ کو بھی اپ ڈیٹ کریں
                RealQuantumParticle.useClusterLogic = !isGPUMode;
              });
            },
          ),
          const Text("GPU", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _topMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Attempts: $totalAttempts", style: const TextStyle(color: Colors.white, fontSize: 13)),
          Text("Time: ${stopwatch.elapsed.inSeconds}s", style: const TextStyle(color: Colors.cyanAccent, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _particleGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 40,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: particleCount,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: particles[i].isFullyStable
              ? Colors.green
              : Colors.red.withOpacity(0.4),
          borderRadius: BorderRadius.circular(0.5),
        ),
      ),
    );
  }

  Widget _bottomControls() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(systemStatus, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: Text(isRunning ? "پروسیسنگ..." : "2000 پارٹیکل ٹیسٹ شروع کریں"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
