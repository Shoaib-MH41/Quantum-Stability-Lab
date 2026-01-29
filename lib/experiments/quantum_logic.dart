import 'dart:math';

/// ⚛️ کوانٹم منطق - سپر پوزیشن، اینٹینگلمنٹ، اور کوانٹم حساب
class QuantumLogic {
  // -------------------- بنیادی کوانٹم تصورات --------------------
  
  /// سپر پوزیشن: ایک ہی وقت میں 0 اور 1 ہونا
  static List<double> superposition([double alpha = 0.7071, double beta = 0.7071]) {
    // |ψ⟩ = α|0⟩ + β|1⟩
    // α² + β² = 1 (نارملائزیشن)
    final norm = sqrt(alpha * alpha + beta * beta);
    return [alpha / norm, beta / norm];
  }
  
  /// اینٹینگلمنٹ: Bell state بنانا
  static List<List<double>> bellState(int type) {
    // چار Bell states
    switch (type) {
      case 0: // |Φ⁺⟩ = (|00⟩ + |11⟩)/√2
        return [
          [1/sqrt(2), 0, 0, 1/sqrt(2)]
        ];
      case 1: // |Φ⁻⟩ = (|00⟩ - |11⟩)/√2
        return [
          [1/sqrt(2), 0, 0, -1/sqrt(2)]
        ];
      case 2: // |Ψ⁺⟩ = (|01⟩ + |10⟩)/√2
        return [
          [0, 1/sqrt(2), 1/sqrt(2), 0]
        ];
      case 3: // |Ψ⁻⟩ = (|01⟩ - |10⟩)/√2
        return [
          [0, 1/sqrt(2), -1/sqrt(2), 0]
        ];
      default:
        return bellState(0);
    }
  }
  
