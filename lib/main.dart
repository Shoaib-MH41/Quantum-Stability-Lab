import 'package:flutter/material.dart';
import 'ui/dashboard.dart';

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
              // Logo
              Icon(
                Icons.science,
                size: 80,
                color: Colors.deepPurple,
              ),
              SizedBox(height: 20),
              
              // Title
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
              
              // Start Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Start Quantum Stability Test',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
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
                        '• Bohr (Quantum) + Einstein (Classical)\n'
                        '• 35ms Fixation Law\n'
                        '• Accident Detection System',
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
