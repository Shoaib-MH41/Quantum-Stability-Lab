import '../experiments/hybrid_law_system.dart';

// ==================== CPU کلاس ====================
// صرف یوزر کے ان پٹ کو صاف کرنا اور ترجمہ کرنا
class _CPU {
  String _cleanInput(String input) {
    // فالتو سپیس اور نشانات ہٹائیں
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  Map<String, dynamic> _parseInput(String input) {
    final cleaned = _cleanInput(input);
    
    return {
      'original': input,
      'cleaned': cleaned,
      'word_count': cleaned.split(' ').length,
      'char_count': cleaned.length,
      'has_question_mark': cleaned.contains('؟') || cleaned.contains('?'),
      'language': _detectLanguage(cleaned),
      'tokens': cleaned.split(' '),
    };
  }

  String _detectLanguage(String text) {
    final urduRegex = RegExp(r'[\u0600-\u06FF]');
    return urduRegex.hasMatch(text) ? 'urdu' : 'english';
  }

  Map<String, dynamic> process(String userInput) {
    return _parseInput(userInput);
  }
}

// ==================== GPU کلاس ====================
// صرف ریاضیاتی حساب کتاب
class _GPU {
  dynamic _applyMathOperation(String operation, dynamic a, dynamic b) {
    switch (operation) {
      case 'add':
        return a + b;
      case 'subtract':
        return a - b;
      case 'multiply':
        return a * b;
      case 'divide':
        return b != 0 ? a / b : 'undefined';
      default:
        return 'unknown_operation';
    }
  }

  dynamic _applyHybridLaw(dynamic data) {
    // یہاں Hybrid Law کے فارمولے لگائیں
    if (data is Map<String, dynamic>) {
      if (data.containsKey('numbers')) {
        final numbers = data['numbers'] as List;
        if (numbers.length >= 2) {
          return numbers.reduce((a, b) => a + b);
        }
      }
    }
    return data;
  }

  dynamic calculate(Map<String, dynamic> data) {
    if (data['type'] == 'math') {
      return _applyMathOperation(
        data['operation'],
        data['operand1'],
        data['operand2'],
      );
    } else if (data['type'] == 'hybrid_law') {
      return _applyHybridLaw(data['data']);
    }
    return 'unsupported_calculation';
  }
}

// ==================== NPU کلاس ====================
// مرکزی حصہ - فیصلہ کرنا اور کنٹرول کرنا
class _NPU {
  final _cpu = _CPU();
  final _gpu = _GPU();
  final HybridLawSystem _hybridSystem = HybridLawSystem();

  String _determineQuestionType(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'].toString().toLowerCase();
    
    if (text.contains('جمع') || 
        text.contains('ضرب') || 
        text.contains('تفریق') || 
        text.contains('تقسیم') ||
        text.contains('+') ||
        text.contains('*') ||
        text.contains('-') ||
        text.contains('/')) {
      return 'math';
    } else if (text.contains('کوانٹم') || 
               text.contains('سائنس') || 
               text.contains('طبیعیات')) {
      return 'science';
    } else if (text.contains('فلسفہ') || 
               text.contains('دماغ') || 
               text.contains('عقل')) {
      return 'philosophy';
    } else if (text.contains('کائنات') || 
               text.contains('ستارے') || 
               text.contains('سیارے')) {
      return 'cosmic';
    }
    return 'general';
  }

  Map<String, dynamic> _extractMathData(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'].toString();
    final tokens = text.split(' ');
    
    // سادہ ریاضی کی شناخت
    if (text.contains('جمع')) {
      final numbers = _extractNumbers(text);
      if (numbers.length >= 2) {
        return {
          'type': 'math',
          'operation': 'add',
          'operand1': numbers[0],
          'operand2': numbers[1],
        };
      }
    } else if (text.contains('ضرب')) {
      final numbers = _extractNumbers(text);
      if (numbers.length >= 2) {
        return {
          'type': 'math',
          'operation': 'multiply',
          'operand1': numbers[0],
          'operand2': numbers[1],
        };
      }
    }
    
    return {'type': 'unknown'};
  }

