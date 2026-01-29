import 'package:flutter/material.dart';
import '../experiments/hybrid_law_system.dart';

class HybridLawDashboard extends StatefulWidget {
  @override
  _HybridLawDashboardState createState() => _HybridLawDashboardState();
}

class _HybridLawDashboardState extends State<HybridLawDashboard> {
  final HybridLawSystem system = HybridLawSystem();
  final TextEditingController controller = TextEditingController();
  String result = '';
  List<String> history = [];
  
  void askQuestion() {
    if (controller.text.isEmpty) return;
    
    setState(() {
      final question = controller.text;
      final answer = system.answer(question);
      
      result = answer;
      history.add('سوال: $question\nجواب: $answer\n');
      
      controller.clear();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('🧠 ہائبرڈ قانونی نظام'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ان پٹ فیلڈ
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'اردو میں سوال لکھیں...',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.question_answer),
                      ),
                      onSubmitted: (_) => askQuestion(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: askQuestion,
                      icon: Icon(Icons.psychology),
                      label: Text('سوال پوچھیں'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // نتیجہ
            Card(
              color: Colors.green[900],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('نتیجہ:', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(height: 10),
                    Text(result, style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    )),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            // مثالیں
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مثالیں:', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                      SizedBox(height: 10),
                      ...['دو جمع دو کیا ہے', 'تین ضرب چار کتنے', 'دس تفریق پانچ ہے']
                          .map((example) => ListTile(
                        title: Text(example),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          controller.text = example;
                          askQuestion();
                        },
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ),
            
            // ہسٹری
            if (history.isNotEmpty) ...[
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('سوالوں کی تاریخ:', style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                      ...history.reversed.take(3).map((item) => 
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(item, style: TextStyle(fontSize: 12)),
                        )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
