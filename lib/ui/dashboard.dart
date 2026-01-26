import 'package:flutter/material.dart';
import 'dart:async';
import '../core/quantum_particle.dart';
import '../utils/constants.dart';

class MultiQuantumDashboard extends StatefulWidget {
  @override
  _MultiQuantumDashboardState createState() => _MultiQuantumDashboardState();
}

class _MultiQuantumDashboardState extends State<MultiQuantumDashboard> {
  List<QuantumParticle> particles = [];
  int totalAttempts = 0;
  int successfulStabilizations = 0;
  bool isRunning = false;
  Timer? _experimentTimer;
  String systemStatus = "10-کوانٹم ٹیسٹ تیار";
  Color statusColor = Colors.grey;
  List<int> attemptsHistory = [];
  DateTime? experimentStartTime;
  
  // نئی فیچرز کے لیے
  List<List<double>> particleSamples = []; // Noise filtering کے لیے
  double systemConfidence = 0.0;
  int stableCount = 0;
  int borderlineCount = 0;
  int unstableCount = 0;

  @override
  void initState() {
    super.initState();
    initializeParticles();
    initializeSamples();
  }

  void initializeParticles() {
    particles.clear();
    for (int i = 0; i < 10; i++) {
      particles.add(QuantumParticle(i));
    }
  }

  void initializeSamples() {
    particleSamples = List.generate(10, (_) => []);
  }

  void addSample(int particleIndex, double value) {
    particleSamples[particleIndex].add(value);
    if (particleSamples[particleIndex].length > 5) {
      particleSamples[particleIndex].removeAt(0);
    }
  }

  double getFilteredValue(int particleIndex) {
    final samples = particleSamples[particleIndex];
    if (samples.isEmpty) return particles[particleIndex].currentTime;
    if (samples.length < 3) return samples.average;
    
    // Noise filtering: Remove outliers (min & max)
    final sorted = List.from(samples)..sort();
    final filtered = sorted.sublist(1, sorted.length - 1); // Remove min and max
    return filtered.average;
  }

  ParticleClassification classifyParticle(double value) {
    if (value <= 30.0) return ParticleClassification.STABLE;
    if (value <= 40.0) return ParticleClassification.BORDERLINE;
    return ParticleClassification.UNSTABLE;
  }

