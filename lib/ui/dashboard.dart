import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class MultiQuantumDashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() =>
      _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState
    extends State<MultiQuantumDashboard> {

  static const int particleCount = 30;

  List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "30-پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;

  Stopwatch stopwatch = Stopwatch();
  Timer? _experimentTimer;

  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      stopwatch.reset();
      stopwatch.start();

      systemStatus = isGPUMode
          ? "GPU (سپر کمپیوٹر) موڈ جاری..."
          : "NPU (کوانٹم) موڈ جاری...";

      statusColor = isGPUMode ? Colors.red : Colors.blue;
    });

    _experimentTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      updateSystemLogic();
    });
  }

  void updateSystemLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // GPU موڈ میں مصنوعی بوجھ
      if (isGPUMode) {
        for (int i = 0; i < 30000; i++) {
          double x = i * 0.001;
        }
      }

      for (var p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) allStable = false;
      }

      if (allStable) {
        _experimentTimer?.cancel();
        stopwatch.stop();
        isRunning = false;

        systemStatus =
            "کامیابی! تمام 30 مستحکم\nوقت: ${stopwatch.elapsed.inSeconds}s";

        statusColor = Colors.green;
      }
    });
  }

  Widget _buildModeSwitch() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("NPU",
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold)),
          Switch(
            value: isGPUMode,
            onChanged: (val) => setState(() => isGPUMode = val),
            activeColor: Colors.red,
            inactiveThumbColor: Colors.blue,
          ),
          const Text("GPU",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTopMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("کوششیں: $totalAttempts",
              style:
                  const TextStyle(color: Colors.white, fontSize: 16)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s",
              style: const TextStyle(
                  color: Colors.cyanAccent, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.8),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(systemStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              isRunning ? "پروسیسنگ..." : "ٹیسٹ شروع کریں",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quantum Master Lab (60)"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _buildModeSwitch(),
          _buildTopMetrics(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: particleCount,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: particles[index].isFullyStable
                      ? Colors.green
                      : Colors.red.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    particles[index]
                        .currentTime
                        .toStringAsFixed(0),
                    style: const TextStyle(
                        color: Colors.white, fontSize: 9),
                  ),
                ),
              ),
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }
}
