class LawBasedGPUCalculator {
  // GPU کو دیے جانے والے قوانین
  final Map<String, Function> laws = {
    // بنیادی قوانین
    '+': (List<num> nums) {
      // جمع کا قانون: a + b
      return nums.reduce((a, b) => a + b);
    },
    '-': (List<num> nums) {
      // تفریق کا قانون: a - b
      return nums.reduce((a, b) => a - b);
    },
    '*': (List<num> nums) {
      // ضرب کا قانون: a × b
      return nums.reduce((a, b) => a * b);
    },
    '/': (List<num> nums) {
      // تقسیم کا قانون: a ÷ b
      return nums.reduce((a, b) => a / b);
    },
  };
  
  // ریاضی ایکسپریشن کو حل کریں
  num calculate(String expression) {
    print('🧮 GPU حساب شروع: $expression');
    
    try {
      // 1. ایکسپریشن کو حصوں میں تقسیم کریں
      final parts = expression.split(' ');
      
      // 2. آپریشن ڈھونڈیں
      String operation = '';
      List<num> numbers = [];
      
      for (var part in parts) {
        if (laws.containsKey(part)) {
          operation = part;
        } else if (double.tryParse(part) != null) {
          numbers.add(double.parse(part));
        }
      }
      
      // 3. قانون لاگو کریں
      if (operation.isNotEmpty && numbers.length >= 2) {
        final law = laws[operation]!;
        final result = law(numbers);
        
        print('✅ GPU نے حساب کیا: $expression = $result');
        return result;
      }
      
      throw Exception('غلط ایکسپریشن');
      
    } catch (e) {
      print('❌ GPU حساب میں غلطی: $e');
      return 0;
    }
  }
  
  // ٹیسٹ فنکشن
  void test() {
    print('⚡ قانونی GPU ٹیسٹ:');
    print(calculate('2 + 2'));  // 4
    print(calculate('3 * 4'));  // 12
    print(calculate('10 - 5')); // 5
  }
}
