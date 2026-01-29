class LanguageToMathConverter {
  // اردو الفاظ ←→ ریاضی علامات
  final Map<String, String> dictionary = {
    // اعداد
    'ایک': '1', 'دو': '2', 'تین': '3', 'چار': '4', 'پانچ': '5',
    'چھ': '6', 'سات': '7', 'آٹھ': '8', 'نو': '9', 'دس': '10',
    
    // عملیات
    'جمع': '+', 'اور': '+', 'کا مجموعہ': '+',
    'تفریق': '-', 'منفی': '-',
    'ضرب': '*', 'کا حاصل ضرب': '*', 'دفعہ': '*',
    'تقسیم': '/', 'بٹا': '/',
    
    // سوال کے الفاظ
    'کیا ہے': '=', 'کتنے': '=', 'ہے': '=',
  };
  
  // اردو سوال کو ریاضی ایکسپریشن میں بدلیں
  String convert(String urduQuestion) {
    String expression = urduQuestion;
    
    // 1. تمام الفاظ کو ریاضی علامات میں بدلیں
    dictionary.forEach((urdu, math) {
      expression = expression.replaceAll(urdu, math);
    });
    
    // 2. اضافی سپیس ہٹائیں
    expression = expression.trim();
    
    // 3. "=" شامل کریں اگر نہیں ہے
    if (!expression.contains('=')) {
      expression += ' =';
    }
    
    print('✅ اردو → حساب: "$urduQuestion" → "$expression"');
    return expression;
  }
  
  // ✅ درست: یہی کلاس کا نام استعمال کریں
  static LanguageToMathConverter instance() {
    return LanguageToMathConverter();
  }
}
