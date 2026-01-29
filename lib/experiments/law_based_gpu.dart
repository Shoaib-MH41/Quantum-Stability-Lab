class LawBasedGPUCalculator {
  // ⚡ GPU قوانین (Einstein Style: Fast & Strict)
  final Map<String, Function> laws = {
    '+': (num a, num b) => a + b,
    '-': (num a, num b) => a - b,
    '*': (num a, num b) => a * b,
    '/': (num a, num b) {
      if (b == 0) {
        throw Exception('تقسیم صفر سے ممکن نہیں');
      }
      return a / b;
    },
  };

  // 🧮 ریاضی حل کریں (GPU = brute force, no philosophy)
  num calculate(String expression) {
    print('🧮 GPU حساب شروع: $expression');

    try {
      final parts = expression.trim().split(RegExp(r'\s+'));

      if (parts.length != 3) {
        throw Exception('GPU صرف سادہ a op b سمجھتا ہے');
      }

      final num? a = num.tryParse(parts[0]);
      final String op = parts[1];
      final num? b = num.tryParse(parts[2]);

      if (a == null || b == null || !laws.containsKey(op)) {
        throw Exception('غلط ایکسپریشن');
      }

      final result = laws[op]!(a, b);

      print('✅ GPU نتیجہ: $a $op $b = $result');
      return result;

    } catch (e) {
      print('❌ GPU ناکام: $e');
      return 0;
    }
  }

  // 🔬 ٹیسٹ
  void test() {
    print('⚡ GPU Laws Test');
    calculate('2 + 2');
    calculate('10 - 5');
    calculate('3 * 4');
    calculate('8 / 2');

    // Edge cases
    calculate('8 / 0');     // protected
    calculate('2 +');       // invalid
  }
}
