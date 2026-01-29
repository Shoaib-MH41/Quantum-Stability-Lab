class AdvancedMathLaws {
  // سپر کمپیوٹر لیول کے قوانین
  
  static final Map<String, Function> laws = {
    // 1. بڑے اعداد
    'large_number_addition': (String a, String b) {
      return (BigInt.parse(a) + BigInt.parse(b)).toString();
    },
    
    // 2. فبونیکی سیریز
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
    
    // 3. پرائم نمبر چیک
    'is_prime': (int n) {
      if (n <= 1) return false;
      if (n <= 3) return true;
      if (n % 2 == 0 || n % 3 == 0) return false;
      
      for (int i = 5; i * i <= n; i += 6) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
      }
      return true;
    },
    
    // 4. سیریز کا مجموعہ
    'sum_of_squares': (int n) {
      // 1² + 2² + 3² + ... + n² = n(n+1)(2n+1)/6
      return n * (n + 1) * (2 * n + 1) ~/ 6;
    },
    
    'sum_of_cubes': (int n) {
      // 1³ + 2³ + 3³ + ... + n³ = [n(n+1)/2]²
      int sum = n * (n + 1) ~/ 2;
      return sum * sum;
    },
    
    // 5. آبادی کا مسئلہ
    'population_growth': (double initial, double rate, int years) {
      // P = P₀(1 + r)ⁿ
      return initial * pow(1 + rate/100, years);
    },
    
    // 6. مصافحہ کا مسئلہ
    'handshake_problem': (int handshakes) {
      // n(n-1)/2 = handshakes
      // حل: n = [1 + √(1 + 8h)]/2
      return ((1 + sqrt(1 + 8 * handshakes)) / 2).toInt();
    },
    
    // 7. گھڑی کا زاویہ
    'clock_angle': (int hour, int minute) {
      // زاویہ = |30H - 5.5M|
      double angle = (30 * hour - 5.5 * minute).abs();
      return angle > 180 ? 360 - angle : angle;
    },
    
    // 8. کوانٹم حالت
    'quantum_states': (int qubits) {
      // 2^n ممکنہ حالت
      return pow(2, qubits);
    },
    
    // 9. ارٹھمیٹک سیریز
    'arithmetic_sum': (int a, int n, int d) {
      // S = n/2[2a + (n-1)d]
      return (n ~/ 2) * (2 * a + (n - 1) * d);
    },
    
    // 10. جیومیٹرک سیریز
    'geometric_sum': (int a, double r, int n) {
      // S = a(1 - rⁿ)/(1 - r)
      return a * (1 - pow(r, n)) ~/ (1 - r);
    },
  };
}
