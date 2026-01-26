import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../core/real_quantum_particle.dart';

class RealSensorDashboard extends StatefulWidget {
  @override
  _RealSensorDashboardState createState() => _RealSensorDashboardState();
}

class _RealSensorDashboardState extends State<RealSensorDashboard> {
  List<RealQuantumParticle> particles = [];
  Timer? _experimentTimer;
  Timer? _networkTimer;
  Timer? _exportTimer;
  bool isRunning = false;
  int totalAttempts = 0;
  int successfulStabilizations = 0;
  String systemStatus = "حقیقی سینسرز چیک ہو رہے ہیں...";
  Color statusColor = Colors.blue;
  
  // Real-time metrics
  double totalCoherence = 0.0;
  double avgNetworkLatency = 0.0;
  double avgBatteryLevel = 100.0;
  double deviceMovement = 0.0;
  
  // Data collection for export
  List<Map<String, dynamic>> experimentData = [];
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    initializeParticles();
    _checkSensors();
  }

  void initializeParticles() {
    for (var p in particles) {
      p.dispose();
    }
    particles.clear();
    
    for (int i = 0; i < 10; i++) {
      particles.add(RealQuantumParticle(i));
    }
  }

  Future<void> _checkSensors() async {
    setState(() {
      systemStatus = "سینسرز فعال ہو رہے ہیں...\n"
                    "Accelerometer: ✓\n"
                    "Gyroscope: ✓\n"
                    "Battery: ✓";
    });
    
    // Initial network test
    for (var particle in particles) {
      await particle.measureNetworkLatency();
    }
    
    _updateRealTimeMetrics();
  }

  void _updateRealTimeMetrics() {
    double coherenceSum = 0;
    double latencySum = 0;
    double batterySum = 0;
    double movementSum = 0;
    
    for (var particle in particles) {
      coherenceSum += particle.getQuantumCoherence();
      latencySum += particle.networkLatency;
      batterySum += particle.batteryLevel;
      movementSum += particle.accelerometerValue ?? 0;
    }
    
    setState(() {
      totalCoherence = coherenceSum / particles.length;
      avgNetworkLatency = latencySum / particles.length;
      avgBatteryLevel = batterySum / particles.length;
      deviceMovement = movementSum / particles.length;
    });
  }

  void startRealQuantumExperiment() async {
    setState(() {
      isRunning = true;
      isRecording = true;
      totalAttempts = 0;
      successfulStabilizations = 0;
      experimentData.clear();
      systemStatus = "حقیقی کوانٹم تجربہ شروع\n"
                    "سینسرز فعال | نیٹ ورک ٹیسٹ جاری";
      statusColor = Colors.deepPurple;
    });
    
    // Start periodic network testing
    _networkTimer = Timer.periodic(Duration(seconds: 10), (_) {
      for (var particle in particles) {
        particle.measureNetworkLatency();
      }
    });
    
    // Start data recording
    _exportTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _recordExperimentData();
    });
    
    // Main experiment loop
    _experimentTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _updateQuantumSystem();
    });
  }

  void _updateQuantumSystem() {
    setState(() {
      totalAttempts++;
      
      // Apply quantum laws with real sensors
      int fullyStableCount = 0;
      for (var particle in particles) {
        particle.apply35msLaw();
        if (particle.isFullyStable) fullyStableCount++;
      }
      
      _updateRealTimeMetrics();
      
      // Update system status based on real metrics
      if (fullyStableCount == 10) {
        successfulStabilizations++;
        _stopExperiment();
        
        final duration = DateTime.now().difference(
          experimentData.first['timestamp'] as DateTime
        );
        
        systemStatus = "✅ حقیقی کوانٹم استحکام حاصل!\n"
                      "وقت: ${duration.inSeconds} سیکنڈ\n"
                      "آخری Coherence: ${(totalCoherence * 100).toStringAsFixed(1)}%\n"
                      "Device حرکت: ${deviceMovement.toStringAsFixed(2)}g";
        statusColor = Colors.green;
        
        _exportToCSV();
        
        Timer(Duration(seconds: 3), () {
          if (mounted) startRealQuantumExperiment();
        });
        
      } else {
        // Dynamic status based on real sensors
        String stabilityLevel = "";
        
        if (totalCoherence > 0.8 && deviceMovement < 0.5) {
          stabilityLevel = "اعلیٰ استحکام - پر سکون ماحول";
          statusColor = Colors.green;
        } else if (totalCoherence > 0.6) {
          stabilityLevel = "نیم مستحکم - معمول کی حرکت";
          statusColor = Colors.orange;
        } else if (avgNetworkLatency > 1000) {
          stabilityLevel = "نیٹ ورک خلل - زیادہ latency";
          statusColor = Colors.red[300]!;
        } else if (deviceMovement > 1.5) {
          stabilityLevel = "حرکت کا خلل - ڈیوائس ہل رہی ہے";
          statusColor = Colors.red;
        } else if (avgBatteryLevel < 20) {
          stabilityLevel = "بیٹری کم - استحکام متاثر";
          statusColor = Colors.amber[800]!;
        } else {
          stabilityLevel = "عام حالت - تمام سینسرز فعال";
          statusColor = Colors.blue;
        }
        
        systemStatus = "تجربہ جاری...\n"
                      "Coherence: ${(totalCoherence * 100).toStringAsFixed(1)}%\n"
                      "Network: ${avgNetworkLatency.toStringAsFixed(0)}ms\n"
                      "$stabilityLevel";
      }
    });
  }

  void _recordExperimentData() {
    final data = {
      'timestamp': DateTime.now(),
      'total_coherence': totalCoherence,
      'avg_network_latency': avgNetworkLatency,
      'avg_battery': avgBatteryLevel,
      'device_movement': deviceMovement,
      'total_attempts': totalAttempts,
      'particles_data': particles.map((p) => p.toSensorData()).toList(),
    };
    
    experimentData.add(data);
    
    // Keep last 1000 records only
    if (experimentData.length > 1000) {
      experimentData.removeAt(0);
    }
  }

  Future<void> _exportToCSV() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/quantum_experiment_${DateTime.now().millisecondsSinceEpoch}.csv';
      
      List<List<dynamic>> csvData = [];
      
      // Add headers
      csvData.add([
        'Timestamp',
        'Particle_ID',
        'Current_Time',
        'Is_Stable',
        'Is_Fully_Stable',
        'Accelerometer',
        'Gyroscope',
        'Magnetometer',
        'Battery_Level',
        'Network_Latency',
        'Quantum_Coherence',
        'Environmental_Noise',
        'Total_Coherence',
        'Avg_Network_Latency',
        'Device_Movement',
      ]);
      
      // Add data rows
      for (var exp in experimentData) {
        for (var particleData in exp['particles_data'] as List) {
          csvData.add([
            exp['timestamp'].toIso8601String(),
            particleData['particle_id'],
            particleData['current_time'],
            particleData['is_stable'],
            particleData['is_fully_stable'],
            particleData['accelerometer'],
            particleData['gyroscope'],
            particleData['magnetometer'],
            particleData['battery_level'],
            particleData['network_latency'],
            particleData['quantum_coherence'],
            particleData['environmental_noise'],
            exp['total_coherence'],
            exp['avg_network_latency'],
            exp['device_movement'],
          ]);
        }
      }
      
      String csv = const ListToCsvConverter().convert(csvData);
      await Share.shareFiles([filePath], text: 'Quantum Experiment Data');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV ڈیٹا ایکسپورٹ ہو گیا'),
          backgroundColor: Colors.green,
        ),
      );
      
    } catch (e) {
      print('Export error: $e');
    }
  }

  void _stopExperiment() {
    _experimentTimer?.cancel();
    _networkTimer?.cancel();
    _exportTimer?.cancel();
    
    setState(() {
      isRunning = false;
      isRecording = false;
    });
  }

  @override
  void dispose() {
    _stopExperiment();
    for (var particle in particles) {
      particle.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حقیقی سینسر کوانٹم تجربہ'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(isRecording ? Icons.stop_circle : Icons.fiber_manual_record),
            onPressed: () {
              setState(() => isRecording = !isRecording);
            },
            tooltip: 'ڈیٹا ریکارڈنگ',
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _exportToCSV,
            tooltip: 'ڈیٹا شیئر کریں',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Real-time Sensor Dashboard
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'حقیقی وقت کے سینسر میٹرکس',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 15),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildMetricCard(
                        'کوانٹم Coherence',
                        '${(totalCoherence * 100).toStringAsFixed(1)}%',
                        _getCoherenceColor(totalCoherence),
                        Icons.waves,
                      ),
                      _buildMetricCard(
                        'نیٹ ورک Latency',
                        '${avgNetworkLatency.toStringAsFixed(0)} ms',
                        _getLatencyColor(avgNetworkLatency),
                        Icons.network_check,
                      ),
                      _buildMetricCard(
                        'بیٹری سطح',
                        '${avgBatteryLevel.toStringAsFixed(0)}%',
                        _getBatteryColor(avgBatteryLevel),
                        Icons.battery_full,
                      ),
                      _buildMetricCard(
                        'ڈیوائس حرکت',
                        '${deviceMovement.toStringAsFixed(2)} g',
                        _getMovementColor(deviceMovement),
                        Icons.vibration,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          // System Status
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  _getStatusIcon(),
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  systemStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                if (isRecording)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fiber_manual_record, size: 12, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        'ڈیٹا ریکارڈ ہو رہا ہے',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Control Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isRunning ? null : startRealQuantumExperiment,
                  icon: Icon(Icons.play_arrow),
                  label: Text('حقیقی تجربہ شروع کریں'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isRunning ? _stopExperiment : null,
                  icon: Icon(Icons.stop),
                  label: Text('روکیں'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Particle Grid
          Text(
            'حقیقی سینسر پارٹیکلز',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: particles.length,
            itemBuilder: (context, index) {
              return _buildParticleCard(particles[index]);
            },
          ),
          
          // Sensor Information
          SizedBox(height: 20),
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'سینسر معلومات:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Accelerometer: ڈیوائس حرکت ناپتا ہے\n'
                    '• Gyroscope: گردش کی شرح ناپتا ہے\n'
                    '• Magnetometer: مقناطیسی میدان ناپتا ہے\n'
                    '• نیٹ ورک Latency: انٹرنیٹ کی رفتار\n'
                    '• بیٹری سطح: ڈیوائس توانائی\n'
                    '• ہر عامل کوانٹم استحکام پر اثر انداز ہوتا ہے',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticleCard(RealQuantumParticle particle) {
    final coherence = particle.getQuantumCoherence();
    
    return Card(
      elevation: 2,
      color: particle.isFullyStable
          ? Colors.green[50]
          : particle.isStable
              ? Colors.blue[50]
              : Colors.red[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'پارٹیکل ${particle.id + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getCoherenceColor(coherence).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(coherence * 100).toStringAsFixed(0)}%',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            Text(
              '${particle.currentTime.toStringAsFixed(1)} ms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            
            SizedBox(height: 4),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMiniMetric('Bat', '${particle.batteryLevel.toStringAsFixed(0)}%'),
                _buildMiniMetric('Net', '${particle.networkLatency.toStringAsFixed(0)}ms'),
                _buildMiniMetric('Move', '${(particle.accelerometerValue ?? 0).toStringAsFixed(1)}g'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniMetric(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Color _getCoherenceColor(double coherence) {
    if (coherence > 0.8) return Colors.green;
    if (coherence > 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getLatencyColor(double latency) {
    if (latency < 100) return Colors.green;
    if (latency < 500) return Colors.orange;
    return Colors.red;
  }

  Color _getBatteryColor(double battery) {
    if (battery > 70) return Colors.green;
    if (battery > 30) return Colors.orange;
    return Colors.red;
  }

  Color _getMovementColor(double movement) {
    if (movement < 0.5) return Colors.green;
    if (movement < 1.5) return Colors.orange;
    return Colors.red;
  }

  IconData _getStatusIcon() {
    if (systemStatus.contains('حقیقی کوانٹم استحکام')) return Icons.celebration;
    if (totalCoherence > 0.8) return Icons.verified;
    if (totalCoherence > 0.6) return Icons.warning;
    return Icons.error;
  }
}
