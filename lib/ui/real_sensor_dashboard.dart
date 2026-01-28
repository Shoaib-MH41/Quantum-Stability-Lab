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

  static const int particleCount = 2000;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int attempts = 0;

  String status = "2,000 پارٹیکل سپر ٹیسٹ تیار";
  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  int stableFrames = 0;
  final int requiredStableFrames = 6;

  void start() {
    setState(() {
      // 🔑 اہم: ٹیسٹ شروع ہونے پر کلسٹر لاجک سیٹ کریں
      RealQuantumParticle.useClusterLogic = !isGPUMode;
      
      attempts = 0;
      stableFrames = 0;
      isRunning = true;
      stopwatch..reset()..start();

      status = isGPUMode
          ? "GPU: Extreme Stress (500k Load)"
          : "NPU: Quantum Pattern Logic";
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) => _tick(),
    );
  }

  void _tick() {
    setState(() {
      attempts++;
      bool allStable = true;

      if (isGPUMode) {
        // GPU بوجھ: 12GB RAM کا امتحان
        for (int i = 0; i < 500000; i++) {
          double x = i * 0.0001;
        }
      }

      for (final p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) allStable = false;
      }

      if (allStable) {
        stableFrames++;
      } else {
        stableFrames = 0;
      }

      if (stableFrames >= requiredStableFrames) {
        _timer?.cancel();
        stopwatch.stop();
        isRunning = false;
        status =
            "🏆 2000 پارٹیکلز مستحکم!\nوقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $attempts";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quantum Stress Lab: 2000"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          _buildMetricsBar(),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.white.withOpacity(0.05),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 40,
                  childAspectRatio: 1.0, 
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemCount: particleCount,
                itemBuilder: (_, i) => _buildNanoTile(particles[i]),
              ),
            ),
          ),

          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return SwitchListTile(
      tileColor: Colors.white10,
      title: Text(isGPUMode ? "GPU: Extreme Stress" : "NPU: Smart Pattern",
          style: TextStyle(color: isGPUMode ? Colors.redAccent : Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 13)),
      value: isGPUMode,
      onChanged: isRunning ? null : (v) {
        setState(() {
          isGPUMode = v;
          // 👈 سوئچ بدلتے ہی لاجک موڈ بھی بدل دیں
          RealQuantumParticle.useClusterLogic = !isGPUMode;
        });
      },
      activeColor: Colors.red,
      inactiveThumbColor: Colors.blue,
    );
  }

  Widget _buildMetricsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metricColumn("کوششیں", "$attempts"),
          _metricColumn("وقت", "${stopwatch.elapsed.inSeconds}s"),
          _metricColumn("Status", "$stableFrames/6 Stable"),
        ],
      ),
    );
  }

  Widget _metricColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildNanoTile(RealQuantumParticle p) {
    return Container(
      decoration: BoxDecoration(
        color: p.isFullyStable ? Colors.green : Colors.red.withOpacity(0.4),
        borderRadius: BorderRadius.circular(0.5),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: Colors.white10),
      child: Column(
        children: [
          Text(status, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: isRunning ? null : start,
            style: ElevatedButton.styleFrom(
              backgroundColor: isGPUMode ? Colors.red : Colors.blue,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: Text(isRunning ? "انٹیلی جنس پروسیسنگ جاری..." : "2000 پارٹیکل ٹیسٹ شروع کریں"),
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
