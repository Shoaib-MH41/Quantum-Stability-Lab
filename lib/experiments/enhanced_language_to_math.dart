import 'language_to_math.dart';

class EnhancedLanguageToMath {
  static final Map<String, String> advancedDictionary = {
    'کروڑ': '10000000',
    'لاکھ': '100000',
    'ہزار': '1000',
    'سو': '100',
  };

  static String convertAdvanced(String urduQuestion) {
    String result = urduQuestion.trim();

    // 1️⃣ بنیادی تبدیلی
    final converter = LanguageToMathConverter();
    result = converter.convert(result);

    // 2️⃣ ایڈوانسڈ عددی الفاظ
    advancedDictionary.forEach((urdu, number) {
      // صرف عدد replace کریں، operator نہیں
      result = result.replaceAll(urdu, number);
    });

    // 3️⃣ صفائی: extra spaces
    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();

    return result;
  }
}
