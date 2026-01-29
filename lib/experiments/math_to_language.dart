import 'cpu_translator.dart';

class MathToLanguageConverter {
  final CPUTranslator cpuTranslator = CPUTranslator();

  // چھوٹے نمبرز کے لیے فاسٹ میپ
  static final Map<int, String> numberWords = {
    0: 'صفر',
    1: 'ایک',
    2: 'دو',
    3: 'تین',
    4: 'چار',
    5: 'پانچ',
    6: 'چھ',
    7: 'سات',
    8: 'آٹھ',
    9: 'نو',
    10: 'دس',
    11: 'گیارہ',
    12: 'بارہ',
    13: 'تیرہ',
    14: 'چودہ',
    15: 'پندرہ',
    16: 'سولہ',
    17: 'سترہ',
    18: 'اٹھارہ',
    19: 'انیس',
    20: 'بیس',
  };

  /// 🧠 حساب → زبان
  String convert(num result, String originalQuestion) {
    print('🔤 حساب → زبان: $result');

    String resultInUrdu;

    // 1️⃣ اگر integer ہے
    if (result % 1 == 0) {
      final intValue = result.toInt();

      if (numberWords.containsKey(intValue)) {
        resultInUrdu = numberWords[intValue]!;
      } else {
        resultInUrdu = cpuTranslator.translateToUrdu(intValue);
      }
    } 
    // 2️⃣ decimal / فلسفیانہ / کوانٹم نتیجہ
    else {
      resultInUrdu = cpuTranslator.translateToUrdu(result);
    }

    // 3️⃣ جملہ سازی (واضح اصول)
    String response;

    if (originalQuestion.contains('کتنے') ||
        originalQuestion.contains('کیا ہے')) {
      response = 'جواب ہے: $resultInUrdu';
    } else if (originalQuestion.trim().endsWith('ہے')) {
      response = '$resultInUrdu';
    } else {
      response = 'حساب کا نتیجہ $resultInUrdu ہے';
    }

    print('✅ حتمی جواب: "$response"');
    return response;
  }

  // ٹیسٹ
  void test() {
    print(convert(4, 'دو جمع دو کیا ہے'));
    print(convert(12, 'تین ضرب چار کتنے'));
    print(convert(5, 'دس تفریق پانچ ہے'));
    print(convert(1.618, 'سنہری تناسب کیا ہے'));
  }
}
