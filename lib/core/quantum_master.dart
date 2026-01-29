import '../experiments/hybrid_law_system.dart';

class QuantumMasterController {
  final HybridLawSystem hybridSystem = HybridLawSystem();
  
  // سسٹم کا فلسفہ
  String get philosophy {
    return '''
🧠 Quantum Master Controller فلسفہ:

1. **CPU**: زبان سمجھنا (اردو ←→ انگریزی)
2. **NPU**: منطق + قوانین (کی بورڈ ماڈل)  
3. **GPU**: حساب + طاقت (قانونی حساب)
4. **دماغ**: تمام کا انضمام

🔗 یہ نظام انسانی دماغ کی طرح کام کرتا ہے:
- CPU: زبان مرکز
- NPU: منطقی سوچ  
- GPU: عملی حساب
''';
  }

  String ask(String urduQuestion) {
    print('\n🧬 Quantum Master Processing: "$urduQuestion"');
    
    try {
      // Hybrid System استعمال کریں
      final result = hybridSystem.answer(urduQuestion);
      
      // فلسفیانہ تشریح شامل کریں
      final philosophicalInterpretation = _addPhilosophy(result, urduQuestion);
      
      return '''
🤖 Quantum Master جواب:

سوال: $urduQuestion

🧮 حساب نتیجہ: $result

💭 فلسفیانہ تشریح: $philosophicalInterpretation

🔬 تحقیق کا نتیجہ: ${_getResearchConclusion(result)}
''';
      
    } catch (e) {
      return '❌ Quantum Master میں مسئلہ: $e';
    }
  }
  
  String _addPhilosophy(String result, String question) {
    if (question.contains('کائنات') || question.contains('کوانٹم')) {
      return 'کوانٹم دنیا میں ہر چیز سپر پوزیشن میں ہے۔';
    }
    
    if (question.contains('دماغ') || question.contains('عقل')) {
      return 'دماغ کی بورڈ کی طرح ہے، ڈیٹا سینٹر نہیں۔';
    }
    
    if (result.contains('30') || result.contains('35')) {
      return 'تثبیت کا قانون (Fixation Law) نظر آ رہا ہے۔';
    }
    
    return 'حساب کائنات کی بنیادی زبان ہے۔';
  }
  
  String _getResearchConclusion(String result) {
    if (result.contains('طار')) return 'NPU ماڈل کامیاب: کی بورڈ طریقہ بہتر ہے۔';
    if (result.contains('بارہ')) return 'GPU ماڈل کامیاب: طاقت طریقہ بہتر ہے۔';
    if (result.contains('پانچ')) return 'مرکب نظام کامیاب: دونوں طریقوں کی ضرورت ہے۔';
    
    return 'تحقیق جاری ہے۔ نتائج تجزیہ کے تحت ہیں۔';
  }
  
  // سسٹم ٹیسٹ
  void runMasterTests() {
    print('🧬 Quantum Master Controller - مکمل نظام ٹیسٹ');
    
    final questions = [
      'دو جمع دو کیا ہے',
      'تین ضرب چار کتنے',
      'دماغ کی بورڈ ہے یا ڈیٹا سینٹر',
    ];
    
    for (var question in questions) {
      print('\nسوال: $question');
      print(ask(question));
    }
  }
}
