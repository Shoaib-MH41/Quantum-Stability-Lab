/// ریاضی کے نتائج کو اردو میں تبدیل کرتا ہے
class MathToLanguageConverter {
  String convert(num mathResult, String originalQuestion) {
    print('🔤 MathToLanguage: $mathResult for "$originalQuestion"');
    
    String result = mathResult.toString();
    
    // اعداد کو اردو میں تبدیل کریں
    result = result.replaceAll('0', 'صفر');
    result = result.replaceAll('1', 'ایک');
    result = result.replaceAll('2', 'دو');
    result = result.replaceAll('3', 'تین');
    result = result.replaceAll('4', 'چار');
    result = result.replaceAll('5', 'پانچ');
    result = result.replaceAll('6', 'چھ');
    result = result.replaceAll('7', 'سات');
    result = result.replaceAll('8', 'آٹھ');
    result = result.replaceAll('9', 'نو');
    
    // سوال کی نوعیت کے مطابق جواب دیں
    if (originalQuestion.contains('جمع') || originalQuestion.contains('+')) {
      return "جواب: $result";
    } else if (originalQuestion.contains('ضرب') || originalQuestion.contains('*')) {
      return "حاصل ضرب: $result";
    } else if (originalQuestion.contains('تقسیم') || originalQuestion.contains('/')) {
      return "حاصل تقسیم: $result";
    } else if (originalQuestion.contains('منفی') || originalQuestion.contains('-')) {
      return "فرق: $result";
    }
    
    return "نتیجہ: $result";
  }
}
