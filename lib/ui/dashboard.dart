import 'package:flutter/material.dart';
import 'dart:async';
import '../core/real_quantum_particle.dart';

class MultiQuantumDashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() =>
      _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState
    extends State<MultiQuantumDashboard> {

  static const int particleCount = 60;

  List<RealQuantumParticle> particles =
      List.generate(particleCount, (i) => RealQuantumParticle(i));
}
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

      // GPU موڈ میں مصنوعی بوجھ ڈالنا
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

  // پچھلے بلڈ میں یہ حصے غائب تھے جنہیں اب جوڑ دیا گیا ہے
  Widget _buildModeSwitch() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("NPU", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          Switch(
            value: isGPUMode,
            onChanged: (val) => setState(() => isGPUMode = val),
            activeColor: Colors.red,
            inactiveThumbColor: Colors.blue,
          ),
          Text("GPU", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTopMetrics() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("کوششیں: $totalAttempts", style: TextStyle(color: Colors.white, fontSize: 16)),
          Text("وقت: ${stopwatch.elapsed.inSeconds}s", style: TextStyle(color: Colors.cyanAccent, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(systemStatus, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(isRunning ? "پروسیسنگ..." : "ٹیسٹ شروع کریں", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Quantum Master Lab (60)"), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          _buildModeSwitch(),
          _buildTopMetrics(),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: particleCount,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: particles[index].isFullyStable ? Colors.green : Colors.red.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text("${particles[index].currentTime.toStringAsFixed(0)}", 
                  style: TextStyle(color: Colors.white, fontSize: 9)),
                ),
              ),
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }
}
