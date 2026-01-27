import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class MultiQuantumDashboard extends StatefulWidget {
  const MultiQuantumDashboard({super.key});

  @override
  State<MultiQuantumDashboard> createState() =>
      _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState
    extends State<MultiQuantumDashboard> {

  // ===== CONFIG =====
  static const int particleCount = 15;

  // ===== STATE =====
  late final List<RealQuantumParticle> particles;
  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "15-پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;

  final Stopwatch stopwatch = Stopwatch();
  Timer? _experimentTimer;

  // ===== INIT =====
  @override
  void initState() {
    super.initState();
    particles =
        List.generate(particleCount, (i) => RealQuantumParticle(i));
  }

  // ===== LOGIC =====
  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      stopwatch
        ..reset()
        ..start();

      systemStatus = isGPUMode
          ? "GPU (سپر کمپیوٹر) موڈ جاری..."
          : "NPU (کوانٹم) موڈ جاری...";

      statusColor = isGPUMode ? Colors.red : Colors.blue;
    });

    _experimentTimer =
        Timer.periodic(const Duration(milliseconds: 100), (_) {
      _updateSystemLogic();
    });
  }

  void _updateSystemLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // GPU موڈ میں مصنوعی بوجھ
      if (isGPUMode) {
        for (int i = 0; i < 30000; i++) {
          final _ = i * 0.001;
        }
      }

      for (final p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) {
          allStable = false;
        }
      }

      if (allStable) {
        _experimentTimer?.cancel();
        stopwatch.stop();
        isRunning = false;

        systemStatus =
            "کامیابی! تمام $particleCount مستحکم\n"
            "وقت: ${stopwatch.elapsed.inSeconds}s";

        statusColor = Colors.green;
      }
    });
  }

  // ===== UI PARTS =====
  Widget _buildModeSwitch() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "NPU",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: isGPUMode,
            onChanged: (val) => setState(() => isGPUMode = val),
            activeColor: Colors.red,
            inactiveThumbColor: Colors.blue,
          ),
          const Text(
            "GPU",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
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
          Text(
            "کوششیں: $totalAttempts",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            "وقت: ${stopwatch.elapsed.inSeconds}s",
            style: const TextStyle(
                color: Colors.cyanAccent, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.85),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            systemStatus,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
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

  // ===== BUILD =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
            Text("Quantum Master Lab ($particleCount)"),
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
              itemBuilder: (context, index) {
                final particle = particles[index];
                return Container(
                  decoration: BoxDecoration(
                    color: particle.isFullyStable
                        ? Colors.green
                        : Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      particle.currentTime
                          .toStringAsFixed(0),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 9),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }
}
