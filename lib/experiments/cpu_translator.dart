import 'cpu_intent.dart';

/// CPU مترجم - سوال کی نوعیت پہچاننے والا
class CPUTranslator {
  
  // 🧠 سوال کی نوعیت پہچاننا
  CPUIntent detectIntent(String question) {
    final q = question.toLowerCase().trim();
    
    // 1️⃣ پیچیدہ فلسفہ (Complex Philosophy) - کائنات اور اس کے راز
    if (q.contains('کائنات') && 
        (q.contains('راز') || 
         q.contains('کیا') || 
         q.contains('کیوں'))) {
      return CPUIntent.complex_philosophy;
    }
    
    // 2️⃣ ریاضی (Math)
    if (_containsAny(q, ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'کتنے', 'حساب', 'دو جمع دو', 'تین ضرب چار'])) {
      return CPUIntent.math;
    }
    
    // 3️⃣ کوانٹم (Quantum)
    if (_containsAny(q, ['کوانٹم', 'سپر پوزیشن', 'اینٹینگلمنٹ', 'شروڈنگر', 'بلی', 'طول موج', 'qubit'])) {
      return CPUIntent.quantum;
    }
    
    // 4️⃣ منطق/پہیلی (Puzzle/Logic)
    if (_containsAny(q, ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق', 'پہیلی', 'حل کریں'])) {
      return CPUIntent.puzzle;
    }
    
    // 5️⃣ عمومی فلسفہ/منطق (Simple Philosophy/Logic)
    if (_containsAny(q, ['کائنات', 'راز', 'وجود', 'حقیقت', 'زندگی', 'موت', 'روح', 'دماغ', 'عقل'])) {
      return CPUIntent.logic;
    }
    
    // 6️⃣ عمومی (General)
    return CPUIntent.general;
  }
  
  // 🔧 ہیلپر فنکشن - الفاظ کی موجودگی چیک کرنے کے لیے
  bool _containsAny(String text, List<String> keys) {
    for (final key in keys) {
      if (text.contains(key)) {
        return true;
      }
    }
    return false;
  }
}
