import 'package:flutter/material.dart';
import '../experiments/hybrid_law_system.dart';

class HybridLawDashboard extends StatefulWidget {
  @override
  _HybridLawDashboardState createState() => _HybridLawDashboardState();
}

class _HybridLawDashboardState extends State<HybridLawDashboard> {
  final HybridLawSystem system = HybridLawSystem();
  final TextEditingController controller = TextEditingController();

  final List<_ChatMessage> messages = [];
  bool isProcessing = false;

  void askQuestion() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      isProcessing = true;
      messages.add(_ChatMessage(text, true));
      controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      final answer = system.answer(text);

      setState(() {
        messages.add(_ChatMessage(answer, false));
        isProcessing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Hybrid Law System'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _bubble(msg.text, msg.isUser);
              },
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: const Border(
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
                      hintText: 'اردو میں سوال لکھیں…',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isProcessing ? Icons.hourglass_bottom : Icons.send,
                    color: Colors.deepPurpleAccent,
                  ),
                  onPressed: isProcessing ? null : askQuestion,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueGrey[800] : Colors.deepPurple[700],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage(this.text, this.isUser);
}
