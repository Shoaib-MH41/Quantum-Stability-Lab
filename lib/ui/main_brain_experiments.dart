import 'package:flutter/material.dart';
import 'dart:async';
import './brain_research/brain_keyboard_particle.dart';
import './brain_research/brain_datacenter_particle.dart';

void main() {
  runApp(BrainPhilosophyApp());
}

class BrainPhilosophyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'دماغ: کی بورڈ بمقابلہ ڈیٹا سینٹر',
      theme: ThemeData.dark(),
      home: BrainExperimentDashboard(),
    );
  }
}

class BrainExperimentDashboard extends StatefulWidget {
  @override
  _BrainExperimentDashboardState createState() => 
      _BrainExperimentDashboardState();
}

class _BrainExperimentDashboardState 
    extends State<BrainExperimentDashboard> {
  
  final List<BrainKeyboardParticle> keyboardParticles = [];
  final List<BrainDatacenterParticle> datacenterParticles = [];
  
  bool experimentRunning = false;
  int experimentCycles = 0;
  
  // نتائج
  double keyboardEfficiency = 0.0;
  double datacenterEfficiency = 0.0;
  double keyboardMemory = 2.0; // ✅ درست: fixed value
  double datacenterMemory = 10.0; // ✅ درست: fixed value
  
  @override
  void initState() {
    super.initState();
    // 100-100 پارٹیکلز بنائیں
    for (int i = 0; i < 100; i++) {
      keyboardParticles.add(BrainKeyboardParticle(i));
      datacenterParticles.add(BrainDatacenterParticle(i));
    }
  }
  
  void startComparisonExperiment() {
    experimentRunning = true;
    experimentCycles = 0;
    
    // ہر 100ms تجربہ چلائیں
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!experimentRunning) {
        timer.cancel();
        return;
      }
      
      setState(() {
        experimentCycles++;
        
        // کی بورڈ پارٹیکلز
        final keyboardStart = DateTime.now();
        for (var particle in keyboardParticles) {
          particle.applyKeyboardLogic();
        }
        final keyboardTime = DateTime.now().difference(keyboardStart);
        
        // ڈیٹا سینٹر پارٹیکلز
        final datacenterStart = DateTime.now();
        for (var particle in datacenterParticles) {
          particle.applyDatacenterLogic();
        }
        final datacenterTime = DateTime.now().difference(datacenterStart);
        
        // نتائج حساب کریں
        keyboardEfficiency = 1000 / keyboardTime.inMicroseconds.toDouble();
        datacenterEfficiency = 1000 / datacenterTime.inMicroseconds.toDouble();
        
        // ✅ درست: fixed values (میٹرکس کی ضرورت نہیں)
        // keyboardMemory = 2.0; // پہلے ہی set ہے
        // datacenterMemory = 10.0; // پہلے ہی set ہے
        
        // 1000 سائیکلز بعد رک جائیں
        if (experimentCycles >= 1000) {
          experimentRunning = false;
          timer.cancel();
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('🧠 دماغ کا راز: کی بورڈ یا ڈیٹا سینٹر؟'),
      ),
      body: Column(
        children: [
          // کارکردگی چارٹ
          _buildEfficiencyChart(),
          
          // میموری استعمال
          _buildMemoryUsage(),
          
          // کنٹرولز
          _buildControls(),
          
          // فلسفہ
          _buildPhilosophySection(),
        ],
      ),
    );
  }
  
  Widget _buildEfficiencyChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('کارکردگی (زیادہ بہتر)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('کی بورڈ ماڈل', style: TextStyle(color: Colors.blue)),
                    Text('${keyboardEfficiency.toStringAsFixed(2)} ops/ms'),
                  ],
                ),
                Column(
                  children: [
                    Text('ڈیٹا سینٹر ماڈل', style: TextStyle(color: Colors.red)),
                    Text('${datacenterEfficiency.toStringAsFixed(2)} ops/ms'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMemoryUsage() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('میموری استعمال (کم بہتر)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: keyboardMemory / 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Text('کی بورڈ: ${keyboardMemory.toStringAsFixed(2)} KB'),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: datacenterMemory / 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
            Text('ڈیٹا سینٹر: ${datacenterMemory.toStringAsFixed(2)} KB'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: experimentRunning ? null : startComparisonExperiment,
        child: Text(experimentRunning ? 'تجربہ جاری...' : 'تجربہ شروع کریں'),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
  
  Widget _buildPhilosophySection() {
    return ExpansionTile(
      title: Text('📚 فلسفہ تحقیق'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'فرضیہ 1: دماغ = کی بورڈ',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Text('• صرف کنیکشنز رکھتا ہے\n• ڈیٹا نہیں بھولتا\n• کم توانائی\n• تیز فیصلے'),
              
              SizedBox(height: 20),
              
              Text(
                'فرضیہ 2: دماغ = ڈیٹا سینٹر',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              Text('• سب کچھ میموری میں رکھتا ہے\n• بھاری ڈیٹا\n• زیادہ توانائی\n• سست پروسیسنگ'),
              
              SizedBox(height: 20),
              
              Text(
                '❓ سوال تحقیق:',
                style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
              Text('انسانی دماغ 20 واٹ میں کام کرتا ہے۔\nکیا یہ کی بورڈ ہے یا ڈیٹا سینٹر؟'),
            ],
          ),
        ),
      ],
    );
  }
}
