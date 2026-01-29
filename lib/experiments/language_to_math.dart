class LanguageToMathConverter {
  final Map<String, String> dictionary = {
    'ایک': '1', 'دو': '2', 'تین': '3', 'چار': '4', 'پانچ': '5',
    'چھ': '6', 'سات': '7', 'آٹھ': '8', 'نو': '9', 'دس': '10',
    'جمع': '+', 'اور': '+', 'تفریق': '-', 'منفی': '-',
    'ضرب': '*', 'دفعہ': '*', 'تقسیم': '/', 'بٹا': '/',
  };
  
  String convert(String urduQuestion) {
    String expression = urduQuestion;
    
    // 1. ڈکشنری کے مطابق الفاظ بدلیں
    dictionary.forEach((urdu, math) {
      expression = expression.replaceAll(urdu, ' $math ');
    });
    
    // 2. اہم ترین تبدیلی: نمبروں اور علامتوں کے علاوہ سب کچھ ہٹا دیں
    // یہ ریگولر ایکسپریشن صرف 0-9 اور + - * / کو باقی رکھے گا
    expression = expression.replaceAll(RegExp(r'[^0-9\+\-\*\/\.\s]'), '');
    
    // 3. اضافی سپیس صاف کریں
    expression = expression.trim().replaceAll(RegExp(r'\s+'), ' ');
    
    print('✅ صاف شدہ حساب: "$expression"');
    return expression;
  }

  static LanguageToMathConverter instance() => LanguageToMathConverter();
}
