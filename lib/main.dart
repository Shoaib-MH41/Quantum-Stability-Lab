import 'package:flutter/material.dart';
import 'ui/dashboard.dart';

void main() {
  runApp(const QuantumStabilityLabApp());
}

class QuantumStabilityLabApp extends StatelessWidget {
  const QuantumStabilityLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Stability Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quantum Stability Lab'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            const Icon(
              Icons.science,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            
            // Title
            const Text(
              'Quantum Stability Lab',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '35ms Fixation Law Experiment',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Start Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MultiQuantumDashboard()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start 10-Quantum Experiment',
                style: TextStyle(fontSize: 18),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    'Hybrid Quantum-Classical System',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• Bohr (Quantum) + Einstein (Classical)\n'
                    '• 35ms Fixation Law\n'
                    '• 10 Quantum Particles Simulation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