  List<num> _extractNumbers(String text) {
    final regex = RegExp(r'\d+');
    return regex.allMatches(text).map((match) => num.parse(match.group(0)!)).toList();
  }

  String _processMathQuestion(Map<String, dynamic> parsedInput) {
    final mathData = _extractMathData(parsedInput);
    final result = _gpu.calculate(mathData);
    
    if (result is num) {
      return 'جواب: $result';
    }
    
    // اگر GPU نہیں حل کر سکا، تو hybrid system استعمال کریں
    final hybridResult = _hybridSystem.answer(parsedInput['original'].toString());
    return hybridResult;
  }

  String _processGeneralQuestion(Map<String, dynamic> parsedInput) {
    return _hybridSystem.answer(parsedInput['original'].toString());
  }

  String _generateFinalResponse(String question, String answer, String questionType) {
    // صرف فائنل جواب تیار کریں - کوئی اندرونی تفصیلات نہیں
    switch (questionType) {
      case 'math':
        return answer;
      case 'science':
        return 'سائنسی جواب: $answer';
      case 'philosophy':
        return 'فلسفیانہ جواب: $answer';
      case 'cosmic':
        return 'کائناتی جواب: $answer';
      default:
        return answer;
    }
  }

  String process(Map<String, dynamic> parsedInput) {
    final questionType = _determineQuestionType(parsedInput);
    String processedAnswer;

    switch (questionType) {
      case 'math':
        processedAnswer = _processMathQuestion(parsedInput);
        break;
      default:
        processedAnswer = _processGeneralQuestion(parsedInput);
        break;
    }

    return _generateFinalResponse(
      parsedInput['original'].toString(),
      processedAnswer,
      questionType,
    );
  }
}

// ==================== QuantumMasterController ====================
// پبلک انٹرفیس - صرف ask() میتھڈ دستیاب ہے
class QuantumMasterController {
  // پرائیویٹ اجزاء
  final _npu = _NPU();
  
  // پرائیویٹ سیشن ڈیٹا
  int _totalQuestionsAsked = 0;
  int _successfulAnswers = 0;
  DateTime _sessionStart = DateTime.now();

  // واحد پبلک میتھڈ - صرف یہی باہر سے قابل رسائی ہے
  String ask(String urduQuestion) {
    _totalQuestionsAsked++;
    
    try {
      // 1. CPU کو ان پٹ پراسیسنگ کے لیے بھیجیں
      // یہ مرحلہ مکمل طور پر پرائیویٹ ہے
      final parsedInput = _npu._cpu.process(urduQuestion);
      
      // 2. NPU کو مرکزی پروسیسنگ کے لیے بھیجیں
      final result = _npu.process(parsedInput);
      
      _successfulAnswers++;
      
      // 3. صرف فائنل جواب واپس کریں
      return result;
      
    } catch (e) {
      // خرابی کی صورت میں بھی صرف سادہ جواب
      return 'معذرت، میں اس وقت آپ کے سوال کا جواب نہیں دے سکتا۔';
    }
  }

  // اختیاری: سادہ سیشن انفو (اگر چاہیں تو)
  String get sessionInfo {
    final duration = DateTime.now().difference(_sessionStart);
    final successRate = _totalQuestionsAsked > 0 
        ? ((_successfulAnswers / _totalQuestionsAsked) * 100).toStringAsFixed(1)
        : '0.0';
    
    return '''
سوالات: $_totalQuestionsAsked
کامیاب: $_successfulAnswers
کامیابی کی شرح: $successRate%
سیشن کا وقت: ${duration.inMinutes} منٹ
''';
  }

  // سادہ ٹیسٹ فنکشن
  void runSimpleTests() {
    final tests = [
      'دو جمع دو کیا ہے؟',
      'تین ضرب چار کتنے ہوتے ہیں؟',
      'آپ کا نام کیا ہے؟',
    ];

    print('🧪 سادہ ٹیسٹ شروع\n');
    
    for (final test in tests) {
      print('سوال: "$test"');
      print('جواب: "${ask(test)}"');
      print('─' * 40);
    }
    
    print('\n📊 سیشن کی معلومات:');
    print(sessionInfo);
  }
}
