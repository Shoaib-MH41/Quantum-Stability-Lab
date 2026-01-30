import 'dart:math';

/// ⚛️ QuantumLogic
/// Hybrid CPU/NPU friendly quantum reasoning engine
class QuantumLogic {
  // --------------------------------------------------
  // 🧠 BASIC QUANTUM CONCEPTS
  // --------------------------------------------------

  /// Superposition: |ψ⟩ = α|0⟩ + β|1⟩
  static List<double> superposition({
    double alpha = 0.707106,
    double beta = 0.707106,
  }) {
    final norm = sqrt(alpha * alpha + beta * beta);
    return [alpha / norm, beta / norm];
  }

  /// Bell States (1D state vector, CPU-safe)
  static List<double> bellState(int type) {
    const v = 0.707106;
    switch (type) {
      case 0:
        return [v, 0, 0, v]; // Φ+
      case 1:
        return [v, 0, 0, -v]; // Φ-
      case 2:
        return [0, v, v, 0]; // Ψ+
      case 3:
        return [0, v, -v, 0]; // Ψ-
      default:
        return [v, 0, 0, v];
    }
  }

  /// Total quantum states = 2ⁿ
  static int quantumStates(int qubits) => pow(2, qubits).toInt();

  // --------------------------------------------------
  // 🔗 QUANTUM KNOWLEDGE RESPONSES
  // --------------------------------------------------

  static String superpositionInfo(int qubits) {
    final states = quantumStates(qubits);
    return '''
⚛️ کوانٹم سپر پوزیشن
کوانٹم بٹس: $qubits
ممکنہ حالتیں: $states
تمام حالتیں بیک وقت موجود ہوتی ہیں (مشاہدے سے پہلے)
''';
  }

  static String entanglementInfo(int qubits) {
    final power = quantumStates(qubits);
    return '''
🔗 کوانٹم اینٹینگلمنٹ
$qubits qubits ≈ $power کلاسیکل حالتیں
ایک ذرّے کی تبدیلی فوراً دوسرے پر اثر کرتی ہے
''';
  }

  // --------------------------------------------------
  // 🧠 PROBLEM SOLVER (CPU ENTRY POINT)
  // --------------------------------------------------

  static Map<String, dynamic> process (String question) {
    if (_containsAny(question, ['کوانٹم بٹ', 'qubit', 'حالت'])) {
      return _solveQubitStates(question);
    }

    if (_containsAny(question, ['سپر پوزیشن'])) {
      return {
        'engine': 'quantum',
        'solution': 'سپر پوزیشن: ایک ذرہ بیک وقت 0 اور 1 ہو سکتا ہے',
        'explanation':
            'یہ حالت مشاہدے تک تمام ممکنات کو برقرار رکھتی ہے۔',
      };
    }

    if (_containsAny(question, ['اینٹینگلمنٹ'])) {
      return {
        'engine': 'quantum',
        'solution': 'اینٹینگلمنٹ: دو ذرات کا فوری تعلق',
        'explanation':
            'ایک ذرہ بدلنے سے دوسرا بغیر فاصلے کے فوراً بدل جاتا ہے۔',
      };
    }

    if (_containsAny(question, ['شروڈنگر'])) {
      return {
        'engine': 'quantum',
        'solution': 'بلی زندہ بھی ہے اور مردہ بھی',
        'explanation':
            'جب تک مشاہدہ نہ ہو، تمام حالتیں موجود رہتی ہیں۔',
      };
    }

    return {
      'engine': 'quantum',
      'solution': 'یہ کوانٹم سوال ابھی نظام میں رجسٹرڈ نہیں',
      'explanation': 'مزید قوانین شامل کیے جا سکتے ہیں۔',
    };
  }

  // --------------------------------------------------
  // 🔍 INTERNAL HELPERS
  // --------------------------------------------------

  static Map<String, dynamic> _solveQubitStates(String question) {
    final match = RegExp(r'(\d+)').firstMatch(question);
    final qubits = match != null ? int.parse(match.group(1)!) : 1;
    final states = quantumStates(qubits);

    return {
      'engine': 'quantum',
      'solution': '$states ممکنہ کوانٹم حالتیں',
      'explanation': 'n کوانٹم بٹس کے لیے 2ⁿ حالتیں ممکن ہوتی ہیں۔',
    };
  }

  static bool _containsAny(String text, List<String> keys) {
    for (final k in keys) {
      if (text.contains(k)) return true;
    }
    return false;
  }
}

// --------------------------------------------------
// 🧩 SUPPORT CLASSES
// --------------------------------------------------

class Complex {
  final double real;
  final double imag;

  const Complex(this.real, this.imag);

  @override
  String toString() =>
      imag >= 0 ? '$real + ${imag}i' : '$real - ${-imag}i';
}

class Qubit {
  double alpha;
  double beta;

  Qubit([this.alpha = 0.707106, this.beta = 0.707106]) {
    final norm = sqrt(alpha * alpha + beta * beta);
    alpha /= norm;
    beta /= norm;
  }

  /// Measurement collapses state
  int measure() {
    return Random().nextDouble() < (alpha * alpha) ? 0 : 1;
  }
}
