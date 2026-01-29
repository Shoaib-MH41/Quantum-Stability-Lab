class EnhancedLanguageToMath {
  // نئے الفاظ شامل کریں
  
  static final Map<String, String> advancedDictionary = {
    // بڑے اعداد
    'کروڑ': '*10000000',
    'لاکھ': '*100000',
    'ہزار': '*1000',
    'سو': '*100',
    
    // ریاضیاتی اصطلاحات
    'مربع': '²',
    'جذر': '√',
    'فبونیکی': 'fib',
    'پرائم نمبر': 'prime',
    'سیریز': 'series',
    
    // منطقی اصطلاحات
    'مصافحہ': 'handshake',
    'افراد': 'people',
    'زاویہ': 'angle',
    'گھڑی': 'clock',
    'آبادی': 'population',
    'فیصد': '%',
    
    // کوانٹم اصطلاحات
    'کوانٹم': 'quantum',
    'بٹ': 'qubit',
    'حالت': 'state',
  };
  
  static String convertAdvanced(String urduQuestion) {
    String result = urduQuestion;
    
    // پہلے بنیادی تبدیلی
    result = LanguageToMathConverter().convert(result);
    
    // پھر ایڈوانسڈ تبدیلی
    advancedDictionary.forEach((urdu, math) {
      result = result.replaceAll(urdu, math);
    });
    
    // منطقی مسائل کی شناخت
    if (result.contains('handshake') || 
        result.contains('angle') || 
        result.contains('population')) {
      return 'LOGIC:' + result;
    }
    
    return result;
  }
}
