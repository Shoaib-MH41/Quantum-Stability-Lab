import 'package:flutter/material.dart';
import 'ui/dashboard.dart';
import 'ui/experiment_history.dart';

import 'package:flutter/material.dart';
import 'ui/dashboard.dart';
import 'ui/experiment_history.dart';
import 'ui/real_sensor_dashboard.dart';
import 'ui/intelligence_vs_strength_test.dart';
import 'ui/philosophy_comparison.dart';
import 'ui/main_brain_experiments.dart';
import 'ui/hybrid_law_dashboard.dart';
import 'ui/quantum_master_dashboard.dart';

// ===== نیا امپورٹ =====
import 'law_experiment.dart'; // علیحدہ تجربہ فائل

void main() {
  runApp(QuantumStabilityLabApp());
  
  // صرف ایک کمانڈ سے تجربہ چلائیں
  Future.delayed(Duration(seconds: 2), () {
    LawExperiment.runSimpleTest(); // ✅ اب کوئی ارر نہیں آئے گا
  });
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
        '/quantum_master': (context) => QuantumMasterDashboard(), // ✨ نیا
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
              
              // Experiment Cards Grid - ✨ اب 7 کارڈز
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
                  
                  // ✨ 5. Quantum Master (نیا ترین)
                  _buildExperimentCard(
                    context: context,
                    title: 'Quantum Master',
                    subtitle: 'CPU+NPU+GPU Integration',
                    icon: Icons.auto_awesome,
                    color: Colors.purpleAccent,
                    route: QuantumMasterDashboard(),
                  ),
                  
                  // 6. فلسفہ
                  _buildExperimentCard(
                    context: context,
                    title: 'Philosophy',
                    subtitle: 'Bohr vs Einstein',
                    icon: Icons.lightbulb,
                    color: Colors.deepOrange,
                    route: PhilosophyComparisonScreen(),
                  ),
                  
                  // ✨ 7. ہائبرڈ قانون (نیا)
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
              
              // ✨ نظام کی فلسفیانہ وضاحت
              Card(
                color: Colors.purple[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '🧬 Quantum Master System',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'CPU: زبان سمجھنا (اردو/انگریزی)\n'
                        'NPU: منطق + قوانین (کی بورڈ ماڈل)\n'
                        'GPU: حساب + طاقت (قانونی حساب)',
                        style: TextStyle(color: Colors.purple[800]),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuantumMasterDashboard(),
                            ),
                          );
                        },
                        icon: Icon(Icons.play_arrow, color: Colors.white),
                        label: Text('Quantum Master شروع کریں'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // ✨ نئے تجربات کا تعارف
              Card(
                color: Colors.teal[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '🧠 تحقیقی تجربات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '1. Brain Research: دماغ = کی بورڈ یا ڈیٹا سینٹر؟\n'
                        '2. Hybrid Law: اردو سوالوں کا ریاضی سے جواب\n'
                        '3. Quantum Master: CPU+NPU+GPU مکمل انضمام',
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
                          Text('7', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          Text('تجربات', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('3', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
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
              
              const SizedBox(height: 20),
              
              // Research Progress
              Card(
                color: Colors.orange[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '📈 تحقیق کی پیشرفت',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[900],
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.85,
                        backgroundColor: Colors.grey[300],
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('85% مکمل', style: TextStyle(fontSize: 12)),
                          Text('دماغ فلسفہ', style: TextStyle(fontSize: 12)),
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(height: 12),
              Text(title, 
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold, 
                  color: color,
                  height: 1.2,
                )
              ),
              const SizedBox(height: 4),
              Text(subtitle, 
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 10, 
                  color: Colors.grey[700],
                  height: 1.2,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
