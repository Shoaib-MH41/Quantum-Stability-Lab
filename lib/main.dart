import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/dashboard.dart';
import 'ui/real_sensor_dashboard.dart';
import 'ui/experiment_history.dart';
import 'core/experiment_manager.dart';
import 'utils/theme.dart';
import 'services/sensor_service.dart';

void main() {
  runApp(QuantumStabilityLabApp());
}

class QuantumStabilityLabApp extends StatelessWidget {
  final SensorService sensorService = SensorService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExperimentManager()),
        Provider<SensorService>(create: (_) => sensorService),
      ],
      child: MaterialApp(
        title: 'Quantum Stability Lab',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: HomeScreen(),
        routes: {
          '/simulation': (context) => MultiQuantumDashboard(),
          '/real-sensor': (context) => RealSensorDashboard(),
          '/history': (context) => ExperimentHistory(),
        },
      ),
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
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
            tooltip: 'تجرباتی تاریخ',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with Quantum Animation
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.science,
                      size: 60,
                      color: Colors.deepPurple,
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Title with Animated Text
                  Column(
                    children: [
                      Text(
                        'Quantum Stability Lab',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '35ms Fixation Law Experiment',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple.shade600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'اتفاق اور قانون کا امتزاج',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple.shade400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 50),
                  
                  // Experiment Cards
                  Column(
                    children: [
                      _buildExperimentCard(
                        context,
                        title: 'سیمیولیشن تجربہ',
                        description: 'الگورتھم پر مبنی\nتمام ڈیوائسز پر یکساں',
                        icon: Icons.memory,
                        color: Colors.deepPurple,
                        route: '/simulation',
                      ),
                      
                      SizedBox(height: 20),
                      
                      _buildExperimentCard(
                        context,
                        title: 'حقیقی سینسر تجربہ',
                        description: 'حقیقی ڈیٹا پر مبنی\nہر ڈیوائس پر مختلف',
                        icon: Icons.sensors,
                        color: Colors.green,
                        route: '/real-sensor',
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 40),
                  
                  // Information Section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.deepPurple.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.deepPurple),
                            SizedBox(width: 10),
                            Text(
                              'تجربے کی معلومات',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _buildInfoItem('کوانٹم پارٹیکلز', '10 متوازی پارٹیکلز'),
                        _buildInfoItem('اپڈیٹ وقفہ', 'ہر 100 ملی سیکنڈ'),
                        _buildInfoItem('ہدف وقت', '35 ملی سیکنڈ'),
                        _buildInfoItem('استحکام رینج', '30-40 ملی سیکنڈ'),
                        _buildInfoItem('ڈیٹا ایکسپورٹ', 'CSV فارمیٹ میں'),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Footer
                  Text(
                    'تحقیق و ترقی: کوانٹم استحکام لیب',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildExperimentCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade300,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
