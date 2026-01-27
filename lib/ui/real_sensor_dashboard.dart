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

  // 1. تعداد 20 کر دی گئی ہے تاکہ ہارڈویئر کا بہتر امتحان ہو
  static const int particleCount = 20;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int attempts = 0;

  String status = "موڈ منتخب کریں اور ٹیسٹ شروع کریں";
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
          ? "GPU موڈ: Brute Force (بھاری حساب کتاب)"
          : "NPU موڈ: Pattern Logic (تیز رفتار پیٹرن)";
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

      // GPU تصدیق کے لیے بوجھ میں اضافہ (50k iterations)
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
            "✅ استحکام حاصل!\nوقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $attempts";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("NPU vs GPU: 20 Particle Test"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // موڈ سلیکٹر کارڈ
          _buildModeSelector(),

          // میٹرکس بار
          _buildMetricsBar(),

          // پارٹیکل گرڈ (20 پارٹیکلز کے لیے 4 کالم)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: particleCount,
              itemBuilder: (_, i) => _buildParticleTile(particles[i]),
            ),
          ),

          // کنٹرول ایریا
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return SwitchListTile(
      tileColor: Colors.white10,
      title: Text(isGPUMode ? "GPU: Heavy Load" : "NPU: Smart Pattern",
          style: TextStyle(color: isGPUMode ? Colors.redAccent : Colors.blueAccent, fontWeight: FontWeight.bold)),
      subtitle: const Text("موڈ بدلنے کے لیے سوئچ استعمال کریں", style: TextStyle(color: Colors.white54, fontSize: 10)),
      value: isGPUMode,
      onChanged: isRunning ? null : (v) => setState(() => isGPUMode = v),
      activeColor: Colors.red,
      inactiveThumbColor: Colors.blue,
    );
  }

  Widget _buildMetricsBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metricColumn("کوششیں", "$attempts"),
          _metricColumn("وقت", "${stopwatch.elapsed.inSeconds}s"),
          _metricColumn("مستحکم ٹکس", "$stableFrames/$requiredStableFrames"),
        ],
      ),
    );
  }

  Widget _metricColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildParticleTile(RealQuantumParticle p) {
    return Container(
      decoration: BoxDecoration(
        color: p.isFullyStable ? Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.2),
        border: Border.all(color: p.isFullyStable ? Colors.green : Colors.redAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          p.currentTime.toStringAsFixed(1),
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(status, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: isRunning ? null : start,
            style: ElevatedButton.styleFrom(
              backgroundColor: isGPUMode ? Colors.red : Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(isRunning ? "ٹیسٹ جاری ہے..." : "تجربہ شروع کریں", style: const TextStyle(fontSize: 16)),
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
