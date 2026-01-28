import 'package:flutter/material.dart';
import 'dart:async'; // ٹائمر (Timer) کے ایرر کے لیے لازمی ہے
import 'dart:math';  // 'min' فنکشن کے ایرر کے لیے لازمی ہے
import '../core/quantum_intelligence_vs_strength.dart';

class IntelligenceVsStrengthTest extends StatefulWidget {
  @override
  _IntelligenceVsStrengthTestState createState() => _IntelligenceVsStrengthTestState();
}

class _IntelligenceVsStrengthTestState extends State<IntelligenceVsStrengthTest> {
  // 100 particles - 50 GPU, 50 NPU
  List<QuantumIntelligenceSystem> particles = [];
  bool isRunning = false;
  Timer? _timer;
  int iterations = 0;
  
  // Results tracking
  int gpuSuccessCount = 0;
  int npuSuccessCount = 0;
  int totalGPUScore = 0;
  int totalNPUScore = 0;
  
  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }
  
  void _initializeParticles() {
    particles.clear();
    
    // 50 GPU particles (طاقت)
    for (int i = 0; i < 50; i++) {
      particles.add(QuantumIntelligenceSystem(i, isNPUMode: false));
    }
    
    // 50 NPU particles (ذہانت)
    for (int i = 50; i < 100; i++) {
      particles.add(QuantumIntelligenceSystem(i, isNPUMode: true));
    }
  }
  
  void startTest() {
    setState(() {
      isRunning = true;
      iterations = 0;
      gpuSuccessCount = 0;
      npuSuccessCount = 0;
      totalGPUScore = 0;
      totalNPUScore = 0;
    });
    
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        iterations++;
        
        // ہر particle کو اپنا test چلانے دو
        for (var particle in particles) {
          particle.applyCorrectTest();
          
          // Track results
          if (particle.isNPUMode) {
            totalNPUScore += particle.intelligenceScore;
            if (particle.isSuccessful) npuSuccessCount++;
          } else {
            totalGPUScore += particle.strengthScore;
            if (particle.isSuccessful) gpuSuccessCount++;
          }
        }
        
        // Stop after 30 iterations یا جب سب successful ہوں
        if (iterations >= 30 || 
            (gpuSuccessCount >= 45 && npuSuccessCount >= 45)) {
          timer.cancel();
          isRunning = false;
        }
      });
    });
  }
  
  void resetTest() {
    _timer?.cancel();
    setState(() {
      _initializeParticles();
      isRunning = false;
      iterations = 0;
      gpuSuccessCount = 0;
      npuSuccessCount = 0;
      totalGPUScore = 0;
      totalNPUScore = 0;
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
        title: Text('طاقت 🆚 ذہانت'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                color: Colors.deepPurple[50],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.psychology, size: 50, color: Colors.deepPurple),
                      SizedBox(height: 10),
                      Text(
                        'GPU (طاقت) 🆚 NPU (ذہانت)',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        'ہر ایک کو اس کی اصل صلاحیت کے مطابق test کریں',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Results
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('نتائج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      
                      // GPU Results
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          children: [
                            Text('⚡ GPU (طاقت)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMetric('کامیاب', '$gpuSuccessCount/50'),
                                _buildMetric('اسکور', '${totalGPUScore ~/ 50}'),
                                _buildMetric('طاقت', '${(totalGPUScore / 50).toInt()} units'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 10),
                      
                      // NPU Results
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          children: [
                            Text('🧠 NPU (ذہانت)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMetric('کامیاب', '$npuSuccessCount/50'),
                                _buildMetric('اسکور', '${totalNPUScore ~/ 50}'),
                                _buildMetric('ذہانت', '${(totalNPUScore / 50).toInt()} pts'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Philosophy Explanation
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('سائنسی اصول:', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('⚡ GPU کو test کریں: Brute Force + Heavy Computation (طاقت)'),
                      SizedBox(height: 5),
                      Text('🧠 NPU کو test کریں: Pattern Recognition + Smart Decisions (ذہانت)'),
                      SizedBox(height: 10),
                      Text('نوٹ: ہر ایک کو اسی کام کے لیے test کریں جس کے لیے وہ بنایا گیا ہے۔',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Sample Particles
              Text('نمونہ پارٹیکلز (پہلے 10):', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: min(10, particles.length),
                itemBuilder: (context, index) {
                  var particle = particles[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: particle.isNPUMode ? Colors.green[100] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: particle.isNPUMode ? Colors.green : Colors.blue),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(particle.isNPUMode ? 'N${index+1}' : 'G${index+1}', 
                            style: TextStyle(fontSize: 10)),
                        Text(particle.currentTime.toStringAsFixed(1),
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(particle.isSuccessful ? '✓' : '⋅',
                            style: TextStyle(fontSize: 14, color: particle.isSuccessful ? Colors.green : Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
              
              SizedBox(height: 30),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isRunning ? null : startTest,
                      icon: Icon(Icons.play_arrow),
                      label: Text(isRunning ? 'جاری ہے...' : 'ٹیسٹ شروع کریں'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: resetTest,
                      icon: Icon(Icons.refresh),
                      label: Text('دوبارہ شروع'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
