class LanguageToMathConverter {
  static final Map<String, String> dictionary = {
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

    'جمع': '+',
    'تفریق': '-',
    'منفی': '-',
    'ضرب': '*',
    'دفعہ': '*',
    'تقسیم': '/',
    'بٹا': '/',
  };

  /// 🧠 اردو → ریاضی (CPU Logic)
  String convert(String urduQuestion) {
    String expression = urduQuestion;

    // 1️⃣ صرف پورے الفاظ بدلیں (safe replace)
    dictionary.forEach((urdu, math) {
      expression = expression.replaceAll(
        RegExp(r'\b' + urdu + r'\b'),
        ' $math ',
      );
    });

    // 2️⃣ غیر ضروری حروف ہٹائیں
    expression = expression.replaceAll(
      RegExp(r'[^0-9\+\-\*\/\.\s]'),
      '',
    );

    // 3️⃣ اسپیس normalize کریں
    expression = expression.trim().replaceAll(RegExp(r'\s+'), ' ');

    // 4️⃣ اگر ایک سے زیادہ operators ہوں → CPU reject
    final operators = RegExp(r'[\+\-\*\/]').allMatches(expression);
    if (operators.length != 1) {
      throw Exception('CPU: ایک وقت میں صرف ایک ریاضیاتی عمل ممکن ہے');
    }

    print('🧠 CPU → GPU ایکسپریشن: "$expression"');
    return expression;
  }

  static LanguageToMathConverter instance() => LanguageToMathConverter();
}
