import 'package:flutter/material.dart';
import 'dart:async';
import '../core/quantum_particle.dart';
import '../utils/constants.dart';

class MultiQuantumDashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() => _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState extends State<MultiQuantumDashboard> {
  // 10 کوانٹم پارٹیکلز
  List<QuantumParticle> particles = [];
  
  // تجربے کی معلومات
  int totalAttempts = 0;
  int successfulStabilizations = 0;
  bool isRunning = false;
  Timer? _experimentTimer;
  
  // نظام کی حالت
  String systemStatus = "10-کوانٹم ٹیسٹ تیار";
  Color statusColor = Colors.grey;
  
  // نتائج
  List<int> attemptsHistory = [];
  DateTime? experimentStartTime;

  @override
  void initState() {
    super.initState();
    initializeParticles();
  }

  void initializeParticles() {
    particles.clear();
    for (int i = 0; i < 10; i++) {
      particles.add(QuantumParticle(i));
    }
  }

  void startQuantumExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      successfulStabilizations = 0;
      attemptsHistory.clear();
      initializeParticles();
      systemStatus = "10-کوانٹم استحکام جاری...";
      statusColor = Colors.blue;
      experimentStartTime = DateTime.now();
    });

    _experimentTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      updateQuantumSystem();
    });
  }

  void updateQuantumSystem() {
    setState(() {
      totalAttempts++;
      
      // ہر پارٹیکل پر 35ms قانون لاگو کریں
      for (var particle in particles) {
        particle.apply35msLaw();
      }
      
      // کتنے پارٹیکل stable ہیں؟
      int stableParticles = particles.where((p) => p.isStable).length;
      int fullyStableParticles = particles.where((p) => p.isFullyStable).length;
      
      // اسٹیٹس اپڈیٹ کریں
      if (fullyStableParticles == 10) {
        // مکمل کامیابی!
        successfulStabilizations++;
        _experimentTimer?.cancel();
        isRunning = false;
        
        // وقت کا حساب
        final duration = DateTime.now().difference(experimentStartTime!);
        final seconds = duration.inMilliseconds / 1000.0;
        
        systemStatus = "کمال! تمام 10 پارٹیکل مستحکم\n"
                      "وقت: ${seconds.toStringAsFixed(2)} سیکنڈ\n"
                      "کوششیں: $totalAttempts";
        statusColor = Colors.green;
        
        // تاریخ میں محفوظ کریں
        attemptsHistory.add(totalAttempts);
        
        // 2 سیکنڈ بعد دوبارہ شروع کرنے کے لیے
        Timer(Duration(seconds: 2), () {
          if (mounted) {
            startQuantumExperiment();
          }
        });
        
      } else if (stableParticles >= 7) {
        systemStatus = "اچھا! $stableParticles/10 مستحکم\n"
                      "کوشش: $totalAttempts";
        statusColor = Colors.blue;
      } else if (stableParticles >= 4) {
        systemStatus = "جاری... $stableParticles/10 مستحکم";
        statusColor = Colors.orange;
      } else {
        systemStatus = "شروع... $stableParticles/10 مستحکم";
        statusColor = Colors.red;
      }
    });
  }

  void stopExperiment() {
    _experimentTimer?.cancel();
    setState(() {
      isRunning = false;
      systemStatus = "ٹیسٹ روک دیا\n"
                    "کل کوششیں: $totalAttempts\n"
                    "کامیاب استحکام: $successfulStabilizations";
      statusColor = Colors.grey;
    });
  }

  @override
  void dispose() {
    _experimentTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10-کوانٹم استحکم تجربہ"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // تجربے کی معلومات
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "35ms قانون کا 10-کوانٹم ٹیسٹ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBox("کل کوششیں", "$totalAttempts", Colors.blue),
                          _buildInfoBox("کامیاب استحکام", "$successfulStabilizations", Colors.green),
                          _buildInfoBox("مستحکم پارٹیکل", 
                            "${particles.where((p) => p.isStable).length}/10", 
                            Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // 10 پارٹیکلز کا گرڈ
              Text(
                "کوانٹم پارٹیکلز (ہر 100ms اپڈیٹ)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: particles.length,
                itemBuilder: (context, index) {
                  final particle = particles[index];
                  return _buildParticleCard(particle);
                },
              ),
              
              SizedBox(height: 20),
              
              // نظام کی حالت
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      _getStatusIcon(),
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      systemStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // بٹنز
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isRunning ? null : startQuantumExperiment,
                      icon: Icon(Icons.play_arrow),
                      label: Text(isRunning ? "جاری ہے..." : "ٹیسٹ شروع کریں"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isRunning ? stopExperiment : null,
                      icon: Icon(Icons.stop),
                      label: Text("روکیں"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // تاریخ کے نتائج
              if (attemptsHistory.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "آخری نتائج:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: attemptsHistory.reversed.take(5).map((attempts) {
                            return Chip(
                              label: Text("$attempts کوششیں"),
                              backgroundColor: attempts <= 20 
                                ? Colors.green[100] 
                                : attempts <= 50 
                                  ? Colors.orange[100] 
                                  : Colors.red[100],
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "بہترین: ${attemptsHistory.isNotEmpty ? attemptsHistory.reduce((a, b) => a < b ? a : b) : 'N/A'} کوششیں",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              
              // 35ms قانون کی وضاحت
              Card(
                color: Colors.deepPurple[50],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "35ms قانون کا اطلاق:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "• ہر پارٹیکل کا اپنا اتفاق (بوہر)\n"
                        "• 35ms کی طرف خودکار ایڈجسٹمنٹ\n"
                        "• 30-40ms رینج میں = مستحکم\n"
                        "• 3 بار مستحکم = مکمل stable",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoBox(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildParticleCard(QuantumParticle particle) {
    return Card(
      elevation: 2,
      color: particle.isFullyStable
          ? Colors.green[50]
          : particle.isStable
              ? Colors.blue[50]
              : Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "پارٹیکل ${particle.id + 1}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: particle.isFullyStable ? Colors.green[800] : Colors.grey[800],
              ),
            ),
            SizedBox(height: 5),
            Text(
              "${particle.currentTime.toStringAsFixed(1)} ms",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  particle.isFullyStable 
                      ? Icons.check_circle 
                      : particle.isStable 
                          ? Icons.autorenew 
                          : Icons.error,
                  size: 16,
                  color: particle.isFullyStable 
                      ? Colors.green 
                      : particle.isStable 
                          ? Colors.blue 
                          : Colors.red,
                ),
                SizedBox(width: 5),
                Text(
                  particle.isFullyStable 
                      ? "مکمل مستحکم" 
                      : particle.isStable 
                          ? "مستحکم" 
                          : "غیر مستحکم",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getStatusIcon() {
    if (systemStatus.contains("کمال")) return Icons.celebration;
    if (systemStatus.contains("اچھا")) return Icons.thumb_up;
    if (systemStatus.contains("جاری")) return Icons.autorenew;
    return Icons.play_arrow;
  }
}
