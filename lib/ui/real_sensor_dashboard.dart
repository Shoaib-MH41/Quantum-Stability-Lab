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

  // 1. تعداد 100 کر دی گئی ہے - اب آپ کا اصل چیلنج شروع ہوتا ہے
  static const int particleCount = 100;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int attempts = 0;

  String status = "100 پارٹیکل ٹیسٹ تیار ہے";
  final Stopwatch stopwatch = Stopwatch();
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
          ? "GPU موڈ: شدید بوجھ (Brute Force)"
          : "NPU موڈ: متوازی پیٹرن (Pattern Logic)";
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 80),
      (_) => _tick(),
    );
  }

  void _tick() {
    setState(() {
      attempts++;
      bool allStable = true;

      // 100 پارٹیکلز کے ساتھ GPU پر دباؤ ڈالنے کے لیے بوجھ برقرار رکھا گیا ہے
      if (isGPUMode) {
        for (int i = 0; i < 50000; i++) {
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
            "✅ 100 پارٹیکلز مستحکم!\nوقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $attempts";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("NPU vs GPU: 100 Particle Lab"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          _buildMetricsBar(),

          // 100 پارٹیکلز کے لیے 10 کالمز کا گرڈ
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10, // 10 کالم تاکہ سب ایک اسکرین پر نظر آئیں
                childAspectRatio: 1.0, 
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: particleCount,
              itemBuilder: (_, i) => _buildSmallParticleTile(particles[i]),
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
      title: Text(isGPUMode ? "GPU: Maximum Load" : "NPU: Parallel Pattern",
          style: TextStyle(color: isGPUMode ? Colors.redAccent : Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
      value: isGPUMode,
      onChanged: isRunning ? null : (v) => setState(() => isGPUMode = v),
      activeColor: Colors.red,
      inactiveThumbColor: Colors.blue,
    );
  }

  Widget _buildMetricsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metricColumn("کوششیں", "$attempts"),
          _metricColumn("وقت", "${stopwatch.elapsed.inSeconds}s"),
          _metricColumn("Stability", "$stableFrames/6"),
        ],
      ),
    );
  }

  Widget _metricColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 100 پارٹیکلز کے لیے چھوٹا ٹائل
  Widget _buildSmallParticleTile(RealQuantumParticle p) {
    return Container(
      decoration: BoxDecoration(
        color: p.isFullyStable ? Colors.green : Colors.red.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          p.currentTime.toStringAsFixed(0), // جگہ بچانے کے لیے اعشاریہ ختم
          style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Colors.white10),
      child: Column(
        children: [
          Text(status, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isRunning ? null : start,
            style: ElevatedButton.styleFrom(
              backgroundColor: isGPUMode ? Colors.red : Colors.blue,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: Text(isRunning ? "پروسیسنگ جاری ہے..." : "100 پارٹیکل ٹیسٹ شروع کریں"),
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
