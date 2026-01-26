import 'package:flutter/material.dart';
import 'dart:async'; // ٹائمر کے لیے
import '../utils/constants.dart';
import '../core/stability_engine.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double currentNpuTime = 0;
  String systemStatus = "شروع کرنے کے لیے بٹن دبائیں";
  Color statusColor = Colors.grey;
  Timer? _timer;
  int totalAttempts = 0; // کل کتنی بار نمبر بدلا
  bool isRunning = false;
  
  final StabilityEngine engine = StabilityEngine();

  // نظام کو خودکار چلانے کا فنکشن
  void startExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      engine.stableCycles = 0; // انجن ری سیٹ
      systemStatus = "تجربہ جاری ہے...";
      statusColor = Colors.blue;
    });

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      updateLogic();
    });
  }

  void updateLogic() {
    setState(() {
      totalAttempts++; // ہر تبدیلی پر گنتی بڑھے گی
      
      // 1. اتفاق (Random Number)
      currentNpuTime = 20 + (DateTime.now().millisecond % 30).toDouble();
      
      // 2. قانون (35ms کے قریب چیک کرنا)
      bool isStable = currentNpuTime >= 30 && currentNpuTime <= 40;
      bool systemStable = engine.checkStability(isStable);
      
      // 3. قید (رک جانا جب مستحکم ہو جائے)
      if (systemStable) {
        _timer?.cancel(); // نمبرز کو روک دیں
        isRunning = false;
        systemStatus = "مستحکم ہو گیا!";
        statusColor = Color(QSLConstants.STABLE_COLOR);
      } else if (engine.stableCycles > 0) {
        systemStatus = "استحکام جاری (${engine.stableCycles})";
        statusColor = Color(QSLConstants.ACCIDENT_COLOR);
      } else {
        systemStatus = "غیر مستحکم";
        statusColor = Color(QSLConstants.UNSTABLE_COLOR);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quantum Stability Lab"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // کوششوں کی تعداد
            Text(
              "کل کوششیں: $totalAttempts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // NPU وقت کا ڈسپلے
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: Text(
                "${currentNpuTime.toStringAsFixed(1)} ms",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isRunning ? Colors.blue : Colors.green,
                ),
              ),
            ),
            
            SizedBox(height: 30),
            
            // اسٹیٹس کارڈ
            Card(
              color: statusColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    systemStatus,
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 40),
            
            // رزلٹ نوٹ
            if (!isRunning && totalAttempts > 0)
              Container(
                padding: EdgeInsets.all(15),
                color: Colors.green[50],
                child: Text(
                  "نتیجہ: نظام $totalAttempts کوششوں میں مستحکم ہوا۔",
                  style: TextStyle(fontSize: 18, color: Colors.green[800], fontWeight: FontWeight.bold),
                ),
              ),
              
            SizedBox(height: 20),

            // بٹن کنٹرول
            ElevatedButton(
              onPressed: isRunning ? null : startExperiment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                isRunning ? "جاری ہے..." : "تجربہ شروع کریں",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
