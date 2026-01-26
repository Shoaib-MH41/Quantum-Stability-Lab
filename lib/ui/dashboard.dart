import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/constants.dart';
import '../core/stability_engine.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // 10 نمبروں کے لیے لسٹ
  List<double> npuTimes = List.generate(10, (index) => 0.0);
  List<bool> stabilityStates = List.generate(10, (index) => false);
  
  String systemStatus = "ملٹی کوانٹم ٹیسٹ شروع کریں";
  Color statusColor = Colors.grey;
  Timer? _timer;
  int totalAttempts = 0;
  bool isRunning = false;
  
  final StabilityEngine engine = StabilityEngine();

  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      systemStatus = "اجتماعی استحکام جاری...";
      statusColor = Colors.blue;
    });

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      updateMultiLogic();
    });
  }

  void updateMultiLogic() {
    setState(() {
      totalAttempts++;
      bool allStable = true;

      for (int i = 0; i < 10; i++) {
        // ہر نمبر کے لیے الگ اتفاق
        npuTimes[i] = 20 + (DateTime.now().millisecond * (i + 1) % 30).toDouble();
        
        // ہر نمبر کا اپنا انفرادی استحکام چیک کریں
        stabilityStates[i] = npuTimes[i] >= 30 && npuTimes[i] <= 40;
        
        if (!stabilityStates[i]) allStable = false;
      }

      // کیا تمام 10 نمبر ایک ساتھ مستحکم ہیں؟
      if (allStable) {
        _timer?.cancel();
        isRunning = false;
        systemStatus = "کمال ہے! تمام 10 مستحکم";
        statusColor = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("10-Point Quantum Stability")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("کل اجتماعی کوششیں: $totalAttempts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          
          // 10 نمبروں کا گرڈ (Grid)
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // دو کالم
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: stabilityStates[index] ? Colors.green[100] : Colors.red[100],
                    border: Border.all(color: stabilityStates[index] ? Colors.green : Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${npuTimes[index].toStringAsFixed(1)} ms",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // اسٹیٹس کارڈ
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: statusColor,
            child: Center(
              child: Text(systemStatus, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          
          SizedBox(height: 20),
          
          ElevatedButton(
            onPressed: isRunning ? null : startExperiment,
            child: Text(isRunning ? "پروسیسنگ..." : "10-پوائنٹ ٹیسٹ شروع کریں"),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
