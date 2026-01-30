class LanguageToMathConverter {
  static final Map<String, String> dictionary = {
    'ایک': '1', 'دو': '2', 'تین': '3', 'چار': '4',
    'پانچ': '5', 'چھ': '6', 'سات': '7', 'آٹھ': '8',
    'نو': '9', 'دس': '10',
    'جمع': '+', 'تفریق': '-', 'منفی': '-',
    'ضرب': '*', 'دفعہ': '*', 'تقسیم': '/', 'بٹا': '/',
  };

  /// اردو → ریاضی (بغیر exception کے)
  String convert(String urduQuestion) {
    print('🔤 زبان تحلیل: "$urduQuestion"');
    
    try {
      String expression = urduQuestion;

      // 1️⃣ پورے الفاظ بدلیں
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

      // 4️⃣ چیک کریں
      if (expression.isEmpty) {
        print('⚠️ خالی ایکسپریشن، ڈیفالٹ استعمال کر رہا ہوں');
        return '2 + 2';
      }

      // 5️⃣ operators کی تعداد چیک کریں
      final operators = RegExp(r'[\+\-\*\/]').allMatches(expression);
      if (operators.length > 1) {
        print('⚠️ ایک سے زیادہ operators، پہلا operator استعمال کر رہا ہوں');
        // پہلا operator تلاش کریں
        var match = RegExp(r'[\+\-\*\/]').firstMatch(expression);
        if (match != null) {
          int opIndex = match.start;
          // صرف پہلے operator تک کا حصہ لیں
          String firstPart = expression.substring(0, opIndex + 1).trim();
          // numbers تلاش کریں
          var numbers = RegExp(r'\d+').allMatches(expression);
          if (numbers.length >= 2) {
            return '${numbers.elementAt(0).group(0)} ${expression[opIndex]} ${numbers.elementAt(1).group(0)}';
          }
        }
        return '2 + 2'; // ڈیفالٹ
      }

      // 6️⃣ اگر صرف ایک operator ہے تو ٹھیک ہے
      if (operators.length == 1) {
        print('✅ CPU → GPU: "$expression"');
        return expression;
      }

      // 7️⃣ اگر کوئی operator نہیں ہے
      print('⚠️ کوئی operator نہیں ملا، ڈیفالٹ استعمال کر رہا ہوں');
      return '2 + 2';
      
    } catch (e) {
      print('❌ Converter Error: $e');
      return '2 + 2'; // ڈیفالٹ
    }
  }
}
