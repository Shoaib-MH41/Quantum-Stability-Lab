import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class Dashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() => _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState extends State<Dashboard> {
  static const int particleCount = 60;
  List<RealQuantumParticle> particles = List.generate(particleCount, (i) => RealQuantumParticle(i));
  
  bool isRunning = false;
  bool isGPUMode = false; 
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

      if (isGPUMode) {
        for (int i = 0; i < 30000; i++) { double x = i * 0.001; } 
      }

      for (var p in particles) {
        p.apply35msLaw();
        if (!p.isFullyStable) allStable = false;
      }

      if (allStable) {
        _experimentTimer?.cancel();
        stopwatch.stop();
        isRunning = false;
        systemStatus = "کامیابی! تمام 60 مستحکم\nوقت: ${stopwatch.elapsed.inSeconds}s";
        statusColor = Colors.green;
      }
    });
  }

  // غائب شدہ فنکشنز (Methods) یہاں ہیں:

  Widget _buildModeSwitch() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("NPU", style: TextStyle(color: Colors.blue)),
          Switch(
            value: isGPUMode,
            onChanged: (val) => setState(() => isGPUMode = val),
            activeColor: Colors.red,
          ),
          Text("GPU", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildTopMetrics() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("کوششیں: $totalAttempts", style: TextStyle(color: Colors.white, fontSize: 18)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s", style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.all(20),
      color: statusColor,
      child: Column(
        children: [
          Text(systemStatus, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            child: Text(isRunning ? "جاری..." : "ٹیسٹ شروع کریں"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Quantum Master Lab"), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          _buildModeSwitch(),
          _buildTopMetrics(),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemCount: particleCount,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(2),
                color: particles[index].isFullyStable ? Colors.green : Colors.red.withOpacity(0.3),
              ),
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }
}
