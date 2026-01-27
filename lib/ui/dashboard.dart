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

  // 1. یہاں تعداد 20 کر دی گئی ہے
  static const int particleCount = 20;

  final List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));

  bool isRunning = false;
  bool isGPUMode = false;
  int totalAttempts = 0;

  String systemStatus = "20 پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;

  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  // استحکام کی جانچ کے لیے ٹکس
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
          ? "GPU موڈ: بھاری حساب کتاب (Brute Force)"
          : "NPU موڈ: تیز رفتار پیٹرن (Pattern Logic)";

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

      // GPU تصدیق کے لیے مصنوعی بوجھ میں اضافہ
      if (isGPUMode) {
        // بوجھ کو 50,000 تک بڑھایا گیا تاکہ فرق صاف نظر آئے
        for (int i = 0; i < 50000; i++) {
          double x = i * 0.0001;
        }
      }

      for (final p in particles) {
        p.apply35msLaw();
        // لائیو اسکور چیک کریں کہ کیا وہ 35ms یا 20ms کے قریب ہے
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
            "✅ 20 پارٹیکلز کامیاب!\n"
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
        title: const Text("NPU vs GPU: 20 Particle Test"),
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
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("NPU (Smart)", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          Switch(
            value: isGPUMode,
            activeColor: Colors.red,
            onChanged: (v) => setState(() => isGPUMode = v),
          ),
          const Text("GPU (Heavy)", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _topMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("کوششیں: $totalAttempts", style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s", style: const TextStyle(color: Colors.cyanAccent, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _particleGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 20 پارٹیکلز کے لیے بہترین ترتیب
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: particleCount,
      itemBuilder: (_, i) => Container(
        decoration: BoxDecoration(
          color: particles[i].isFullyStable
              ? Colors.green.withOpacity(0.8)
              : Colors.red.withOpacity(0.3),
          border: Border.all(color: particles[i].isFullyStable ? Colors.greenAccent : Colors.redAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${particles[i].currentTime.toStringAsFixed(1)}",
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _bottomControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(systemStatus, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(isRunning ? "پروسیسنگ..." : "تجربہ شروع کریں"),
          ),
        ],
      ),
    );
  }
}
