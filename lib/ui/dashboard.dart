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

  // 1. تعداد 100 کر دی گئی ہے - آپ کے Moto فون کی 12GB RAM کا اصل امتحان
  static const int particleCount = 100;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "100 پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;

  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  // استحکام کی جانچ
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
          ? "GPU موڈ: Brute Force بوجھ"
          : "NPU موڈ: Pattern Logic پیٹرن";

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

      // GPU موڈ میں پروسیسر پر دباؤ بڑھانے کے لیے بوجھ
      if (isGPUMode) {
        for (int i = 0; i < 50000; i++) {
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
            "✅ 100 پارٹیکلز مستحکم!\n"
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
        title: const Text("NPU vs GPU: 100 Particle Test"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          _modeSwitch(),
          _topMetrics(),
          // 100 پارٹیکلز کے لیے موزوں گرڈ
          Expanded(child: _particleGrid()),
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
            onChanged: (v) => setState(() => isGPUMode = v),
          ),
          const Text("GPU", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _topMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("کوششیں: $totalAttempts", style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s", style: const TextStyle(color: Colors.cyanAccent, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _particleGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10, // 10 کالمز تاکہ 100 پارٹیکلز اسکرین پر سما جائیں
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: particleCount,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: particles[i].isFullyStable
              ? Colors.green.withOpacity(0.9)
              : Colors.red.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            "${particles[i].currentTime.toStringAsFixed(0)}", // جگہ بچانے کے لیے صرف راؤنڈ فگر
            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _bottomControls() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Column(
        children: [
          Text(systemStatus, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: Text(isRunning ? "ٹیسٹ جاری ہے..." : "100 پارٹیکل ٹیسٹ شروع کریں"),
          ),
        ],
      ),
    );
  }
}