  /// کوانٹم گیٹس
  static Map<String, List<List<double>>> quantumGates = {
    // Pauli gates
    'X': [
      [0, 1],
      [1, 0]
    ], // NOT gate
    'Y': [
      [0, Complex(0, -1)],
      [Complex(0, 1), 0]
    ],
    'Z': [
      [1, 0],
      [0, -1]
    ],
    
    // Hadamard gate
    'H': [
      [1/sqrt(2), 1/sqrt(2)],
      [1/sqrt(2), -1/sqrt(2)]
    ],
    
    // CNOT gate (2-qubit)
    'CNOT': [
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 0, 1],
      [0, 0, 1, 0]
    ],
  };
  
  // -------------------- کوانٹم حساب --------------------
  
  /// n کوانٹم بٹس میں ممکنہ حالتوں کی تعداد
  static int quantumStates(int qubits) {
    // 2^n ممکنہ حالت
    return pow(2, qubits).toInt();
  }
  
  /// کوانٹم سپر پوزیشن کا حساب
  static String quantumSuperpositionInfo(int qubits) {
    final states = quantumStates(qubits);
    return '''
⚛️ کوانٹم معلومات:
کوانٹم بٹس: $qubits
ممکنہ کلاسیسکل حالت: $states
سپر پوزیشن میں: تمام $states حالت ایک ساتھ
مشاہدہ پر: صرف ایک حالت (احتمال کے مطابق)
''';
  }
  
  /// کوانٹم اینٹینگلمنٹ کی طاقت
  static String entanglementPower(int qubits) {
    final classicalBits = qubits;
    final quantumPower = pow(2, qubits).toInt();
    
    return '''
🔗 اینٹینگلمنٹ کا موازنہ:
کلاسیکل بٹس: $classicalBits bits
کوانٹم بٹس: $qubits qubits
کوانٹم طاقت: $quantumBits کلاسیکل بٹس کے برابر
فی qubit اضافہ: 2x (exponential)
''';
  }
  
  // -------------------- کوانٹم الگورتھم --------------------
  
  /// Deutsch-Jozsa الگورتھم (سادہ ورژن)
  static String deutschJozsa(bool Function(int) oracle) {
    // کیا فنکشن مستقل ہے یا متوازن؟
    final result0 = oracle(0);
    final result1 = oracle(1);
    
    if (result0 == result1) {
      return "فنکشن مستقل ہے (constant)";
    } else {
      return "فنکشن متوازن ہے (balanced)";
    }
  }
  
  /// کوانٹم سرچ (Grover's algorithm سادہ ورژن)
  static int quantumSearch(List<int> database, int target) {
    // کلاسیکل: O(N) - ہر عنصر چیک کریں
    // کوانٹم: O(√N) - Grover's algorithm
    
    final n = database.length;
    final classicalSteps = n;
    final quantumSteps = sqrt(n).ceil();
    
    // سادہ simulation
    for (int i = 0; i < quantumSteps; i++) {
      // کوانٹم پرابیلسٹک سرچ
      final probability = 1.0 / n;
      if (Random().nextDouble() < probability * quantumSteps) {
        return i; // مل گیا (سادہ simulation)
      }
    }
    
    return -1; // نہیں ملا
  }
  
  // -------------------- کوانٹم منطق مسائل --------------------
  
  /// کوانٹم منطق کا مسئلہ حل کریں
  static Map<String, dynamic> solveQuantumProblem(String problem) {
    if (problem.contains('کوانٹم بٹ') && problem.contains('حالت')) {
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
      'solution': 'یہ کوانٹم مسئلہ ابھی حل نہیں کر سکتا',
      'complexity': 'نامعلوم'
    };
  }
  
  static Map<String, dynamic> _solveQubitStates(String problem) {
    // "n کوانٹم بٹس" سے عدد نکالیں
    final regex = RegExp(r'(\d+)\s*کوانٹم بٹ');
    final match = regex.firstMatch(problem);
    
    if (match != null) {
      final qubits = int.parse(match.group(1)!);
      final states = quantumStates(qubits);
      
      return {
        'type': 'qubit_states',
        'problem': problem,
        'solution': '$states ممکنہ حالت',
        'explanation': 'ہر کوانٹم بٹ 2 حالت رکھ سکتا ہے، اس لیے n qubits کے لیے 2ⁿ حالت',
        'classical_equivalent': '${qubits * 8} کلاسیکل بٹس کے برابر',
        'quantum_advantage': 'exponential (2ⁿ vs n)',
      };
    }
    
    return {'error': 'کوانٹم بٹس کی تعداد نہیں ملی'};
  }
  
  static Map<String, dynamic> _solveSuperposition(String problem) {
    return {
      'type': 'superposition',
      'problem': problem,
      'solution': 'سپر پوزیشن: ایک ہی وقت میں متعدد حالت',
      'explanation': 'کلاسیکل بٹ: یا 0 یا 1\nکوانٹم بٹ: α|0⟩ + β|1⟩ (دونوں ایک ساتھ)',
      'example': 'شروڈنگر کی بلی: زندہ اور مردہ دونوں ایک ساتھ',
      'probability': 'α² = |0⟩ ہونے کا احتمال، β² = |1⟩ ہونے کا احتمال',
    };
  }
  
  static Map<String, dynamic> _solveEntanglement(String problem) {
    return {
      'type': 'entanglement',
      'problem': problem,
      'solution': 'اینٹینگلمنٹ: دور دراز تعلق',
      'explanation': 'دو اینٹینگلڈ qubits کا ایک دوسرے سے فوری تعلق',
      'example': 'اگر ایک qubit 0 ہو تو دوسرا فوراً 1 ہو جاتا ہے (اور vice versa)',
      'distance': 'لامحدود فاصلہ پر کام کرتا ہے',
      'speed': 'روشنی کی رفتار سے تیز (فوری)',
      'application': 'کوانٹم ٹیلی پورٹیشن، کوانٹم کرپٹوگرافی',
    };
  }
  
  // -------------------- کوانٹم فلاسفی --------------------
  
  /// کوانٹم فلسفہ کا تجزیہ
  static String quantumPhilosophy(String question) {
    if (question.contains('شروڈنگر')) {
      return '''
🐱 شروڈنگر کی بلی:
- بلی بکس میں ہے
- ریڈیو ایکٹو ایٹم کا 50% احتمال decay
- اگر decay ہوا تو بلی مر جائے گی
- کوانٹم سپر پوزیشن: بلی زندہ اور مردہ دونوں ہے
- مشاہدہ پر: یا زندہ یا مردہ (سپر پوزیشن ٹوٹ جاتی ہے)
''';
    }
    
    if (question.contains('آئنسٹائن') && question.contains('spooky')) {
      return '''
👻 آئنسٹائن کا "spooky action at distance":
- آئنسٹائن: "کوانٹم مکینکس نامکمل ہے"
- اینٹینگلمنٹ کو "spooky" کہا
- EPR paradox: معلومات روشنی سے تیز نہیں سفر کر سکتی
- مگر تجربات ثابت کرتے ہیں: اینٹینگلمنٹ حقیقی ہے
''';
    }
    
    if (question.contains('بوہر') || question.contains('کوپن ہیگن')) {
      return '''
🧠 بوہر کا کوپن ہیگن تشریح:
1. مشاہدہ کا مسئلہ: صرف جب مشاہدہ کریں تو wave function collapse ہوتا ہے
2. Complementary: مقام اور رفتار ایک ساتھ نہیں جانے جا سکتے
3. کوانٹم دنیا کلاسیکل دنیا سے مختلف ہے
''';
    }
    
    return '''
⚛️ کوانٹم فلسفہ کے اہم نکات:
1. سپر پوزیشن: ایک ساتھ متعدد حالت
2. اینٹینگلمنٹ: دور دراز فوری تعلق  
3. عدم تعین: ہیزنبرگ کا اصول
4. مشاہدے کا اثر: wave function collapse
5. احتمال: قطعی نتائج نہیں، احتمال
''';
  }
  
  // -------------------- کوانٹم ٹیسٹ --------------------
  
  /// کوانٹم منطق کے تمام ٹیسٹ
  static void runQuantumTests() {
    print('⚛️ کوانٹم منطق ٹیسٹس');
    print('=' * 60);
    
    // ٹیسٹ 1: سپر پوزیشن
    print('\n1. سپر پوزیشن ٹیسٹ:');
    final sp = superposition(0.6, 0.8);
    print('سپر پوزیشن: |ψ⟩ = ${sp[0].toStringAsFixed(3)}|0⟩ + ${sp[1].toStringAsFixed(3)}|1⟩');
    print('نارملائزیشن: ${sp[0]*sp[0] + sp[1]*sp[1]} ≈ 1');
    
    // ٹیسٹ 2: کوانٹم حالت
    print('\n2. کوانٹم حالت ٹیسٹ:');
    print(quantumSuperpositionInfo(3));
    
    // ٹیسٹ 3: اینٹینگلمنٹ
    print('\n3. اینٹینگلمنٹ ٹیسٹ:');
    print('Bell state |Φ⁺⟩: ${bellState(0)}');
    
    // ٹیسٹ 4: منطق مسائل
    print('\n4. کوانٹم منطق مسائل:');
    
    final problems = [
      'تین کوانٹم بٹس میں کتنے ممکنہ حالت ہیں؟',
      'سپر پوزیشن کیا ہے؟',
      'اینٹینگلمنٹ کی خصوصیات کیا ہیں؟',
    ];
    
    for (var problem in problems) {
      print('\nسوال: $problem');
      final solution = solveQuantumProblem(problem);
      print('حل: ${solution['solution']}');
    }
    
    // ٹیسٹ 5: فلسفہ
    print('\n5. کوانٹم فلسفہ:');
    print(quantumPhilosophy('شروڈنگر کی بلی'));
  }
}

