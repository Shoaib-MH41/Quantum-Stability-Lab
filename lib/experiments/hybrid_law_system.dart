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

// ==================== HLS_CPU (مترجم - سب سے ہلکا) ====================
class _HLS_CPU {
  // صرف بنیادی صفائی اور ترجمانی
  Map<String, dynamic> translateInput(String input) {
    final cleaned = input.trim().toLowerCase();
    
    return {
      'original': input,
      'cleaned': cleaned,
      'length': input.length,
      'is_question': cleaned.contains('؟') || cleaned.contains('?'),
      'word_count': cleaned.split(' ').length,
      'contains_math': _containsMath(cleaned),
      'contains_quantum': _containsQuantum(cleaned),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
  
  bool _containsMath(String text) {
    final mathWords = ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'حساب', '+', '-', '*', '/'];
    return mathWords.any((word) => text.contains(word));
  }
  
  bool _containsQuantum(String text) {
    final quantumWords = ['کوانٹم', 'سپر', 'اینٹینگلمنٹ', 'شروڈنگر', 'بلی'];
    return quantumWords.any((word) => text.contains(word));
  }
}

// ==================== HLS_GPU (مزدور - تمام بھاری کام) ====================
class _HLS_GPU {
  // تمام بھاری ٹولز
  final LawBasedGPUCalculator _calculator = LawBasedGPUCalculator();
  final MathToLanguageConverter _mathToLanguage = MathToLanguageConverter();
  final LanguageToMathConverter _languageToMath = LanguageToMathConverter();
  final EnhancedLanguageToMath _enhancedConverter = EnhancedLanguageToMath();
  final AdvancedMathLaws _advancedLaws = AdvancedMathLaws();
  
  // کام 1: قانونی ریاضی کا حساب
  String _calculateWithLaw(String expression, String lawType) {
    try {
      final result = _calculator.calculate(expression);
      return '''
🧮 **قانونی حساب (GPU)**
استعمال شدہ قانون: $lawType
اظہار: $expression
نتیجہ: $result

ℹ️ GPU نے LawBasedGPUCalculator استعمال کیا''';
    } catch (e) {
      return 'حسابی خرابی: $e';
    }
  }
  
  // کام 2: کوانٹم تجزیہ
  String _analyzeQuantum(String question) {
    try {
      final result = QuantumLogic.process(question);
      return '''
⚛️ **کوانٹم تجزیہ (GPU)**
سوال: $question
نتیجہ: $result

ℹ️ GPU نے QuantumLogic.process() استعمال کیا''';
    } catch (e) {
      return 'کوانٹم تجزیہ خرابی: $e';
    }
  }
  
  // کام 3: منطقی حل
  String _solveLogicProblem(String question) {
    try {
      final solution = LogicSolver.solvePuzzle(question);
      return '''
🧩 **منطقی حل (GPU)**
مسئلہ: $question
حل: ${solution['solution'] ?? 'دستیاب نہیں'}

ℹ️ GPU نے LogicSolver استعمال کیا''';
    } catch (e) {
      return 'منطقی حل خرابی: $e';
    }
  }
  
  // کام 4: زبان کی تبدیلی
  String _convertLanguage(String question, dynamic result) {
    try {
      final converted = _mathToLanguage.convert(result, question);
      return '''
🗣️ **زبان تبدیلی (GPU)**
اصل سوال: $question
ریاضی نتیجہ: $result
اردو جواب: $converted

ℹ️ GPU نے MathToLanguageConverter استعمال کیا''';
    } catch (e) {
      return 'زبان تبدیلی خرابی: $e';
    }
  }
  
  // کام 5: اعلیٰ ریاضی قوانین
  String _applyAdvancedMath(String question) {
    try {
      // فرض کریں کہ AdvancedMathLaws میں process میتھڈ ہے
      final result = _advancedLaws.process(question);
      return '''
🎓 **اعلیٰ ریاضی (GPU)**
سوال: $question
نتیجہ: $result

ℹ️ GPU نے AdvancedMathLaws استعمال کیا''';
    } catch (e) {
      return 'اعلیٰ ریاضی خرابی: $e';
    }
  }
  
  // GPU کا مرکزی کام کرنے کا طریقہ
  String executeHeavyWork(Map<String, dynamic> command) {
    final workType = command['work_type'] ?? '';
    final data = command['data'] ?? {};
    
    print('[HLS_GPU] ⚡ بھاری کام شروع: $workType');
    
    switch (workType) {
      case 'law_calculation':
        return _calculateWithLaw(
          data['expression'] ?? '',
          data['law_type'] ?? 'basic_law',
        );
        
      case 'quantum_analysis':
        return _analyzeQuantum(data['question'] ?? '');
        
      case 'logic_solution':
        return _solveLogicProblem(data['question'] ?? '');
        
      case 'language_conversion':
        return _convertLanguage(
          data['question'] ?? '',
          data['result'] ?? 0,
        );
        
      case 'advanced_math':
        return _applyAdvancedMath(data['question'] ?? '');
        
      case 'complex_processing':
        return _processComplexTask(data);
        
      default:
        return 'GPU: نامعلوم کام کی قسم';
    }
  }
  
