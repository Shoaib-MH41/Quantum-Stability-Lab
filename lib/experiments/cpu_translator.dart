// lib/experiments/cpu_translator.dart
class CPUTranslator {
  // نمبروں کو اردو الفاظ میں بدلنے کی ڈکشنری
  static final Map<int, String> numberToUrdu = {
    0: 'صفر', 1: 'ایک', 2: 'دو', 3: 'تین', 4: 'چار', 5: 'پانچ',
    6: 'چھ', 7: 'سات', 8: 'آٹھ', 9: 'نو', 10: 'دس',
    11: 'گیارہ', 12: 'بارہ', 13: 'تیرہ', 14: 'چودہ', 15: 'پندرہ',
    16: 'سولہ', 17: 'سترہ', 18: 'اٹھارہ', 19: 'انیس', 20: 'بیس',
    24: 'چوبیس', 30: 'تیس', 40: 'چالیس', 50: 'پچاس', 60: 'ساٹھ',
    70: 'ستر', 80: 'اسی', 90: 'نوے', 100: 'سو', 1000: 'ہزار',
    100000: 'لاکھ', 10000000: 'کروڑ'
  };

  // کائناتی نتائج کے لیے "فلسفیانہ میپنگ"
  static final Map<double, String> cosmicMeanings = {
    1.618: 'کائنات ایک عظیم توازن (Golden Ratio) پر قائم ہے۔',
    3.14159: 'کائنات کی بنیادی ساخت (π)',
    2.71828: 'قدرتی ترقی کا بنیادی تناسب (e)',
    0.0: 'نظام مکمل طور پر ساکن اور مستحکم ہے۔',
    30.0: 'تثبیت کا قانون (Law of Fixation) لاگو ہو چکا ہے۔',
    35.0: 'پانچویں قانون (35ms Law) فعال ہے۔',
    100.0: 'مکمل استحکام حاصل ہو چکا ہے۔',
  };

  // نمبر کو اردو میں بدلیں
  String translateNumberToUrdu(int number) {
    if (numberToUrdu.containsKey(number)) {
      return numberToUrdu[number]!;
    }
    
    // مرکب نمبر بنائیں
    if (number < 100) {
      final tens = (number ~/ 10) * 10;
      final ones = number % 10;
      
      if (tens > 0 && ones > 0) {
        return '${numberToUrdu[tens]!} ${numberToUrdu[ones]!}';
      }
    }
    
    return number.toString();
  }

  // کائناتی معنی ڈھونڈیں
  String findCosmicMeaning(double value) {
    // قریب ترین کائناتی قدر
    for (var cosmicValue in cosmicMeanings.keys) {
      if ((value - cosmicValue).abs() < 0.01) {
        return cosmicMeanings[cosmicValue]!;
      }
    }
    
    // فلسفیانہ تشریح
    if (value == 0) return 'عدم (صفر) - ہر شے خاموش';
    if (value == 1) return 'وحدانیت - ہر شے ایک';
    if (value > 1000) return 'وسعت - لامحدود کائنات';
    
    return 'حسابی نتیجہ: $value';
  }

  // عمومی ترجمہ
  String translateToUrdu(dynamic result) {
    // اگر نتیجہ کائناتی مستقل ہے
    if (result is double) {
      final meaning = findCosmicMeaning(result);
      if (meaning != 'حسابی نتیجہ: $result') {
        return meaning;
      }
    }

    // اگر نتیجہ سادہ عدد ہے
    if (result is int) {
      final urduNumber = translateNumberToUrdu(result);
      return 'جواب ہے: $urduNumber';
    }

    // ڈیفالٹ
    return 'حسابی نتیجہ: $result';
  }
  
  // ریورس: اردو ←→ نمبر
  int? translateUrduToNumber(String urduWord) {
    for (var entry in numberToUrdu.entries) {
      if (entry.value == urduWord) {
        return entry.key;
      }
    }
    return null;
  }
}