// -------------------- معاون کلاسز --------------------

/// کمپلیکس نمبر کے لئے معاون کلاس
class Complex {
  final double real;
  final double imag;
  
  Complex(this.real, this.imag);
  
  @override
  String toString() {
    if (imag >= 0) {
      return '$real + ${imag}i';
    } else {
      return '$real - ${-imag}i';
    }
  }
}

/// کوانٹم بٹ کی نمائندگی
class Qubit {
  double alpha; // |0⟩ کا احتمال کا جذر
  double beta;  // |1⟩ کا احتمال کا جذر
  
  Qubit([this.alpha = 1/sqrt(2), this.beta = 1/sqrt(2)]) {
    // نارملائز کریں
    final norm = sqrt(alpha * alpha + beta * beta);
    alpha /= norm;
    beta /= norm;
  }
  
  /// مشاہدہ (measurement)
  int measure() {
    final prob0 = alpha * alpha;
    return Random().nextDouble() < prob0 ? 0 : 1;
  }
  
  /// سپر پوزیشن کی معلومات
  String get superpositionInfo {
    return '''
|ψ⟩ = ${alpha.toStringAsFixed(3)}|0⟩ + ${beta.toStringAsFixed(3)}|1⟩
احتمال |0⟩: ${(alpha*alpha).toStringAsFixed(3)}
احتمال |1⟩: ${(beta*beta).toStringAsFixed(3)}
''';
  }
}
