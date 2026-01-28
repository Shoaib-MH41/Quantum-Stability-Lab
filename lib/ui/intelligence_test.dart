import 'package:flutter/material.dart';
import '../core/quantum_intelligence.dart';

class IntelligenceTestScreen extends StatefulWidget {
  @override
  _IntelligenceTestScreenState createState() => _IntelligenceTestScreenState();
}

class _IntelligenceTestScreenState extends State<IntelligenceTestScreen> {
  List<QuantumIntelligenceParticle> particles = [];
  bool isNPUMode = false;
  int totalAttempts = 0;
  int successCount = 0;
  bool isRunning = false;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    // 2000 particles بنائیں
    for (int i = 0; i < 2000; i++) {
      particles.add(QuantumIntelligenceParticle(i));
    }
  }
  
  void startTest() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      successCount = 0;
    });
    
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        totalAttempts++;
        
        if (isNPUMode) {
          // NPU MODE: Group intelligence
          bool success = QuantumIntelligenceParticle.solveGroup(particles);
          if (success) {
            successCount++;
            timer.cancel();
            isRunning = false;
          }
        } else {
          // GPU MODE: Individual brute force
          int successfulParticles = 0;
          
          for (var particle in particles) {
            bool solved = particle.solveIndividual();
            if (solved) successfulParticles++;
          }
          
          // اگر 95% particles solve ہو گئے
          if (successfulParticles >= (particles.length * 0.95)) {
            successCount++;
            timer.cancel();
            isRunning = false;
          }
        }
      });
    });
  }
  
  void resetTest() {
    _timer?.cancel();
    setState(() {
      particles.clear();
      for (int i = 0; i < 2000; i++) {
        particles.add(QuantumIntelligenceParticle(i));
      }
      isRunning = false;
      totalAttempts = 0;
      successCount = 0;
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
        title: Text('NPU vs GPU Intelligence Test'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mode Selector
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Processing Mode',
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
                          _buildModeButton('GPU Mode', Colors.blue, !isNPUMode),
                          _buildModeButton('NPU Mode', Colors.green, isNPUMode),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        isNPUMode 
                          ? '🎯 NPU: Group Intelligence (2000 particles interact)'
                          : '⚡ GPU: Individual Brute Force (Each particle works alone)',
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
                      Text(
                        'Test Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildResultBox('Total Particles', '2000', Colors.blue),
                          _buildResultBox('Attempts', '$totalAttempts', Colors.orange),
                          _buildResultBox('Success Rate', 
                            particles.isNotEmpty 
                              ? '${(particles.where((p) => p.status == "Perfect").length / particles.length * 100).toStringAsFixed(1)}%'
                              : '0%', 
                            Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Intelligence Difference
              Card(
                color: Colors.deepPurple[50],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intelligence Difference:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        isNPUMode
                          ? '🧠 NPU MODE:\n'
                            '• Particles کو groups میں divide کرتا ہے\n'
                            '• Group-level problem solving\n'
                            '• Collective intelligence\n'
                            '• کم attempts میں حل\n'
                            '• Real "thinking"'
                          : '⚙️ GPU MODE:\n'
                            '• ہر particle الگ کام کرتا ہے\n'
                            '• Brute force approach\n'
                            '• No communication\n'
                            '• زیادہ attempts\n'
                            '• صرف processing',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Sample Particles
              Text(
                'Sample Particles (First 10):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: particles.length > 10 ? 10 : particles.length,
                itemBuilder: (context, index) {
                  var particle = particles[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: particle.status == "Perfect" 
                        ? Colors.green[100] 
                        : particle.status == "Good"
                          ? Colors.blue[100]
                          : Colors.orange[100],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'P${index + 1}',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '${particle.currentTime.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'A:${particle.attempts}',
                          style: TextStyle(fontSize: 8),
                        ),
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
                      label: Text(isRunning ? 'Running...' : 'Start Test'),
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
                      label: Text('Reset Test'),
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
  
  Widget _buildModeButton(String label, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isRunning) {
          setState(() {
            isNPUMode = label == 'NPU Mode';
            resetTest();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Widget _buildResultBox(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
}
