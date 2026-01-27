import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart'; // حقیقی سینسر والی فائل

class MultiQuantumDashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() => _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState extends State<MultiQuantumDashboard> {
  static const int particleCount = 60; // 60 پارٹیکلز کا ہدف
  List<RealQuantumParticle> particles = List.generate(particleCount, (i) => RealQuantumParticle(i));
  
  bool isRunning = false;
  bool isGPUMode = false; // NPU vs GPU سوئچ
  int totalAttempts = 0;
  String systemStatus = "60-پوائنٹ ٹیسٹ تیار";
  Color statusColor = Colors.grey;
  Stopwatch stopwatch = Stopwatch();
  Timer? _experimentTimer;

  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      stopwatch.reset();
      stopwatch.start();
      systemStatus = isGPUMode ? "GPU (سپر کمپیوٹر) موڈ جاری..." : "NPU (کوانٹم) موڈ جاری...";
      statusColor = isGPUMode ? Colors.red : Colors.blue;
    });

    _experimentTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      updateSystemLogic();
    });
  }

  void updateSystemLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // GPU موڈ میں مصنوعی بوجھ ڈالنا
      if (isGPUMode) {
        for (int i = 0; i < 30000; i++) { double x = i * 0.001; } 
      }

      for (var p in particles) {
        p.apply35msLaw(); // حقیقی سینسرز سے قانون نافذ کرنا
        if (!p.isFullyStable) allStable = false;
      }

      // جب سب مستحکم ہو جائیں تو رک جائیں
      if (allStable) {
        _experimentTimer?.cancel();
        stopwatch.stop();
        isRunning = false;
        systemStatus = "کامیابی! تمام 60 مستحکم\nوقت: ${stopwatch.elapsed.inSeconds}s | کوششیں: $totalAttempts";
        statusColor = Colors.green;
      }
    });
  }

  void stopExperiment() {
    _experimentTimer?.cancel();
    stopwatch.stop();
    setState(() {
      isRunning = false;
      systemStatus = "تجربہ موقوف کر دیا گیا";
      statusColor = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("60-Point Quantum Master Lab"), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          // NPU vs GPU سوئچ
          _buildModeSwitch(),
          
          // میٹرکس بار
          _buildTopMetrics(),

          // 60 پارٹیکلز کا گرڈ
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // 6 کالمز
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: particleCount,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: particles[index].isFullyStable ? Colors.green : Colors.red.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text("${particles[index].currentTime.toStringAsFixed(0)}", 
                  style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ),
          ),

          // اسٹیٹس اور بٹن
          _buildBottomControls(),
        ],
      ),
    );
  }

  // باقی مددگار وزٹس (Metrics, Controls وغیرہ) یہاں آئیں گے
}
