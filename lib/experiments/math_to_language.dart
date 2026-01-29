class MathToLanguageConverter {
  // عدد ←→ اردو الفاظ
  final Map<String, String> numberWords = {
    '0': 'صفر', '1': 'ایک', '2': 'دو', '3': 'تین', '4': 'چار',
    '5': 'پانچ', '6': 'چھ', '7': 'سات', '8': 'آٹھ', '9': 'نو',
    '10': 'دس', '11': 'گیارہ', '12': 'بارہ', '13': 'تیرہ',
    '14': 'چودہ', '15': 'پندرہ', '16': 'سولہ', '17': 'سترہ',
    '18': 'اٹھارہ', '19': 'انیس', '20': 'بیس',
  };
  
  // حساب کا نتیجہ اردو جواب میں بدلیں
  String convert(num result, String originalQuestion) {
    print('🔤 حساب → زبان: $result');
    
    // 1. عدد کو اردو الفاظ میں بدلیں
    String resultInWords = result.toInt().toString();
    
    // اگر ڈکشنری میں ہے تو اردو میں بدلیں
    if (numberWords.containsKey(resultInWords)) {
      resultInWords = numberWords[resultInWords]!;
    }
    
    // 2. جواب کا جملہ بنائیں
    String response = '';
    
    if (originalQuestion.contains('کیا ہے') || 
        originalQuestion.contains('کتنے')) {
      response = 'جواب ہے: $resultInWords';
    } else if (originalQuestion.contains('ہے')) {
      response = 'یہ $resultInwords ہے';
    } else {
      response = 'حساب کا نتیجہ $resultInWords ہے';
    }
    
    print('✅ حساب → زبان: "$result" → "$response"');
    return response;
  }
  
  // ٹیسٹ فنکشن
  void test() {
    print('🔤 حساب → زبان ٹیسٹ:');
    print(convert(4, 'دو جمع دو کیا ہے'));    // "جواب ہے: چار"
    print(convert(12, 'تین ضرب چار کتنے'));   // "جواب ہے: بارہ"
    print(convert(5, 'دس تفریق پانچ ہے'));    // "یہ پانچ ہے"
  }
}
