import 'package:flutter/material.dart';
import 'ui/dashboard.dart';
import 'ui/experiment_history.dart';
import 'ui/multi_quantum_dashboard.dart';
import 'ui/real_sensor_dashboard.dart';
import 'ui/intelligence_vs_strength_test.dart';

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
        '/dashboard': (context) => Dashboard(),
        '/simulation': (context) => MultiQuantumDashboard(),
        '/history': (context) => ExperimentHistory(),
        '/sensor': (context) => RealSensorDashboard(),
        '/intelligence': (context) => IntelligenceVsStrengthTest(),
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
              // Header
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 40),
                child: Column(
                  children: [
                    Icon(
                      Icons.science,
                      size: 80,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Quantum Stability Lab',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '35ms Fixation Law Experiments',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple[700],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Experiment Cards Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  // Card 1: Basic Dashboard
                  _buildExperimentCard(
                    context: context,
                    title: 'Basic Test',
                    subtitle: 'Single Particle',
                    icon: Icons.play_circle_fill,
                    color: Colors.green,
                    route: Dashboard(),
                  ),
                  
                  // Card 2: 2000 Particles
                  _buildExperimentCard(
                    context: context,
                    title: '2000 Particles',
                    subtitle: 'Mass Simulation',
                    icon: Icons.psychology,
                    color: Colors.blue,
                    route: MultiQuantumDashboard(),
                  ),
                  
                  // Card 3: Real Sensor Test
                  _buildExperimentCard(
                    context: context,
                    title: 'Real Sensors',
                    subtitle: 'Mobile Sensors',
                    icon: Icons.sensors,
                    color: Colors.orange,
                    route: RealSensorDashboard(),
                  ),
                  
                  // Card 4: Intelligence vs Strength
                  _buildExperimentCard(
                    context: context,
                    title: 'Strength 🆚 Intelligence',
                    subtitle: 'GPU vs NPU',
                    icon: Icons.bolt,
                    color: Colors.purple,
                    route: IntelligenceVsStrengthTest(),
                  ),
                  
                  // Card 5: Experiment History
                  _buildExperimentCard(
                    context: context,
                    title: 'History',
                    subtitle: 'Past Experiments',
                    icon: Icons.history,
                    color: Colors.teal,
                    route: ExperimentHistory(),
                  ),
                  
                  // Card 6: Philosophy
                  _buildExperimentCard(
                    context: context,
                    title: 'Philosophy',
                    subtitle: 'Bohr vs Einstein',
                    icon: Icons.lightbulb,
                    color: Colors.deepOrange,
                    route: Dashboard(), // یا philosophy screen
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Footer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Scientific Principles:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '• Quantum (Bohr) + Classical (Einstein) Hybrid\n'
                      '• 35ms Fixation Law Application\n'
                      '• Real-time Quantum Simulation\n'
                      '• Strength vs Intelligence Analysis',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepPurple[800],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Credits
              Text(
                '⚛️ بوہر + آئنسٹائن کا امتزاج ⚖️',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
