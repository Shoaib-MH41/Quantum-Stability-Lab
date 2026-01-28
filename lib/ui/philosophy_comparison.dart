import 'package:flutter/material.dart';
import '../core/hybrid_particle.dart';

class PhilosophyComparisonScreen extends StatefulWidget {
  @override
  _PhilosophyComparisonScreenState createState() => _PhilosophyComparisonScreenState();
}

class _PhilosophyComparisonScreenState extends State<PhilosophyComparisonScreen> {
  // 10 particles for comparison
  List<HybridParticle> particles = [];
  bool showQuantum = true;
  int experimentIterations = 0;
  Map<String, int> results = {
    'quantum_success': 0,
    'classical_success': 0,
    'quantum_collapses': 0,
    'classical_steps': 0,
  };
  
  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }
  
  void _initializeParticles() {
    particles.clear();
    for (int i = 0; i < 10; i++) {
      particles.add(HybridParticle(i));
    }
    
    // Entangle some particles (quantum feature)
    if (particles.length >= 3) {
      particles[0].entangleWith(particles[1]);
      particles[1].entangleWith(particles[2]);
    }
  }
  
  void runExperiment() {
    setState(() {
      experimentIterations++;
      
      // Run both quantum and classical logic
      for (var particle in particles) {
        double quantumResult = particle.apply35msLaw(true);
        double classicalResult = particle.apply35msLaw(false);
        
        // Check success (close to 35ms)
        if ((quantumResult - 35.0).abs() < 1.0) {
          results['quantum_success'] = results['quantum_success']! + 1;
        }
        
        if ((classicalResult - 35.0).abs() < 1.0) {
          results['classical_success'] = results['classical_success']! + 1;
        }
      }
      
      results['quantum_collapses'] = particles.where((p) => p.isCollapsed).length;
      results['classical_steps'] = results['classical_steps']! + particles.length;
    });
  }
  
  void resetExperiment() {
    setState(() {
      _initializeParticles();
      experimentIterations = 0;
      results = {
        'quantum_success': 0,
        'classical_success': 0,
        'quantum_collapses': 0,
        'classical_steps': 0,
      };
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بوہر vs آئن اسٹائن'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Philosophy Toggle
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.science, color: Colors.deepPurple),
                          SizedBox(width: 10),
                          Text(
                            'Quantum vs Classical Philosophy',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      
                      // Toggle Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildPhilosophyButton(
                              '⚛️ بوہر (NPU)',
                              Colors.purple,
                              showQuantum,
                              () => setState(() => showQuantum = true),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildPhilosophyButton(
                              '⚖️ آئن اسٹائن (GPU)',
                              Colors.blue,
                              !showQuantum,
                              () => setState(() => showQuantum = false),
                            ),
                          ),
                        ],
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
                      Text(
                        showQuantum ? 'کوانٹم میکانیات (بوہر)' : 'کلاسیکل فزکس (آئن اسٹائن)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        showQuantum
                          ? '• سب کچھ probability (احتمال) ہے\n'
                            '• Superposition: ایک ساتھ کئی حالتیں\n'
                            '• Measurement causes collapse (مشاہدہ گراوٹ لاتا ہے)\n'
                            '• Entanglement: دور دراز particles کا تعلق\n'
                            '• NPU اسی فلسفے پر کام کرتا ہے'
                          : '• سب کچھ deterministic (مقررہ) ہے\n'
                            '• ہر چیز کی واضح حالت\n'
                            '• No randomness (کوئی اتفاق نہیں)\n'
                            '• Local reality (مقامی حقیقت)\n'
                            '• GPU اسی فلسفے پر کام کرتا ہے',
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Experiment Results
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'تجربے کے نتائج',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildResultCard('Iterations', '$experimentIterations', Colors.grey),
                          _buildResultCard(
                            'Quantum Success', 
                            '${results['quantum_success']}', 
                            Colors.purple
                          ),
                          _buildResultCard(
                            'Classical Success', 
                            '${results['classical_success']}', 
                            Colors.blue
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Quantum Collapses: ${results['quantum_collapses']}',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Particles Display
              Text(
                'پارٹیکلز (10 particles)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                itemCount: particles.length,
                itemBuilder: (context, index) {
                  var particle = particles[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: showQuantum 
                        ? Colors.purple[50] 
                        : Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: showQuantum ? Colors.purple : Colors.blue,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'P${index + 1}',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          particle.apply35msLaw(showQuantum).toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          particle.useQuantumLogic ? 'Q' : 'C',
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
                      onPressed: runExperiment,
                      icon: Icon(Icons.play_arrow),
                      label: Text('تجربہ چلائیں'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: resetExperiment,
                      icon: Icon(Icons.refresh),
                      label: Text('ری سیٹ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
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
  
  Widget _buildPhilosophyButton(String label, Color color, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildResultCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
