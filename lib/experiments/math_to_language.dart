
import 'cpu_translator.dart';

class MathToLanguageConverter {
  // ✅ CPUTranslator کا ابجیکٹ یہاں درست طریقے سے بنایا گیا ہے
  final CPUTranslator cpuTranslator = CPUTranslator();

  // 1. نمبرز کی ڈکشنری
  final Map<String, String> numberWords = {
    '0': 'صفر', '1': 'ایک', '2': 'دو', '3': 'تین', '4': 'چار',
    '5': 'پانچ', '6': 'چھ', '7': 'سات', '8': 'آٹھ', '9': 'نو',
    '10': 'دس', '11': 'گیارہ', '12': 'بارہ', '13': 'تیرہ',
    '14': 'چودہ', '15': 'پندرہ', '16': 'سولہ', '17': 'سترہ',
    '18': 'اٹھارہ', '19': 'انیس', '20': 'بیس',
  };
  
  // 2. حساب کا نتیجہ اردو جواب میں بدلیں
  String convert(num result, String originalQuestion) {
    print('🔤 حساب → زبان: $result');
    
    // عدد کو اردو الفاظ میں بدلنے کی کوشش کریں
    String resultInWords = result.toInt().toString();
    
    if (numberWords.containsKey(resultInWords)) {
      resultInWords = numberWords[resultInWords]!;
    } else {
      // اگر ڈکشنری میں نہیں ہے، تو CPU Translator کا استعمال کریں
      resultInWords = cpuTranslator.translateToUrdu(result);
    }
    
    // جواب کا جملہ بنانا (آپ کی لاجک اور فلسفے کے مطابق)
    String response = '';
    
    if (originalQuestion.contains('کیا ہے') || 
        originalQuestion.contains('کتنے')) {
      response = 'جواب ہے: $resultInWords';
    } else if (originalQuestion.contains('ہے')) {
      response = 'یہ $resultInWords ہے';
    } else {
      response = 'حساب کا نتیجہ $resultInWords ہے';
    }
    
    print('✅ حتمی جواب: "$response"');
    return response;
  }
  
  // 3. ٹیسٹ فنکشن
  void test() {
    print('🔤 ٹیسٹنگ شروع:');
    print(convert(4, 'دو جمع دو کیا ہے'));
    print(convert(12, 'تین ضرب چار کتنے'));
    print(convert(5, 'دس تفریق پانچ ہے'));
  }
}
