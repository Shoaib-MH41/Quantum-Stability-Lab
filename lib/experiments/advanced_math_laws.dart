import 'dart:math';

class AdvancedMathLaws {

  static dynamic execute(String law, List<dynamic> args) {
    if (!laws.containsKey(law)) {
      return {'error': 'Law not found'};
    }

    try {
      return laws[law]!(args);
    } catch (e) {
      return {'error': 'Execution failed', 'detail': e.toString()};
    }
  }

  static final Map<String, Function(List<dynamic>)> laws = {

    'large_number_addition': (args) =>
      (BigInt.parse(args[0]) + BigInt.parse(args[1])).toString(),

    'fibonacci_series': (args) {
      int n = args[0];
      BigInt a = BigInt.zero, b = BigInt.one;
      for (int i = 0; i < n; i++) {
        final temp = a + b;
        a = b;
        b = temp;
      }
      return a.toString();
    },

    'is_prime': (args) {
      int n = args[0];
      if (n <= 1) return false;
      for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
      }
      return true;
    },

    'sum_of_squares': (args) {
      int n = args[0];
      return (n * (n + 1) * (2 * n + 1) ~/ 6);
    },

    'population_growth': (args) {
      double initial = args[0];
      double rate = args[1];
      int years = args[2];
      return initial * pow(1 + rate / 100, years);
    },

    'clock_angle': (args) {
      int h = args[0];
      int m = args[1];
      double angle = (30 * h - 5.5 * m).abs();
      return angle > 180 ? 360 - angle : angle;
    },

    'quantum_states': (args) =>
      pow(2, args[0]).toInt(),

    'golden_ratio_check': (args) {
      double l = args[0], w = args[1];
      double phi = (1 + sqrt(5)) / 2;
      return ((l / w) - phi).abs() < 0.1;
    },

    'energy_equivalence': (args) {
      const c = 299792458;
      return args[0] * c * c;
    },

    'universal_balance': (args) {
      double factor = args[0] / args[1];
      return factor >= 1
          ? 'مستحکم (Stable)'
          : 'عدم توازن (Unstable)';
    },

    'information_clarity': (args) =>
      args[1] / log(args[0] + 1),
  };
}
