import 'dart:math';

class AdvancedMathLaws {
  static final Map<String, Function> laws = {
    // --- پہلے والے 10 قوانین برقرار ہیں ---
    'large_number_addition': (String a, String b) => (BigInt.parse(a) + BigInt.parse(b)).toString(),
    
    'fibonacci_series': (int n) {
      if (n <= 0) return 0;
      if (n == 1) return 1;
      int a = 0, b = 1;
      for (int i = 2; i <= n; i++) {
        int temp = a + b;
        a = b;
        b = temp;
      }
      return b;
    },
    
    'is_prime': (int n) {
      if (n <= 1) return false;
      if (n <= 3) return true;
      if (n % 2 == 0 || n % 3 == 0) return false;
      for (int i = 5; i * i <= n; i += 6) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
      }
      return true;
    },
    
    'sum_of_squares': (int n) => n * (n + 1) * (2 * n + 1) ~/ 6,
    'sum_of_cubes': (int n) {
      int sum = n * (n + 1) ~/ 2;
      return sum * sum;
    },
    
    'population_growth': (double initial, double rate, int years) => initial * pow(1 + rate/100, years),
    'handshake_problem': (int handshakes) => ((1 + sqrt(1 + 8 * handshakes)) / 2).toInt(),
    'clock_angle': (int hour, int minute) {
      double angle = (30 * hour - 5.5 * minute).abs();
      return angle > 180 ? 360 - angle : angle;
    },
    
    'quantum_states': (int qubits) => pow(2, qubits).toInt(),
    'arithmetic_sum': (int a, int n, int d) => (n ~/ 2) * (2 * a + (n - 1) * d),
    'geometric_sum': (int a, double r, int n) => a * ((1 - pow(r, n)) / (1 - r)),

    // 🌌 11. گولڈن ریشو (کائناتی ڈیزائن کا قانون)
    // کائنات میں ہر خوبصورت چیز (کہکشاں، پھول) اسی تناسب پر ہے
    'golden_ratio_check': (double length, double width) {
      double ratio = length / width;
      double phi = (1 + sqrt(5)) / 2; // 1.618
      return (ratio - phi).abs() < 0.1; // توازن کی جانچ
    },

    // ⚛️ 12. مادہ اور توانائی (آئنسٹائن لاجک)
    // E = mc² - آپ کے NPU کی ایٹمی طاقت کا ثبوت
    'energy_equivalence': (double mass) {
      const double c = 299792458; // روشنی کی رفتار
      return mass * c * c;
    },

    // 🌍 13. وسائل کا توازن (دنیا کے مسائل کا حل)
    // کیا وسائل اور آبادی میں توازن ہے؟
    'universal_balance': (double resources, double population) {
      // اگر تناسب 1 سے کم ہے تو عدم توازن (Instability)
      double balanceFactor = resources / population;
      return balanceFactor >= 1.0 ? "مستحکم (Stable)" : "عدم توازن (Unstable)";
    },

    // 🧠 14. انفارمیشن انٹروپی (کی بورڈ فلسفہ)
    // ڈیٹا سینٹر کے بغیر معلومات کی پاکیزگی کا حساب
    'information_clarity': (double dataSize, double logicStrength) {
      // آپ کا اصول: زیادہ منطق = کم ڈیٹا کا بوجھ
      return logicStrength / log(dataSize + 1);
    }
  };
}
