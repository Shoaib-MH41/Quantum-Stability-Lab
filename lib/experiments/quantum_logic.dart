import 'dart:math';

/// ⚛️ QuantumLogic
/// Hybrid CPU/NPU friendly quantum reasoning engine
class QuantumLogic {

  // 1. کوانٹم حالتوں کا حساب (2ⁿ)
  static int quantumStates(int qubits) => pow(2, qubits).toInt();

  // 2. سپر پوزیشن
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
      case 0: return [v, 0, 0, v];
      case 1: return [v, 0, 0, -v];
      case 2: return [0, v, v, 0];
      case 3: return [0, v, -v, 0];
      default: return [v, 0, 0, v];
    }
  }

  // 🧠 مرکزی انٹری پوائنٹ
  static String process(String question) {
    final result = _internalExecute(question);

    final solution = result['solution'];
    final explanation = result['explanation'];

    if (solution == null || solution.toString().trim().isEmpty) {
      return '❌ کوانٹم جواب دستیاب نہیں';
    }

    if (explanation == null || explanation.toString().trim().isEmpty) {
      return solution.toString();
    }

    return '${solution.toString()}\n${explanation.toString()}';
  }

  // 🔍 اندرونی انجن
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
      'solution': 'یہ کوانٹم سوال ابھی نظام میں موجود نہیں',
      'explanation': '',
    };
  }

  // کوانٹم بٹس
  static Map<String, dynamic> _solveQubitStates(String question) {
    final match = RegExp(r'(\d+)').firstMatch(question);
    final qubits = match != null ? int.parse(match.group(1)!) : 1;
    final states = quantumStates(qubits);

    return {
      'solution': '$qubits کوانٹم بٹس → $states ممکنہ کوانٹم حالتیں',
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
