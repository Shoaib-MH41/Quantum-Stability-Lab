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

  String status = "آئن سٹائن بمقابلہ بوہر: 2000 پارٹیکل ٹیسٹ";
  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  int stableFrames = 0;
  final int requiredStableFrames = 6;

  void start() {
    setState(() {
      // ہارڈویئر اور لاجک سنکرونائزیشن
      RealQuantumParticle.useClusterLogic = !isGPUMode;
      
      attempts = 0;
      stableFrames = 0;
      isRunning = true;
      stopwatch..reset()..start();

      status = isGPUMode
          ? "آئن سٹائن قانون (GPU): انفرادی حقیقت"
          : "نیلز بوہر قانون (NPU): کوانٹم انٹیگلمنٹ";
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

      // GPU موڈ میں شدید بوجھ (Stress Test)
      if (isGPUMode) {
        for (int i = 0; i < 500000; i++) {
          double x = i * 0.0001;
        }
      }

      for (final p in particles) {
        // نئے 'applyLaw' میتھڈ کا استعمال
        p.applyLaw(); 
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
        
        String lawName = isGPUMode ? "آئن سٹائن" : "نیلز بوہر";
        status = "🏆 $lawName قانون کامیاب!\n"
                 "وقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $attempts";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quantum Core: Bohr vs Einstein"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          _buildLawInfoBar(), // نیا: قانون کی تفصیل
          _buildMetricsBar(),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.white10,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 40,
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
      tileColor: Colors.white.withOpacity(0.05),
      title: Text(isGPUMode ? "آئن سٹائن موڈ (Individual)" : "نیلز بوہر موڈ (Cluster)",
          style: TextStyle(color: isGPUMode ? Colors.redAccent : Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(isGPUMode ? "ہر ذرہ اپنی حقیقت رکھتا ہے" : "ذرات ایک مربوط نظام ہیں", style: const TextStyle(color: Colors.grey, fontSize: 10)),
      value: isGPUMode,
      onChanged: isRunning ? null : (v) {
        setState(() {
          isGPUMode = v;
          RealQuantumParticle.useClusterLogic = !isGPUMode;
        });
      },
      activeColor: Colors.red,
      inactiveThumbColor: Colors.blue,
    );
  }

  Widget _buildLawInfoBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.indigo.withOpacity(0.2),
      child: Text(
        "موجودہ ٹارگٹ: ${isGPUMode ? RealQuantumParticle.gpuLaw : RealQuantumParticle.npuLaw}ms",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMetricsBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _metricColumn("کوششیں", "$attempts"),
          _metricColumn("وقت", "${stopwatch.elapsed.inSeconds}s"),
          _metricColumn("استحکام", "$stableFrames/6"),
        ],
      ),
    );
  }

  Widget _metricColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildNanoTile(RealQuantumParticle p) {
    return Container(
      decoration: BoxDecoration(
        color: p.isFullyStable ? Colors.green : Colors.red.withOpacity(0.3),
        borderRadius: BorderRadius.circular(0.5),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white10,
      child: Column(
        children: [
          Text(status, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isRunning ? null : start,
                  style: ElevatedButton.styleFrom(backgroundColor: isGPUMode ? Colors.red : Colors.blue),
                  child: const Text("ٹیسٹ شروع کریں"),
                ),
              ),
              const SizedBox(width: 10),
              // 🔄 قانون بدلنے کا نیا بٹن
              IconButton(
                onPressed: isRunning ? null : () {
                  setState(() {
                    RealQuantumParticle.swapLaws();
                  });
                },
                icon: const Icon(Icons.swap_calls, color: Colors.orangeAccent),
                tooltip: "قانون تبدیل کریں",
              ),
            ],
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
