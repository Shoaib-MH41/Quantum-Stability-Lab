import 'package:flutter/material.dart';
import 'ui/dashboard.dart';
import 'ui/experiment_history.dart'; // اب یہ فائل موجود ہے

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
      ),
      home: HomeScreen(),
      routes: {
        '/simulation': (context) => MultiQuantumDashboard(),
        '/history': (context) => ExperimentHistory(),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.science,
                size: 80,
                color: Colors.deepPurple,
              ),
              SizedBox(height: 20),
              
              Text(
                'Quantum Stability Lab',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '35ms Fixation Law Experiment',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
              
              SizedBox(height: 40),
              
              // Simulation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/simulation');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('سیمیولیشن ٹیسٹ شروع کریں'),
                ),
              ),
              
              SizedBox(height: 20),
              
              // History Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('تجرباتی تاریخ'),
                ),
              ),
              
              SizedBox(height: 30),
              
              // Info Card
              Card(
                color: Colors.deepPurple.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Hybrid Quantum-Classical System',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '• 10 Quantum Particles\n'
                        '• 35ms Fixation Law\n'
                        '• Real-time Simulation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
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
}
