import 'dart:math';
import 'cpu_translator.dart';
import 'cpu_intent.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';
import 'language_to_math.dart';
import 'logic_solver.dart';
import 'enhanced_language_to_math.dart';
import 'advanced_math_laws.dart';
import 'quantum_logic.dart';

// ==================== CPU کلاس (ترجمہ کار) ====================
class _CPU {
  final LanguageToMathConverter _languageToMath = LanguageToMathConverter();
  final CPUIntentDetector _intentDetector = CPUIntentDetector(); // فرض کریں کہ یہ کلاس موجود ہے
  
  Map<String, dynamic> _cleanInput(String input) {
    return {
      'original': input,
      'cleaned': input.toLowerCase().trim(),
      'length': input.length,
      'word_count': input.split(' ').length,
      'has_question': input.contains('؟') || input.contains('?'),
    };
  }
  
  String _detectIntent(String cleanedInput) {
    // آسان نیت کا پتہ لگانا
    if (_containsMath(cleanedInput)) return 'math';
    if (_containsQuantum(cleanedInput)) return 'quantum';
    if (_containsPhilosophy(cleanedInput)) return 'philosophy';
    if (_containsLogic(cleanedInput)) return 'logic';
    return 'general';
  }
  
  bool _containsMath(String text) {
    final mathWords = ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'کتنے', 'حساب', '+', '-', '*', '/'];
    return mathWords.any((word) => text.contains(word));
  }
  
  bool _containsQuantum(String text) {
    final quantumWords = ['کوانٹم', 'سپر پوزیشن', 'اینٹینگلمنٹ', 'شروڈنگر', 'بلی'];
    return quantumWords.any((word) => text.contains(word));
  }
  
  bool _containsPhilosophy(String text) {
    final philosophyWords = ['کائنات', 'راز', 'وجود', 'حقیقت', 'زندگی', 'موت', 'روح'];
    return philosophyWords.any((word) => text.contains(word));
  }
  
  bool _containsLogic(String text) {
    final logicWords = ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق', 'پہیلی'];
    return logicWords.any((word) => text.contains(word));
  }
  
  Map<String, dynamic> process(String input) {
    final cleaned = _cleanInput(input);
    final intent = _detectIntent(cleaned['cleaned'].toString());
    
    return {
      ...cleaned,
      'intent': intent,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

// ==================== GPU کلاس (مزدور) ====================
class _GPU {
  final LawBasedGPUCalculator _calculator = LawBasedGPUCalculator();
  final AdvancedMathLaws _advancedLaws = AdvancedMathLaws(); // فرض کریں کہ یہ کلاس موجود ہے
  
  dynamic _applyBasicMath(Map<String, dynamic> parsedData) {
    try {
      final expression = parsedData['math_expression']?.toString() ?? '';
      if (expression.isNotEmpty) {
        return _calculator.calculate(expression);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  
  dynamic _applyQuantumLogic(Map<String, dynamic> parsedData) {
    try {
      final question = parsedData['original']?.toString() ?? '';
      return QuantumLogic.process(question);
    } catch (e) {
      return null;
    }
  }
  
  dynamic _applyLogicPuzzle(Map<String, dynamic> parsedData) {
    try {
      final question = parsedData['original']?.toString() ?? '';
      final puzzle = LogicSolver.solvePuzzle(question);
      return puzzle['solution']?.toString() ?? '';
    } catch (e) {
      return null;
    }
  }
  
  dynamic calculate(Map<String, dynamic> parsedData) {
    final intent = parsedData['intent']?.toString() ?? '';
    
    switch (intent) {
      case 'math':
        return _applyBasicMath(parsedData);
      case 'quantum':
        return _applyQuantumLogic(parsedData);
      case 'logic':
        return _applyLogicPuzzle(parsedData);
      default:
        return null;
    }
  }
}

// ==================== NPU کلاس (حاکم/دماغ) ====================
class _NPU {
  final _cpu = _CPU();
  final _gpu = _GPU();
  final MathToLanguageConverter _mathToLanguage = MathToLanguageConverter();
  final EnhancedLanguageToMath _enhancedLanguageToMath = EnhancedLanguageToMath(); // فرض کریں کہ یہ کلاس موجود ہے
  
  Map<String, dynamic> _prepareMathData(Map<String, dynamic> parsedData) {
    final question = parsedData['original']?.toString() ?? '';
    try {
      final mathExpression = _enhancedLanguageToMath.convert(question);
      return {
        ...parsedData,
        'math_expression': mathExpression,
        'requires_calculation': true,
      };
    } catch (e) {
      return parsedData;
    }
  }
  
  Map<String, dynamic> _prepareGeneralData(Map<String, dynamic> parsedData) {
    // جنرل سوالات کے لیے اضافی ڈیٹا
    return {
      ...parsedData,
      'requires_analysis': true,
    };
  }
  
  String _processMathQuestion(Map<String, dynamic> parsedData) {
    final preparedData = _prepareMathData(parsedData);
    final rawResult = _gpu.calculate(preparedData);
    
    if (rawResult != null) {
      try {
        final question = parsedData['original']?.toString() ?? '';
        return _mathToLanguage.convert(rawResult, question);
      } catch (e) {
        return _getDefaultMathAnswer(rawResult);
      }
    }
    
    return 'حساب میں مسئلہ پیش آیا';
  }
  
  String _processQuantumQuestion(Map<String, dynamic> parsedData) {
    final rawResult = _gpu.calculate(parsedData);
    return rawResult?.toString() ?? 'کوانٹم تجزیہ دستیاب نہیں';
  }
  
  String _processLogicQuestion(Map<String, dynamic> parsedData) {
    final rawResult = _gpu.calculate(parsedData);
    return rawResult?.toString() ?? 'منطقی حل دستیاب نہیں';
  }
  
  String _processGeneralQuestion(Map<String, dynamic> parsedData) {
    // جنرل سوالات کے لیے سادہ جواب
    final question = parsedData['original']?.toString() ?? '';
    if (question.contains('آپ') || question.contains('تم')) {
      return 'میں ایک AI معاون ہوں';
    }
    if (question.contains('نام') || question.contains('کون')) {
      return 'میرا نام Hybrid Law System ہے';
    }
    return 'میں آپ کے سوال کا جواب نہیں دے سکتا';
  }
  
  String _getDefaultMathAnswer(dynamic result) {
    if (result is num) {
      return 'جواب: $result';
    }
    return result.toString();
  }
  
  String _formatFinalAnswer(String rawAnswer, String intent) {
    // صرف فائنل جواب تیار کریں - کوئی اضافی معلومات نہیں
    switch (intent) {
      case 'math':
        return rawAnswer;
      case 'quantum':
        return 'کوانٹم جواب: $rawAnswer';
      case 'logic':
        return 'منطقی جواب: $rawAnswer';
      case 'philosophy':
        return 'فلسفیانہ جواب: $rawAnswer';
      default:
        return rawAnswer;
    }
  }
  
  String process(String input) {
    // 1. CPU سے پارسنگ
    final parsedData = _cpu.process(input);
    
    // 2. مناسبت سے پروسیسنگ
    final intent = parsedData['intent']?.toString() ?? 'general';
    String rawAnswer;
    
    switch (intent) {
      case 'math':
        rawAnswer = _processMathQuestion(parsedData);
        break;
      case 'quantum':
        rawAnswer = _processQuantumQuestion(parsedData);
        break;
      case 'logic':
        rawAnswer = _processLogicQuestion(parsedData);
        break;
      case 'philosophy':
        rawAnswer = _processGeneralQuestion(parsedData);
        break;
      default:
        rawAnswer = _processGeneralQuestion(parsedData);
    }
    
    // 3. فائنل فارمیٹنگ
    return _formatFinalAnswer(rawAnswer, intent);
  }
}

// ==================== HybridLawSystem (پبلک انٹرفیس) ====================
class HybridLawSystem {
  // پرائیویٹ اجزاء
  final _npu = _NPU();
  
  // پرائیویٹ اعداد و شمار
  int _totalProcessed = 0;
  int _mathQuestions = 0;
  int _quantumQuestions = 0;
  int _philosophyQuestions = 0;
  int _logicQuestions = 0;
  
  // واحد پبلک میتھڈ
  String answer(String urduQuestion) {
    // NULL چیک
    if (urduQuestion.isEmpty) {
      return 'براہ کرم سوال درج کریں';
    }
    
    _totalProcessed++;
    
    try {
      // NPU کو تمام کام کے لیے بھیجیں
      final result = _npu.process(urduQuestion);
      
      // پرائیویٹ اعداد و شمار اپڈیٹ کریں
      _updateStatistics(urduQuestion);
      
      // صرف فائنل جواب واپس کریں
      return result;
      
    } catch (e) {
      return 'جواب دینے میں مسئلہ پیش آیا';
    }
  }
  
  // پرائیویٹ اعداد و شمار میتھڈ
  void _updateStatistics(String question) {
    final questionLower = question.toLowerCase();
    
    if (_containsMath(questionLower)) {
      _mathQuestions++;
    } else if (questionLower.contains('کوانٹم')) {
      _quantumQuestions++;
    } else if (_containsPhilosophy(questionLower)) {
      _philosophyQuestions++;
    } else if (_containsLogic(questionLower)) {
      _logicQuestions++;
    }
  }
  
  bool _containsMath(String text) {
    final mathWords = ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'حساب'];
    return mathWords.any((word) => text.contains(word));
  }
  
  bool _containsPhilosophy(String text) {
    final philosophyWords = ['کائنات', 'راز', 'وجود', 'حقیقت', 'زندگی'];
    return philosophyWords.any((word) => text.contains(word));
  }
  
  bool _containsLogic(String text) {
    final logicWords = ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق'];
    return logicWords.any((word) => text.contains(word));
  }
  
  // اختیاری: سادہ سسٹم انفو (اگر چاہیں)
  String get systemInfo {
    return '''
سوالات: $_totalProcessed
ریاضی: $_mathQuestions
کوانٹم: $_quantumQuestions
فلسفہ: $_philosophyQuestions
منطق: $_logicQuestions
''';
  }
  
  // سادہ ٹیسٹ
  void runQuickTest() {
    final tests = [
      'دو جمع دو کیا ہے؟',
      'تین ضرب چار کتنے ہوتے ہیں؟',
      'سپر پوزیشن کیا ہے؟',
      'مصافحہ میں پانچ افراد',
      'آپ کا نام کیا ہے؟',
    ];
    
    print('🧪 Hybrid System - سادہ ٹیسٹ\n');
    
    for (final test in tests) {
      print('❓ "$test"');
      print('✅ "${answer(test)}"');
      print('─' * 40);
    }
    
    print('\n📊 نظام معلومات:');
    print(systemInfo);
  }
}
