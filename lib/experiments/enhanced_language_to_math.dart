// 🧠 Enhanced Language → Math
// اصل دماغ: اردو / انگلش سوال کو سمجھ کر
// صرف GPU کے لیے صاف math expression بناتا ہے

class EnhancedLanguageToMath {
  // اردو + انگلش نمبر
  static final Map<String, String> _numbers = {
    // اردو
    'ایک': '1',
    'دو': '2',
    'تین': '3',
    'چار': '4',
    'پانچ': '5',
    'چھ': '6',
    'سات': '7',
    'آٹھ': '8',
    'نو': '9',
    'دس': '10',

    // انگلش
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
    'ten': '10',
  };

  // آپریٹرز (semantic)
  static final Map<String, String> _operators = {
    // اردو
    'جمع': '+',
    'جوڑ': '+',
    'پلس': '+',

    'تفریق': '-',
    'منفی': '-',
    'گھٹا': '-',

    'ضرب': '*',
    'گنا': '*',
    'دفعہ': '*',

    'تقسیم': '/',
    'بٹا': '/',
    'تقسیم کرو': '/',

    // انگلش
    'plus': '+',
    'add': '+',

    'minus': '-',
    'subtract': '-',

    'multiply': '*',
    'times': '*',

    'divide': '/',
    'over': '/',
  };

  /// 🔥 اصل method
  /// صرف "a op b" return کرے گا
  String convert(String input) {
    print('🧠 NPU → LanguageToMath');
    print('📥 Input: "$input"');

    String text = input.toLowerCase();

    // 1️⃣ نمبرز normalize کریں
    _numbers.forEach((word, value) {
      text = text.replaceAll(RegExp(r'\b' + word + r'\b'), ' $value ');
    });

    // 2️⃣ آپریٹر تلاش کریں
    String? detectedOperator;
    _operators.forEach((word, symbol) {
      if (detectedOperator == null && text.contains(word)) {
        detectedOperator = symbol;
      }
    });

    // 3️⃣ digits نکالیں
    final numbers = RegExp(r'\d+').allMatches(text).map((e) => e.group(0)!).toList();

    if (numbers.length >= 2 && detectedOperator != null) {
      final expression = '${numbers[0]} $detectedOperator ${numbers[1]}';
      print('✅ NPU فیصلہ: "$expression"');
      return expression;
    }

    // 4️⃣ fallback: اگر direct expression ہو
    final cleaned = text.replaceAll(RegExp(r'[^0-9\+\-\*\/\s]'), '')
                        .replaceAll(RegExp(r'\s+'), ' ')
                        .trim();

    final parts = cleaned.split(' ');
    if (parts.length == 3) {
      print('✅ Direct math detected: "$cleaned"');
      return cleaned;
    }

    // 5️⃣ آخری fallback
    print('⚠️ NPU fallback → "2 + 2"');
    return '2 + 2';
  }
}
