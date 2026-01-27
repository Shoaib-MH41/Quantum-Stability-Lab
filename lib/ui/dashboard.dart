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

  static const int particleCount = 15;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "15 پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;

  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  /// 🔑 اصل FIX
  int stableTicksRequired = 6;
  int currentStableTicks = 0;

  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      currentStableTicks = 0;
      stopwatch
        ..reset()
        ..start();

      systemStatus = isGPUMode
          ? "GPU موڈ (Brute Force)"
          : "NPU موڈ (Pattern Logic)";

      statusColor = isGPUMode ? Colors.red : Colors.blue;
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => _updateLogic(),
    );
  }

  void _updateLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // GPU = مصنوعی heavy load
      if (isGPUMode) {
        for (int i = 0; i < 30000; i++) {
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
            "✅ تمام $particleCount مستحکم\n"
            "وقت: ${stopwatch.elapsed.inSeconds}s";

        statusColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quantum Test Dashboard"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _modeSwitch(),
          _topMetrics(),
          Expanded(child: _particleGrid()),
          _bottomControls(),
        ],
      ),
    );
  }

  Widget _modeSwitch() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("NPU",
              style: TextStyle(color: Colors.blue)),
          Switch(
            value: isGPUMode,
            onChanged: (v) => setState(() => isGPUMode = v),
          ),
          const Text("GPU",
              style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _topMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("کوششیں: $totalAttempts",
              style: const TextStyle(color: Colors.white)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s",
              style: const TextStyle(color: Colors.cyanAccent)),
        ],
      ),
    );
  }

  Widget _particleGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: particleCount,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: particles[i].isFullyStable
              ? Colors.green
              : Colors.red.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _bottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: statusColor.withOpacity(0.85),
      child: Column(
        children: [
          Text(systemStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            child: Text(isRunning ? "چل رہا ہے..." : "ٹیسٹ شروع کریں"),
          ),
        ],
      ),
    );
  }
}
