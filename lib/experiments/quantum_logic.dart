import 'dart:math';

/// ⚛️ کوانٹم منطق - سپر پوزیشن، اینٹینگلمنٹ، اور کوانٹم حساب
class QuantumLogic {
  // -------------------- بنیادی کوانٹم تصورات --------------------
  
  /// سپر پوزیشن: ایک ہی وقت میں 0 اور 1 ہونا
  static List<double> superposition([double alpha = 0.707106, double beta = 0.707106]) {
    // |ψ⟩ = α|0⟩ + β|1⟩
    final norm = sqrt(alpha * alpha + beta * beta);
    return [alpha / norm, beta / norm];
  }
  
  /// اینٹینگلمنٹ: Bell state بنانا
  static List<List<double>> bellState(int type) {
    // 1/sqrt(2) کی مستقل قیمت 0.707106 ہے تاکہ رن ٹائم پر مسئلہ نہ ہو
    const double invSqrt2 = 0.707106;
    
    switch (type) {
      case 0: // |Φ⁺⟩ = (|00⟩ + |11⟩)/√2
        return [[invSqrt2, 0, 0, invSqrt2]];
      case 1: // |Φ⁻⟩ = (|00⟩ - |11⟩)/√2
        return [[invSqrt2, 0, 0, -invSqrt2]];
      case 2: // |Ψ⁺⟩ = (|01⟩ + |10⟩)/√2
        return [[0, invSqrt2, invSqrt2, 0]];
      case 3: // |Ψ⁻⟩ = (|01⟩ - |10⟩)/√2
        return [[0, invSqrt2, -invSqrt2, 0]];
      default:
        return bellState(0);
    }
  }
  
  /// کوانٹم گیٹس
  static Map<String, dynamic> quantumGates = {
    'X': [[0.0, 1.0], [1.0, 0.0]],
    'Y': [
      [0.0, Complex(0, -1)],
      [Complex(0, 1), 0.0]
    ],
    'Z': [[1.0, 0.0], [0.0, -1.0]],
    'H': [
      [0.707106, 0.707106],
      [0.707106, -0.707106]
    ],
    'CNOT': [
      [1.0, 0.0, 0.0, 0.0],
      [0.0, 1.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 1.0],
      [0.0, 0.0, 1.0, 0.0]
    ],
  };
  
  static int quantumStates(int qubits) => pow(2, qubits).toInt();
  
  static String quantumSuperpositionInfo(int qubits) {
    final states = quantumStates(qubits);
    return '⚛️ کوانٹم معلومات:\nکوانٹم بٹس: $qubits\nممکنہ حالت: $states\nسپر پوزیشن میں: تمام $states حالت ایک ساتھ';
  }
  
  static String entanglementPower(int qubits) {
    final power = quantumStates(qubits);
    return '🔗 اینٹینگلمنٹ کا موازنہ:\nکوانٹم بٹس: $qubits qubits\nکوانٹم طاقت: $power کلاسیکل بٹس کے برابر';
  }
  
  static Map<String, dynamic> solveQuantumProblem(String problem) {
    if (problem.contains('کوانٹم بٹ') || problem.contains('حالت')) {
      return _solveQubitStates(problem);
    }
    if (problem.contains('سپر پوزیشن')) {
      return _solveSuperposition(problem);
    }
    if (problem.contains('اینٹینگلمنٹ')) {
      return _solveEntanglement(problem);
    }
    return {
      'type': 'quantum_problem',
      'solution': 'اس کوانٹم مسئلے کا قانونی حل ابھی ڈیٹا میں موجود نہیں ہے۔',
    };
  }
  
  static Map<String, dynamic> _solveQubitStates(String problem) {
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(problem);
    int qubits = match != null ? int.parse(match.group(1)!) : 1;
    final states = quantumStates(qubits);
    
    return {
      'solution': '$states ممکنہ حالت',
      'explanation': 'n کوانٹم بٹس کے لیے 2ⁿ حالتیں ممکن ہیں۔',
    };
  }

  static Map<String, dynamic> _solveSuperposition(String problem) => {
    'solution': 'سپر پوزیشن: ایک ہی وقت میں 0 اور 1 ہونا۔',
    'explanation': 'یہ کوانٹم مکینکس کی وہ حالت ہے جہاں مشاہدے سے پہلے تمام امکانات موجود ہوتے ہیں۔'
  };

  static Map<String, dynamic> _solveEntanglement(String problem) => {
    'solution': 'اینٹینگلمنٹ: ذرات کے درمیان فوری کائناتی تعلق۔',
    'explanation': 'دو ذرات کا ایک دوسرے سے جڑ جانا کہ ایک کی تبدیلی دوسرے پر فوری اثر کرے۔'
  };

  static String quantumPhilosophy(String question) {
    if (question.contains('شروڈنگر')) return '🐱 شروڈنگر کی بلی زندہ اور مردہ دونوں حالتوں میں ہے جب تک مشاہدہ نہ کیا جائے۔';
    return '⚛️ کوانٹم فلسفہ توازن اور احتمال پر مبنی ہے۔';
  }
}

// -------------------- معاون کلاسز --------------------

class Complex {
  final double real;
  final double imag;
  Complex(this.real, this.imag);
  @override
  String toString() => imag >= 0 ? '$real + ${imag}i' : '$real - ${-imag}i';
}

class Qubit {
  double alpha;
  double beta;
  
  // ✅ فکس: یہاں 1/sqrt(2) کی جگہ 0.707106 استعمال کیا گیا ہے تاکہ بلڈ ارر نہ آئے
  Qubit([this.alpha = 0.707106, this.beta = 0.707106]) {
    final norm = sqrt(alpha * alpha + beta * beta);
    alpha /= norm;
    beta /= norm;
  }
  
  int measure() => Random().nextDouble() < (alpha * alpha) ? 0 : 1;
}
