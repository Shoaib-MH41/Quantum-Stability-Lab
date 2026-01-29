import 'package:flutter/material.dart';
import '../core/quantum_master.dart';

class QuantumMasterDashboard extends StatefulWidget {
  @override
  _QuantumMasterDashboardState createState() => _QuantumMasterDashboardState();
}

class _QuantumMasterDashboardState extends State<QuantumMasterDashboard> {
  final QuantumMasterController master = QuantumMasterController();
  final TextEditingController controller = TextEditingController();
  String result = '';
  bool isProcessing = false;
  
  void askQuestion() {
    if (controller.text.isEmpty) return;
    
    setState(() {
      isProcessing = true;
      result = '🧬 پروسیسنگ...';
    });
    
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        final answer = master.ask(controller.text);
        result = answer;
        isProcessing = false;
        controller.clear();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('🧬 Quantum Master Controller'),
        backgroundColor: Colors.purple[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // System Info
            Card(
              color: Colors.purple[900],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'CPU + NPU + GPU Integration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildChip('🔤 CPU', 'زبان', Colors.blue),
                        _buildChip('🧠 NPU', 'منطق', Colors.green),
                        _buildChip('⚡ GPU', 'حساب', Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Input Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'اردو یا انگریزی میں سوال پوچھیں...',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.question_answer),
                      ),
                      maxLines: 2,
                      onSubmitted: (_) => askQuestion(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: isProcessing ? null : askQuestion,
                      icon: Icon(isProcessing ? Icons.hourglass_bottom : Icons.psychology),
                      label: Text(isProcessing ? 'پروسیسنگ...' : 'سوال پوچھیں'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Result Section
            Expanded(
              child: Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نتیجہ:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          result,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // Examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مثالیں:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildExampleButton('دو جمع دو کیا ہے'),
                        _buildExampleButton('ایکس جمع دو برابر چار'),
                        _buildExampleButton('کائنات کا راز کیا ہے'),
                        _buildExampleButton('دماغ کی بورڈ ہے یا ڈیٹا سینٹر'),
                        _buildExampleButton('تین ضرب چار کتنے'),
                        _buildExampleButton('سپر کمپیوٹر کیا ہے'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildChip(String icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(icon, style: TextStyle(fontSize: 20)),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
  
  Widget _buildExampleButton(String example) {
    return ActionChip(
      label: Text(example, style: TextStyle(fontSize: 12)),
      onPressed: () {
        controller.text = example;
        askQuestion();
      },
      backgroundColor: Colors.purple[100],
    );
  }
}
