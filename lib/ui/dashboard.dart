import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../core/stability_engine.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool lawActive = true;
  double currentNpuTime = 0;
  String systemStatus = "شروع کریں";
  Color statusColor = Colors.grey;
  
  final StabilityEngine engine = StabilityEngine();
  
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
          children: [
            // NPU Live وقت
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "NPU Live وقت",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${currentNpuTime.toStringAsFixed(1)} ms",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: currentNpuTime <= 40 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // نظام کی حالت
            Card(
              color: statusColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    systemStatus,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // قانون ON/OFF
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "قانونِ حادثہ: ",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: lawActive,
                  onChanged: (value) {
                    setState(() {
                      lawActive = value;
                      if (value) {
                        systemStatus = "قانون فعال";
                        statusColor = Color(QSLConstants.STABLE_COLOR);
                      } else {
                        systemStatus = "قانون غیر فعال";
                        statusColor = Colors.grey;
                      }
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                  lawActive ? "ON" : "OFF",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: lawActive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // 35ms قانون کی نشاندہی
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "قانونِ تثبیت: ${QSLConstants.FIXATION_TIME_MS}ms",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            
            Spacer(),
            
            // اہم نوٹ
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue[50],
              child: Text(
                "نوٹ: یہ ایک سائنسی تجربہ ہے۔ اتفاق کو قانون میں قید کریں۔",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue[800]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // یہاں آپ NPU وقت اپڈیٹ کریں گے
          setState(() {
            currentNpuTime = 20 + (DateTime.now().millisecond % 40).toDouble();
            
            // استحکام چیک کریں
            bool isStable = currentNpuTime >= 30 && currentNpuTime <= 40;
            bool systemStable = engine.checkStability(isStable);
            
            if (systemStable) {
              systemStatus = "مستحکم نظام";
              statusColor = Color(QSLConstants.STABLE_COLOR);
            } else if (engine.stableCycles > 0) {
              systemStatus = "استحکام جاری (${engine.stableCycles})";
              statusColor = Color(QSLConstants.ACCIDENT_COLOR);
            } else {
              systemStatus = "غیر مستحکم";
              statusColor = Color(QSLConstants.UNSTABLE_COLOR);
            }
          });
        },
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.green,
      ),
    );
  }
}
