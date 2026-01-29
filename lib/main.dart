import 'package:flutter/material.dart';
import 'ui/dashboard.dart';
import 'ui/experiment_history.dart';
import 'ui/real_sensor_dashboard.dart';
import 'ui/intelligence_vs_strength_test.dart';
import 'ui/philosophy_comparison.dart';
import 'main_brain_experiments.dart'; // Brain Experiment
import 'ui/hybrid_law_dashboard.dart';

void main() {
  runApp(QuantumStabilityLabApp());
}

class QuantumStabilityLabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Stability Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes: {
        // پرانے تجربات
        '/dashboard': (context) => MultiQuantumDashboard(), 
        '/simulation': (context) => MultiQuantumDashboard(),
        '/history': (context) => ExperimentHistory(),
        '/sensor': (context) => RealSensorDashboard(),
        '/intelligence': (context) => IntelligenceVsStrengthTest(),
        '/philosophy': (context) => PhilosophyComparisonScreen(),
        
        // ✨ نئے تجربات
        '/brain_experiment': (context) => BrainExperimentDashboard(),
        '/hybrid_law': (context) => HybridLawDashboard(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quantum Stability Lab'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 40),
                child: Column(
                  children: [
                    Icon(Icons.science, size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 20),
                    Text(
                      'Quantum Stability Lab',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '30ms Fixation Law (Moto g54 Optimized)',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple[700]),
                    ),
                  ],
                ),
              ),
              
              // Experiment Cards Grid - ✨ اب 6 کارڈز
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  // 1. پرانا کوانٹم تجربہ
                  _buildExperimentCard(
                    context: context,
                    title: 'Quantum Lab',
                    subtitle: '2000 Particles',
                    icon: Icons.psychology,
                    color: Colors.blue,
                    route: MultiQuantumDashboard(),
                  ),
                  
                  // 2. سینسر تجربہ
                  _buildExperimentCard(
                    context: context,
                    title: 'Real Sensors',
                    subtitle: 'Mobile Sensors',
                    icon: Icons.sensors,
                    color: Colors.orange,
                    route: RealSensorDashboard(),
                  ),
                  
                  // ✨ 3. Brain Philosophy (نیا)
                  _buildExperimentCard(
                    context: context,
                    title: 'Brain Research',
                    subtitle: 'Keyboard vs Datacenter',
                    icon: Icons.memory,
                    color: Colors.green,
                    route: BrainExperimentDashboard(),
                  ),
                  
                  // 4. NPU/GPU تجربہ
                  _buildExperimentCard(
                    context: context,
                    title: 'NPU Test',
                    subtitle: 'Strength vs Intelligence',
                    icon: Icons.bolt,
                    color: Colors.purple,
                    route: IntelligenceVsStrengthTest(),
                  ),
                  
                  // 5. فلسفہ
                  _buildExperimentCard(
                    context: context,
                    title: 'Philosophy',
                    subtitle: 'Bohr vs Einstein',
                    icon: Icons.lightbulb,
                    color: Colors.deepOrange,
                    route: PhilosophyComparisonScreen(),
                  ),
                  
                  // ✨ 6. ہائبرڈ قانون (نیا ترین)
                  _buildExperimentCard(
                    context: context,
                    title: 'Hybrid Law',
                    subtitle: 'اردو ←→ ریاضی',
                    icon: Icons.gavel,
                    color: Colors.teal,
                    route: HybridLawDashboard(),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // ✨ نئے تجربات کا تعارف
              Card(
                color: Colors.teal[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '🧠 نئے تحقیقی تجربات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '1. Brain Research: دماغ = کی بورڈ یا ڈیٹا سینٹر؟\n'
                        '2. Hybrid Law: اردو سوالوں کا ریاضی سے جواب',
                        style: TextStyle(color: Colors.teal[700]),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Stats/Info Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('6', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          Text('تجربات', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                          Text('نئے', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('4', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                          Text('پرانے', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Text(
                '⚛️ بوہر + آئنسٹائن کا امتزاج (مستحکم کوانٹم کمپیوٹر) ⚖️',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperimentCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget route,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => route));
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 10),
              Text(title, 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)
              ),
              const SizedBox(height: 5),
              Text(subtitle, 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 10, color: Colors.grey[600])
              ),
            ],
          ),
        ),
      ),
    );
  }
}
