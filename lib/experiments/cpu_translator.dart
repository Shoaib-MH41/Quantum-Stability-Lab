// lib/experiments/cpu_translator.dart

class CPUTranslator {
  // -------------------- اردو عدد --------------------

  static final Map<int, String> numberToUrdu = {
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
    30: 'تیس',
    40: 'چالیس',
    50: 'پچاس',
    60: 'ساٹھ',
    70: 'ستر',
    80: 'اسی',
    90: 'نوے',
    100: 'سو',
    1000: 'ہزار',
    100000: 'لاکھ',
    10000000: 'کروڑ',
  };

  // -------------------- اردو عدد بنانا --------------------

  String translateNumberToUrdu(int number) {
    if (numberToUrdu.containsKey(number)) {
      return numberToUrdu[number]!;
    }

    if (number < 100) {
      final tens = (number ~/ 10) * 10;
      final ones = number % 10;
      return ones == 0
          ? numberToUrdu[tens]!
          : '${numberToUrdu[tens]!} ${numberToUrdu[ones]!}';
    }

    if (number < 1000) {
      final hundreds = number ~/ 100;
      final rest = number % 100;
      final h = hundreds == 1
          ? 'سو'
          : '${numberToUrdu[hundreds]!} سو';
      return rest == 0 ? h : '$h ${translateNumberToUrdu(rest)}';
    }

    return number.toString(); // fallback
  }

  // -------------------- کائناتی معنی --------------------

  String findCosmicMeaning(double value) {
    if (_near(value, 1.618, 0.01)) {
      return 'کائنات عظیم توازن (Golden Ratio) پر قائم ہے۔';
    }
    if (_near(value, 3.14159, 0.001)) {
      return 'کائناتی ساخت کا بنیادی مستقل (π)';
    }
    if (_near(value, 2.71828, 0.001)) {
      return 'قدرتی ترقی کا قانون (e)';
    }
    if (_near(value, 30.0, 0.5)) {
      return 'تثبیت کا قانون (30ms Law) فعال ہے۔';
    }
    if (_near(value, 35.0, 0.5)) {
      return 'پانچواں قانون (35ms Law) فعال ہے۔';
    }

    if (value == 0) return 'عدم — ہر شے خاموش';
    if (value == 1) return 'وحدانیت — سب ایک';

    return 'حسابی نتیجہ: $value';
  }

  bool _near(double a, double b, double tolerance) {
    return (a - b).abs() <= tolerance;
  }

  // -------------------- عمومی ترجمہ --------------------

  String translateToUrdu(dynamic result) {
    if (result == null) {
      return 'کوئی نتیجہ حاصل نہیں ہوا';
    }

    if (result is int) {
      return 'جواب ہے: ${translateNumberToUrdu(result)}';
    }

    if (result is double) {
      return findCosmicMeaning(result);
    }

    return 'نتیجہ: $result';
  }

  // -------------------- ریورس میپ --------------------

  int? translateUrduToNumber(String urduWord) {
    for (final e in numberToUrdu.entries) {
      if (e.value == urduWord.trim()) {
        return e.key;
      }
    }
    return null;
  }
}