  void startQuantumExperiment() {
    setState(() {
      isRunning = true;
      totalAttempts = 0;
      successfulStabilizations = 0;
      attemptsHistory.clear();
      initializeParticles();
      initializeSamples();
      systemStatus = "10-کوانٹم استحکام جاری...";
      statusColor = Colors.blue;
      experimentStartTime = DateTime.now();
      stableCount = 0;
      borderlineCount = 0;
      unstableCount = 0;
      systemConfidence = 0.0;
    });

    _experimentTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      updateQuantumSystem();
    });
  }

  void updateQuantumSystem() {
    setState(() {
      totalAttempts++;
      
      // Collective Decision Engine
      stableCount = 0;
      borderlineCount = 0;
      unstableCount = 0;
      
      for (int i = 0; i < particles.length; i++) {
        var particle = particles[i];
        particle.apply35msLaw();
        
        // Add sample for noise filtering
        addSample(i, particle.currentTime);
        
        // Classify particle with filtered value
        final filteredValue = getFilteredValue(i);
        final classification = classifyParticle(filteredValue);
        
        switch (classification) {
          case ParticleClassification.STABLE:
            stableCount++;
            break;
          case ParticleClassification.BORDERLINE:
            borderlineCount++;
            break;
          case ParticleClassification.UNSTABLE:
            unstableCount++;
            break;
        }
      }
      
      // System Confidence Score Calculation
      systemConfidence = (stableCount * 1.0 + borderlineCount * 0.5) / particles.length;
      
      // Update status based on collective decision
      final int fullyStableParticles = particles.where((p) => p.isFullyStable).length;
      
      if (fullyStableParticles == 10) {
        successfulStabilizations++;
        _experimentTimer?.cancel();
        isRunning = false;
        
        final duration = DateTime.now().difference(experimentStartTime!);
        final seconds = duration.inMilliseconds / 1000.0;
        
        systemStatus = "کمال! تمام 10 پارٹیکل مستحکم\n"
                      "وقت: ${seconds.toStringAsFixed(2)} سیکنڈ\n"
                      "آخری اعتماد: ${(systemConfidence * 100).toStringAsFixed(1)}%";
        statusColor = Colors.green;
        
        attemptsHistory.add(totalAttempts);
        
        Timer(Duration(seconds: 2), () {
          if (mounted) {
            startQuantumExperiment();
          }
        });
        
      } else {
        // Dynamic status based on collective decision
        if (systemConfidence >= 0.8) {
          systemStatus = "اعلیٰ استحکام (${(systemConfidence * 100).toStringAsFixed(1)}%)\n"
                        "مستحکم: $stableCount | سرحدی: $borderlineCount | غیر مستحکم: $unstableCount";
          statusColor = Colors.green;
        } else if (systemConfidence >= 0.6) {
          systemStatus = "نیم مستحکم (${(systemConfidence * 100).toStringAsFixed(1)}%)\n"
                        "مستحکم: $stableCount | سرحدی: $borderlineCount | غیر مستحکم: $unstableCount";
          statusColor = Colors.orange;
        } else if (systemConfidence >= 0.4) {
          systemStatus = "غیر یقینی (${(systemConfidence * 100).toStringAsFixed(1)}%)\n"
                        "مستحکم: $stableCount | سرحدی: $borderlineCount | غیر مستحکم: $unstableCount";
          statusColor = Colors.red;
        } else {
          systemStatus = "غیر مستحکم (${(systemConfidence * 100).toStringAsFixed(1)}%)\n"
                        "مستحکم: $stableCount | سرحدی: $borderlineCount | غیر مستحکم: $unstableCount";
          statusColor = Colors.red[800]!;
        }
      }
    });
  }

  void stopExperiment() {
    _experimentTimer?.cancel();
    setState(() {
      isRunning = false;
      systemStatus = "ٹیسٹ روک دیا\n"
                    "کل کوششیں: $totalAttempts\n"
                    "کامیاب استحکام: $successfulStabilizations\n"
                    "آخری اعتماد: ${(systemConfidence * 100).toStringAsFixed(1)}%";
      statusColor = Colors.grey;
    });
  }

  @override
  void dispose() {
    _experimentTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10-کوانٹم استحکام تجربہ"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔥 Collective Decision Engine Card
              Card(
                elevation: 4,
                color: Colors.deepPurple[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "اجتماعی فیصلہ انجن",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[800],
                        ),
                      ),
                      SizedBox(height: 15),
                      
                      // Confidence Score
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor(systemConfidence),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "نظام کا اعتماد",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${(systemConfidence * 100).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              _getConfidenceIcon(systemConfidence),
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 15),
                      
                      // Particle Classification Summary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildClassificationBox("✅ مستحکم", "$stableCount", Colors.green),
                          _buildClassificationBox("⚠ سرحدی", "$borderlineCount", Colors.orange),
                          _buildClassificationBox("❌ غیر مستحکم", "$unstableCount", Colors.red),
                        ],
                      ),
                      
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 5),
                      
                      // Final Verdict
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gavel,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _getVerdictText(systemConfidence),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getVerdictColor(systemConfidence),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // تجربے کی معلومات
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoBox("کل کوششیں", "$totalAttempts", Colors.blue),
                          _buildInfoBox("کامیاب استحکام", "$successfulStabilizations", Colors.green),
                          _buildInfoBox("Noise Filter", "ON", Colors.purple),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "آخری 5 نمونوں کا اوسط (outliers removed)",
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // 10 پارٹیکلز کا گرڈ
              Text(
                "کوانٹم پارٹیکلز - باکلاسیفیکیشن",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: particles.length,
                itemBuilder: (context, index) {
                  final particle = particles[index];
                  final filteredValue = getFilteredValue(index);
                  final classification = classifyParticle(filteredValue);
                  return _buildParticleCard(particle, index, filteredValue, classification);
                },
              ),
              
              SizedBox(height: 20),
              
              // نظام کی حالت
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
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // بٹنز
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isRunning ? null : startQuantumExperiment,
                      icon: Icon(Icons.play_arrow),
                      label: Text(isRunning ? "جاری ہے..." : "ٹیسٹ شروع کریں"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isRunning ? stopExperiment : null,
                      icon: Icon(Icons.stop),
                      label: Text("روکیں"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Quantum Logic Explanation
              Card(
                color: Colors.indigo[50],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.science, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text(
                            "کوانٹم منطق (Decoherence Detector)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "• پارٹیکلز متفق ← Coherence (استحکام)\n"
                        "• پارٹیکلز منتشر ← Decoherence (عدم استحکام)\n"
                        "• فیصلہ اجتماعی اتفاق سے کیا جاتا ہے\n"
                        "• Noise filtering: outliers حذف، smooth نتائج",
                        style: TextStyle(fontSize: 14, color: Colors.indigo[800]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "📊 Export System: CSV/JSON آئندہ ورژن میں",
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // History
              if (attemptsHistory.isNotEmpty) ...[
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تجرباتی تاریخ (آخری 5):",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: attemptsHistory.reversed.take(5).map((attempts) {
                            return Chip(
                              label: Text("$attempts کوششیں"),
                              backgroundColor: attempts <= 20 
                                ? Colors.green[100] 
                                : attempts <= 50 
                                  ? Colors.orange[100] 
                                  : Colors.red[100],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildClassificationBox(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoBox(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
  
  Widget _buildParticleCard(QuantumParticle particle, int index, double filteredValue, 
                           ParticleClassification classification) {
    final classificationColor = classification == ParticleClassification.STABLE
        ? Colors.green
        : classification == ParticleClassification.BORDERLINE
            ? Colors.orange
            : Colors.red;
    
    final classificationIcon = classification == ParticleClassification.STABLE
        ? Icons.check_circle
        : classification == ParticleClassification.BORDERLINE
            ? Icons.warning
            : Icons.error;
    
    return Card(
      elevation: 3,
      color: classificationColor.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "پارٹیکل ${index + 1}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: classificationColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: classificationColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(classificationIcon, size: 12, color: classificationColor),
                      SizedBox(width: 4),
                      Text(
                        classification == ParticleClassification.STABLE
                            ? "مستحکم"
                            : classification == ParticleClassification.BORDERLINE
                                ? "سرحدی"
                                : "غیر مستحکم",
                        style: TextStyle(fontSize: 10, color: classificationColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            // Raw and Filtered Values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Raw",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      "${particle.currentTime.toStringAsFixed(1)} ms",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Filtered",
                      style: TextStyle(fontSize: 10, color: Colors.purple),
                    ),
                    Text(
                      "${filteredValue.toStringAsFixed(1)} ms",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Progress bar for classification
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: filteredValue / 50.0,
              backgroundColor: Colors.grey[200],
              color: classificationColor,
              minHeight: 3,
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    if (confidence >= 0.4) return Colors.red;
    return Colors.red[800]!;
  }
  
  IconData _getConfidenceIcon(double confidence) {
    if (confidence >= 0.8) return Icons.verified;
    if (confidence >= 0.6) return Icons.warning;
    return Icons.error;
  }
  
  String _getVerdictText(double confidence) {
    if (confidence >= 0.8) return "مکمل مستحکم نظام";
    if (confidence >= 0.6) return "نیم مستحکم نظام";
    if (confidence >= 0.4) return "غیر یقینی نظام";
    return "غیر مستحکم نظام";
  }
  
  Color _getVerdictColor(double confidence) {
    if (confidence >= 0.8) return Colors.green[800]!;
    if (confidence >= 0.6) return Colors.orange[800]!;
    if (confidence >= 0.4) return Colors.red[800]!;
    return Colors.red[900]!;
  }
  
  IconData _getStatusIcon() {
    if (systemStatus.contains("کمال")) return Icons.celebration;
    if (systemConfidence >= 0.8) return Icons.verified;
    if (systemConfidence >= 0.6) return Icons.warning;
    return Icons.error;
  }
}

enum ParticleClassification {
  STABLE,
  BORDERLINE,
  UNSTABLE
}

extension ListExtension on List<double> {
  double get average {
    if (isEmpty) return 0;
    return reduce((a, b) => a + b) / length;
  }
}