  // پیچیدہ کاموں کے لیے
  String _processComplexTask(Map<String, dynamic> data) {
    final task = data['task'] ?? '';
    
    if (task == 'full_math_solution') {
      // مکمل ریاضی حل: زبان → ریاضی → حساب → زبان
      final question = data['question'] ?? '';
      
      // 1. زبان سے ریاضی
      final mathExpr = _languageToMath.convert(question);
      
      // 2. حساب
      final calcResult = _calculator.calculate(mathExpr);
      
      // 3. ریاضی سے زبان
      final finalAnswer = _mathToLanguage.convert(calcResult, question);
      
      return '''
🔄 **مکمل ریاضی حل (GPU)**
مراحل:
1. زبان → ریاضی: $mathExpr
2. قانونی حساب: $calcResult
3. ریاضی → زبان: $finalAnswer

✅ GPU نے تمام مراحل خود مکمل کیے''';
    }
    
    return 'GPU: پیچیدہ کام نامعلوم';
  }
}

// ==================== HLS_NPU (حاکم - صرف انتظام) ====================
class _HLS_NPU {
  final _HLS_CPU _cpu = _HLS_CPU();
  final _HLS_GPU _gpu = _HLS_GPU();
  
  // NPU کا کام: GPU کو کیا کام دینا ہے؟
  Map<String, dynamic> _decideWorkForGPU(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    final original = parsedInput['original'];
    
    if (parsedInput['contains_math']) {
      // NPU فیصلہ: یہ ریاضی ہے، GPU سے کہو مکمل حل کرے
      return {
        'work_type': 'complex_processing',
        'data': {
          'task': 'full_math_solution',
          'question': original,
          'complexity': 'high',
        },
        'reason': 'NPU نے ریاضی کا مکمل حل GPU کو سونپا',
      };
    }
    else if (parsedInput['contains_quantum']) {
      // NPU فیصلہ: یہ کوانٹم ہے، GPU سے تجزیہ کروائے
      return {
        'work_type': 'quantum_analysis',
        'data': {
          'question': original,
          'depth': 'detailed',
        },
        'reason': 'NPU نے کوانٹم تجزیہ GPU کو سونپا',
      };
    }
    else if (_containsLogic(text)) {
      // NPU فیصلہ: یہ منطق ہے، GPU سے حل کروائے
      return {
        'work_type': 'logic_solution',
        'data': {
          'question': original,
          'type': 'puzzle',
        },
        'reason': 'NPU نے منطقی مسئلہ GPU کو سونپا',
      };
    }
    
    // عمومی معاملہ
    return {
      'work_type': 'advanced_math',
      'data': {
        'question': original,
        'fallback': true,
      },
      'reason': 'NPU نے عمومی پروسیسنگ GPU کو سونپا',
    };
  }
  
  bool _containsLogic(String text) {
    final logicWords = ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق', 'پہیلی'];
    return logicWords.any((word) => text.contains(word));
  }
  
  // NPU کا مرکزی انتظامی فنکشن
  String manageAndDelegate(String userInput) {
    print('[HLS_NPU] 🤔 انتظام شروع...');
    
    // مرحلہ 1: CPU سے صفائی (ہلکا کام)
    final parsedInput = _cpu.translateInput(userInput);
    print('[HLS_NPU] ✅ CPU نے صفائی مکمل کی');
    
    // مرحلہ 2: NPU فیصلہ سازی (دماغی کام)
    final workDecision = _decideWorkForGPU(parsedInput);
    print('[HLS_NPU] 🎯 فیصلہ: ${workDecision['reason']}');
    
    // مرحلہ 3: GPU کو کام سونپنا (بھاری کام)
    print('[HLS_NPU] ⚡ GPU کو کام تفویض کر رہا ہوں...');
    final gpuResult = _gpu.executeHeavyWork(workDecision);
    print('[HLS_NPU] ✅ GPU نے کام مکمل کر لیا');
    
    // مرحلہ 4: NPU حتمی جواب ترتیب دے
    final finalResponse = _formatManagedResponse(gpuResult, workDecision);
    
    return finalResponse;
  }
  
