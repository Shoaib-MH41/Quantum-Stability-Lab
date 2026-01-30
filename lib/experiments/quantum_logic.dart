import 'dart:math';

/// ⚛️ QuantumLogic
/// Hybrid CPU/NPU friendly quantum reasoning engine
class QuantumLogic {
  
  // 1. کوانٹم حالتوں کا حساب (2ⁿ)
  static int quantumStates(int qubits) => pow(2, qubits).toInt();

  // 2. سپر پوزیشن: |ψ⟩ = α|0⟩ + β|1⟩
  static List<double> superposition({
    double alpha = 0.707106,
    double beta = 0.707106,
  }) {
    final norm = sqrt(alpha * alpha + beta * beta);
    return [alpha / norm, beta / norm];
  }

  // 3. Bell States
  static List<double> bellState(int type) {
    const v = 0.707106;
    switch (type) {
      case 0: return [v, 0, 0, v]; // Φ+
      case 1: return [v, 0, 0, -v]; // Φ-
      case 2: return [0, v, v, 0]; // Ψ+
      case 3: return [0, v, -v, 0]; // Ψ-
      default: return [v, 0, 0, v];
    }
  }

  // 🧠 مرکزی انٹری پوائنٹ (HybridLawSystem اسی کو پکارتا ہے)
  static String process(String question) {
    final result = _internalExecute(question);
    return '${result['solution']}\n${result['explanation']}';
  }

  // 🔍 اندرونی حل پیش کرنے والا انجن
  static Map<String, dynamic> _internalExecute(String question) {
    if (_containsAny(question, ['کوانٹم بٹ', 'qubit', 'حالت'])) {
      return _solveQubitStates(question);
    }

    if (_containsAny(question, ['سپر پوزیشن'])) {
      return {
        'solution': 'سپر پوزیشن: ایک ذرہ بیک وقت 0 اور 1 ہو سکتا ہے',
        'explanation': 'یہ حالت مشاہدے تک تمام ممکنات کو برقرار رکھتی ہے۔',
      };
    }

    if (_containsAny(question, ['اینٹینگلمنٹ'])) {
      return {
        'solution': 'اینٹینگلمنٹ: دو ذرات کا فوری تعلق',
        'explanation': 'ایک ذرہ بدلنے سے دوسرا بغیر فاصلے کے فوراً بدل جاتا ہے۔',
      };
    }

    if (_containsAny(question, ['شروڈنگر'])) {
      return {
        'solution': 'شروڈنگر کی بلی: زندہ بھی ہے اور مردہ بھی',
        'explanation': 'جب تک مشاہدہ نہ ہو، تمام ممکنہ حالتیں موجود رہتی ہیں۔',
      };
    }

    return {
      'solution': 'یہ کوانٹم سوال ابھی نظام میں رجسٹرڈ نہیں',
      'explanation': 'آپ اس پر مزید قوانین لاگو کر سکتے ہیں۔',
    };
  }

  // کوانٹم بٹس کی گنتی کا حل
  static Map<String, dynamic> _solveQubitStates(String question) {
    final match = RegExp(r'(\d+)').firstMatch(question);
    final qubits = match != null ? int.parse(match.group(1)!) : 1;
    final states = quantumStates(qubits);

    return {
      'solution': '$states ممکنہ کوانٹم حالتیں',
      'explanation': 'n کوانٹم بٹس کے لیے 2ⁿ حالتیں ممکن ہوتی ہیں۔',
    };
  }

  // الفاظ کی تلاش کا مددگار فنکشن
  static bool _containsAny(String text, List<String> keys) {
    for (final k in keys) {
      if (text.contains(k)) return true;
    }
    return false;
  }
}

// --------------------------------------------------
// 🧩 معاون کلاسز (کلاس QuantumLogic سے باہر)
// --------------------------------------------------

class Complex {
  final double real;
  final double imag;
  const Complex(this.real, this.imag);

  @override
  String toString() => imag >= 0 ? '$real + ${imag}i' : '$real - ${-imag}i';
}

class Qubit {
  double alpha;
  double beta;

  Qubit([this.alpha = 0.707106, this.beta = 0.707106]) {
    final norm = sqrt(alpha * alpha + beta * beta);
    alpha /= norm;
    beta /= norm;
  }

  int measure() {
    return Random().nextDouble() < (alpha * alpha) ? 0 : 1;
  }
}
