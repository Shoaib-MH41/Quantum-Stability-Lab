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
  final ScrollController _scrollController = ScrollController(); // اسکرول کنٹرولر
  
  String result = '';
  bool isProcessing = false;

  void askQuestion() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      isProcessing = true;
      result = '🧬 سوچ رہا ہوں...';
    });

    // جواب آنے پر خودکار اسکرول کے لیے
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      final answer = master.ask(controller.text);

      setState(() {
        result = answer;
        isProcessing = false;
        controller.clear();
      });

      // جواب آنے کے فوراً بعد نیچے اسکرول کریں
      _scrollToBottom();
    });
  }

  // نیچے اسکرول کرنے کا فنکشن
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // وقفے وقفے سے اسکرول کی پوزیشن چیک کریں
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // میموری لیک سے بچاؤ
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Quantum Master'),
        backgroundColor: Colors.purple[900],
        centerTitle: true,
        actions: [
          // کلئیر چٹ کیو کے لیے بٹن
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'مکالمہ صاف کریں',
            onPressed: () {
              setState(() {
                result = '';
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat / Result Area with ScrollController
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // کنٹرولر جوڑیں
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: result.isEmpty
                    ? _buildEmptyState()
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => askQuestion(),
                      onChanged: (_) => setState(() {}), // Clear button کے لیے
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اردو یا انگریزی میں سوال لکھیں…',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        suffixIcon: controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                color: Colors.grey[400],
                                onPressed: () {
                                  controller.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Animated Send Button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isProcessing
                          ? Colors.grey[700]
                          : (controller.text.trim().isNotEmpty
                              ? Colors.purpleAccent
                              : Colors.grey[700]),
                      boxShadow: [
                        if (!isProcessing && controller.text.trim().isNotEmpty)
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isProcessing
                            ? Icons.hourglass_bottom
                            : Icons.send_rounded,
                        color: Colors.white,
                      ),
                      onPressed: isProcessing || controller.text.trim().isEmpty
                          ? null
                          : askQuestion,
                      tooltip: isProcessing ? 'پروسیسنگ...' : 'بھیجیں',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button for quick scroll
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology_outlined,
            size: 80,
            color: Colors.purple[300]!.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          const Text(
            'سوال پوچھیں…',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'مثال کے طور پر:',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          _exampleChip('دو جمع دو کیا ہے؟'),
          _exampleChip('سپر پوزیشن کیا ہے؟'),
          _exampleChip('کائنات کا سب سے بڑا راز؟'),
        ],
      ),
    );
  }

  Widget _exampleChip(String text) {
    return GestureDetector(
      onTap: () {
        controller.text = text;
        askQuestion();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple[300]!.withOpacity(0.3)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.purple[100],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _chatBubble(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple[700],
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timestamp
          Text(
            '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          // Selectable Text
          SelectableText(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          // Copy Button
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.content_copy, size: 18),
              color: Colors.white.withOpacity(0.6),
              onPressed: () {
                _copyToClipboard(text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('جواب کاپی ہو گیا'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Floating Action Button for Scroll
  Widget _buildFloatingActionButton() {
    return FloatingActionButton.small(
      backgroundColor: Colors.purple[800],
      child: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      onPressed: _scrollToBottom,
      tooltip: 'نیچے اسکرول کریں',
      heroTag: 'scroll_fab',
    );
  }

  // Copy to Clipboard
  void _copyToClipboard(String text) {
    // Flutter Clipboard API
  }
}
