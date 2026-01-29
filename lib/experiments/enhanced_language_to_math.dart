
class EnhancedLanguageToMath {
  // نئے الفاظ شامل کریں
  
  static final Map<String, String> advancedDictionary = {
    // بڑے اعداد
    'کروڑ': '*10000000',
    'لاکھ': '*100000',
    'ہزار': '*1000',
    'سو': '*100',
  };
  
  static String convertAdvanced(String urduQuestion) {
    String result = urduQuestion;
    
    // پہلے بنیادی تبدیلی
    final converter = LanguageToMathConverter(); // ✅ درست
    result = converter.convert(result);
    
    // پھر ایڈوانسڈ تبدیلی
    advancedDictionary.forEach((urdu, math) {
      result = result.replaceAll(urdu, math);
    });
    
    return result;
  }
}
