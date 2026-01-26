import 'package:flutter/material.dart';
import 'dart:async'; // ٹائمر کے لیے ضروری ہے
import '../utils/constants.dart';
import '../core/stability_engine.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool lawActive = false; // تجربہ شروع کرنے کے لیے
  double currentNpuTime = 0;
  String systemStatus = "شروع کریں";
  Color statusColor = Colors.grey;
  Timer? _timer; // خودکار لوپ کے لیے
  
  final StabilityEngine engine = StabilityEngine();

  // تجربہ شروع یا بند کرنے کا فنکشن
  void toggleExperiment(bool start) {
    if (start) {
      // ہر 100 ملی سیکنڈ میں ڈیٹا اپڈیٹ کریں
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        updateQuantumData();
      });
    } else {
      _timer?.cancel();
      setState(() {
        currentNpuTime = 0;
        systemStatus = "تجربہ موقوف";
        statusColor = Colors.grey;
      });
    }
  }

  void updateQuantumData() {
    setState(() {
      // 1. اتفاق: خودکار نمبر جنریٹ کرنا
      currentNpuTime = 20 + (DateTime.now().millisecond % 30).toDouble();
      
      // 2. قانون: کیا یہ نمبر 35ms کے قانون کے مطابق ہے؟
      // ہم یہاں چیک کر رہے ہیں کہ کیا نمبر 30 اور 40 کے درمیان ہے
      bool isStable = currentNpuTime >= 30 && currentNpuTime <= 40;
      bool systemStable = engine.checkStability(isStable);
      
      // 3. قید: اسٹیٹس اپڈیٹ کرنا
      if (systemStable) {
        systemStatus = "مستحکم نظام";
        statusColor = Color(QSLConstants.STABLE_COLOR);
        _timer?.cancel(); // مستحکم ہونے پر خود بخود رک جائے گا
        lawActive = false;
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
    _timer?.cancel(); // ایپ بند ہونے پر ٹائمر ختم کر دیں
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
          children: [
            // NPU Live وقت (خودکار بدلنے والا)
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("NPU Live وقت", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text(
                      "${currentNpuTime.toStringAsFixed(1)} ms",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: currentNpuTime >= 30 && currentNpuTime <= 40 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // نظام کی حالت کا ڈسپلے
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  systemStatus,
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            SizedBox(height: 30),
            
            // تجربہ شروع کرنے کا سوئچ
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("تجربہ شروع کریں: ", style: TextStyle(fontSize: 18)),
                Switch(
                  value: lawActive,
                  onChanged: (value) {
                    setState(() {
                      lawActive = value;
                      toggleExperiment(value);
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            Text(
              "قانونِ تثبیت: ${QSLConstants.FIXATION_TIME_MS}ms",
              style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ),
            
            Spacer(),
            
            // اہم نوٹ
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
              child: Text(
                "نوٹ: 'اتفاق' خودکار طور پر پیدا ہو رہا ہے۔ اسے 35ms کے 'قانون' پر ساکن کرنے کی کوشش کریں۔",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
