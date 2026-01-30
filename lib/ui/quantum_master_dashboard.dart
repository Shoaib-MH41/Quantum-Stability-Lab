import 'package:flutter/material.dart';
import '../core/quantum_master.dart';

class QuantumMasterDashboard extends StatefulWidget {
  @override
  _QuantumMasterDashboardState createState() =>
      _QuantumMasterDashboardState();
}

class _QuantumMasterDashboardState extends State<QuantumMasterDashboard> {
  final QuantumMasterController master = QuantumMasterController();
  final TextEditingController controller = TextEditingController();

  String result = '';
  bool isProcessing = false;

  void askQuestion() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      isProcessing = true;
      result = '🧬 سوچ رہا ہوں...';
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      final answer = master.ask(controller.text);

      setState(() {
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
        title: const Text('Quantum Master'),
        backgroundColor: Colors.purple[900],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat / Result Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: result.isEmpty
                    ? const Text(
                        'سوال پوچھیں…',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      )
                    : _chatBubble(result),
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border(
                  top: BorderSide(color: Colors.white12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => askQuestion(),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'اردو یا انگریزی میں سوال لکھیں…',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isProcessing ? Icons.hourglass_bottom : Icons.send,
                      color: Colors.purpleAccent,
                    ),
                    onPressed: isProcessing ? null : askQuestion,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatBubble(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.deepPurple[700],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.5,
        ),
      ),
    );
  }
}
