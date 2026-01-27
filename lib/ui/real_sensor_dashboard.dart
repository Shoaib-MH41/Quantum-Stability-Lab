import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class RealSensorDashboard extends StatefulWidget {
  @override
  _RealSensorDashboardState createState() => _RealSensorDashboardState();
}

class _RealSensorDashboardState extends State<RealSensorDashboard> {
  // 60 پارٹیکلز کا اضافہ
  static const int particleCount = 15;
  List<RealQuantumParticle> particles = List.generate(particleCount, (i) => RealQuantumParticle(i));
  
  bool isRunning = false;
  bool isGPUMode = false; // GPU بمقابلہ NPU سوئچ
  int totalAttempts = 0;
  String systemStatus = "موڈ منتخب کریں اور ٹیسٹ شروع کریں";
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      stopwatch.reset();
      stopwatch.start();
      systemStatus = isGPUMode ? "سپر کمپیوٹر (GPU) موڈ فعال" : "کوانٹم (NPU) موڈ فعال";
    });

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _processQuantumLogic();
    });
  }

  void _processQuantumLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      // GPU موڈ میں ہم زبردستی اضافی بوجھ (Heavy Calculation) ڈالیں گے
      if (isGPUMode) {
        for (int i = 0; i < 10000; i++) { double x = i * 0.0001; } // مصنوعی بوجھ
      }

      for (var p in particles) {
        p.apply35msLaw(); // حقیقی سینسرز کا استعمال
        if (!p.isFullyStable) allStable = false;
      }

      if (allStable) {
        _timer?.cancel();
        stopwatch.stop();
        isRunning = false;
        systemStatus = "✅ استحکام حاصل! وقت: ${stopwatch.elapsed.inSeconds}s";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("GPU vs NPU: 15 Particles"), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          // موڈ سلیکٹر
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("NPU", style: TextStyle(color: Colors.white)),
                Switch(
                  value: isGPUMode,
                  onChanged: (val) => setState(() => isGPUMode = val),
                  activeColor: Colors.red,
                  inactiveThumbColor: Colors.blue,
                ),
                Text("GPU (Supercomputer)", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),

          // وقت اور کوششیں
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metricTile("کوششیں", "$totalAttempts"),
              _metricTile("وقت", "${stopwatch.elapsed.inSeconds}s"),
            ],
          ),

          // 60 پارٹیکلز کا گرڈ
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemCount: particleCount,
              itemBuilder: (context, i) => Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: particles[i].isFullyStable ? Colors.green : Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // کنٹرول بٹن
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: isRunning ? null : startExperiment,
              style: ElevatedButton.styleFrom(
                backgroundColor: isGPUMode ? Colors.red : Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(isRunning ? "ٹیسٹ جاری ہے..." : "ٹیسٹ شروع کریں"),
            ),
          ),
          
          Text(systemStatus, style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _metricTile(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