  // NPU کا کام: GPU کے نتائج کو خوبصورت بنانا
  String _formatManagedResponse(String gpuResult, Map<String, dynamic> decision) {
    return '''
🏗️ **HybridLawSystem - کام کی تقسیم**
${'-' * 40}

🧭 **NPU کا فیصلہ:**
${decision['reason']}
کام کی قسم: ${decision['work_type']}

⚡ **GPU کا نتیجہ:**
$gpuResult

📊 **کارکردگی خلاصہ:**
- CPU: صفائی اور ترجمانی ✅
- NPU: فیصلہ سازی اور انتظام ✅
- GPU: بھاری کام اور حساب ✅

🔗 **سسٹم انضمام:**
یہ نتیجہ HybridLawSystem کے اندرونی NPU/GPU/CPU کے باہمی تعاون کا نتیجہ ہے۔
''';
  }
}

// ==================== HybridLawSystem (مکمل سسٹم) ====================
class HybridLawSystem {
  // ہمارا اندرونی NPU جو سب انتظام کرے گا
  final _HLS_NPU _npu = _HLS_NPU();
  
  int _totalTasks = 0;
  List<Map<String, dynamic>> _performanceLog = [];
  
  // واحد پبلک میتھڈ - QuantumMasterController کے NPU سے حکم لے کر
  String answer(String question) {
    _totalTasks++;
    
    final taskRecord = {
      'id': _totalTasks,
      'question': question,
      'start_time': DateTime.now(),
      'status': 'processing',
    };
    
    _performanceLog.add(taskRecord);
    
    print('\n[HybridLawSystem] 🚀 نیا کام #$_totalTasks');
    print('[HLS] سوال: "${question.substring(0, min(30, question.length))}..."');
    
    try {
      // اپنے NPU کو انتظام سونپیں
      final result = _npu.manageAndDelegate(question);
      
      taskRecord['status'] = 'completed';
      taskRecord['end_time'] = DateTime.now();
      taskRecord['duration_ms'] = taskRecord['end_time']!.difference(taskRecord['start_time']!).inMilliseconds;
      
      print('[HybridLawSystem] ✅ کام مکمل ہوا');
      
      return result;
      
    } catch (e) {
      taskRecord['status'] = 'failed';
      taskRecord['error'] = e.toString();
      
      print('[HybridLawSystem] ❌ کام ناکام: $e');
      
      return '''
🔄 **HybridLawSystem - عارضی خرابی**

سوال: "$question"

خرابی: $e

سسٹم کی حیثیت:
- اندرونی NPU: مسئلہ
- اندرونی GPU: غیر فعال
- کام: نامکمل

براہ کرم:
1. سوال دوبارہ درج کریں
2. سادہ الفاظ استعمال کریں
3. نظام کو ریسٹارٹ کریں
''';
    }
  }
  
  // کارکردگی کی معلومات
  String get performanceReport {
    final completed = _performanceLog.where((t) => t['status'] == 'completed').length;
    final failed = _performanceLog.where((t) => t['status'] == 'failed').length;
    final successRate = _totalTasks > 0 ? (completed / _totalTasks * 100).toStringAsFixed(1) : '0.0';
    
    // اوسط وقت کا حساب
    var avgTime = 0;
    if (completed > 0) {
      final totalTime = _performanceLog
          .where((t) => t['duration_ms'] != null)
          .fold(0, (sum, t) => sum + (t['duration_ms'] as int));
      avgTime = totalTime ~/ completed;
    }
    
    return '''
📈 **HybridLawSystem کارکردگی رپورٹ**
${'-' * 40}

📊 **اعداد و شمار:**
- کل کام: $_totalTasks
- کامیاب: $completed
- ناکام: $failed
- کامیابی کی شرح: $successRate%
- اوسط وقت: ${avgTime}ms

🏗️ **اندرونی ڈھانچہ:**
├── HLS_CPU: ان پٹ صفائی
├── HLS_NPU: انتظام اور فیصلہ سازی
└── HLS_GPU: تمام بھاری کام (حساب، تجزیہ، حل)

🔧 **موجودہ ٹولز:**
- LawBasedGPUCalculator
- QuantumLogic
- LogicSolver
- Language/Math Converters
- AdvancedMathLaws

🔄 **کام کا بہاؤ:**
سوال → HLS_CPU → HLS_NPU → HLS_GPU → جواب
''';
  }
  
  // سسٹم ٹیسٹ
  void runInternalTest() {
    print('\n🔧 **HybridLawSystem اندرونی ٹیسٹ**\n');
    
    final testQuestions = [
      'دو جمع دو کیا ہے؟',
      'سپر پوزیشن کیا ہے؟',
      'مصافحہ میں دس افراد',
      'تین ضرب چار کا حساب کریں',
    ];
    
    for (var question in testQuestions) {
      print('─' * 50);
      print('❓ ٹیسٹ سوال: "$question"');
      final response = answer(question);
      print('📋 جواب کا خلاصہ:');
      
      // صرف پہلی چند لائنیں دکھائیں
      final lines = response.split('\n');
      for (var i = 0; i < min(5, lines.length); i++) {
        print('   ${lines[i]}');
      }
      if (lines.length > 5) print('   ...');
    }
    
    print('\n${performanceReport}');
  }
}
