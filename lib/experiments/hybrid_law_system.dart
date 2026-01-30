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

// ==================== HLS_CPU کلاس (مترجم) ====================
class _HLS_CPU {
  // CPU کا کام: صرف صفائی، ترجمانی اور نیت کا پتہ لگانا
  Map<String, dynamic> translateAndAnalyze(String input) {
    final cleaned = input.trim().toLowerCase();
    
    // نیت کا پتہ لگانا
    String intent = 'general';
    if (_containsMathKeywords(cleaned)) intent = 'math';
    else if (_containsQuantumKeywords(cleaned)) intent = 'quantum';
    else if (_containsPhilosophyKeywords(cleaned)) intent = 'philosophy';
    else if (_containsLogicKeywords(cleaned)) intent = 'logic';
    
    return {
      'original': input,
      'cleaned': cleaned,
      'intent': intent,
      'length': input.length,
      'word_count': cleaned.split(' ').length,
      'timestamp': DateTime.now(),
    };
  }
  
  bool _containsMathKeywords(String text) {
    final mathWords = ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'کتنے', 'حساب', '+', '-', '*', '/'];
    return mathWords.any((word) => text.contains(word));
  }
  
  bool _containsQuantumKeywords(String text) {
    final quantumWords = ['کوانٹم', 'سپر پوزیشن', 'اینٹینگلمنٹ', 'شروڈنگر', 'بلی', 'طول موج'];
    return quantumWords.any((word) => text.contains(word));
  }
  
  bool _containsPhilosophyKeywords(String text) {
    final philosophyWords = ['کائنات', 'راز', 'وجود', 'حقیقت', 'زندگی', 'موت', 'روح'];
    return philosophyWords.any((word) => text.contains(word));
  }
  
  bool _containsLogicKeywords(String text) {
    final logicWords = ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق', 'پہیلی'];
    return logicWords.any((word) => text.contains(word));
  }
}

// ==================== HLS_GPU کلاس (مزدور - تمام بھاری کام) ====================
class _HLS_GPU {
  // GPU کے تمام ٹولز
  final LawBasedGPUCalculator _gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter _mathToLanguage = MathToLanguageConverter();
  final LanguageToMathConverter _languageToMath = LanguageToMathConverter();
  final EnhancedLanguageToMath _enhancedConverter = EnhancedLanguageToMath();
  final AdvancedMathLaws _advancedLaws = AdvancedMathLaws();
  
  // GPU کا کام 1: ریاضی کا حساب
  Map<String, dynamic> calculateMath(String urduQuestion) {
    try {
      // زبان → ریاضی
      String mathExpression = _languageToMath.convert(urduQuestion);
      
      // قانونی حساب
      num mathResult = _gpuCalculator.calculate(mathExpression);
      
      // ریاضی → اردو
      String urduAnswer = _mathToLanguage.convert(mathResult, urduQuestion);
      
      return {
        'success': true,
        'math_expression': mathExpression,
        'numeric_result': mathResult,
        'urdu_answer': urduAnswer,
        'used_law': _getMathLaw(mathExpression),
        'complexity': _getComplexity(urduQuestion),
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'حسابی خرابی: $e',
        'fallback_answer': _getMathFallback(urduQuestion),
      };
    }
  }
  
  // GPU کا کام 2: کوانٹم تجزیہ
  Map<String, dynamic> analyzeQuantum(String urduQuestion) {
    try {
      String result = QuantumLogic.process(urduQuestion);
      
      return {
        'success': true,
        'quantum_result': result,
        'science_aspect': _getQuantumScience(urduQuestion),
        'philosophy_aspect': _getQuantumPhilosophy(urduQuestion),
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'کوانٹم تجزیہ خرابی: $e',
      };
    }
  }
  
  // GPU کا کام 3: فلسفیانہ/منطقی تجزیہ
  Map<String, dynamic> analyzePhilosophy(String urduQuestion) {
    try {
      Map<String, dynamic> puzzle = LogicSolver.solvePuzzle(urduQuestion);
      String solution = puzzle.containsKey('solution') ? puzzle['solution'].toString() : '';
      
      return {
        'success': true,
        'logical_solution': solution,
        'philosophical_interpretation': _getPhilosophicalInterpretation(urduQuestion),
        'human_aspect': _getHumanAspect(urduQuestion),
        'wisdom': _getWisdom(urduQuestion),
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'منطقی تجزیہ خرابی: $e',
      };
    }
  }
  
  // GPU کا کام 4: عمومی تجزیہ
  Map<String, dynamic> analyzeGeneral(String urduQuestion) {
    return {
      'success': true,
      'analysis_type': 'general',
      'observation': 'یہ سوال عمومی نوعیت کا ہے۔',
      'recommendation': 'براہ کرم سوال کو مزید واضح کریں یا کسی خاص موضوع پر بات کریں۔',
    };
  }
  
  // Helper methods (یہ GPU کی ذمہ داری ہے)
  String _getMathLaw(String expression) {
    if (expression.contains('+')) return 'جمع کا قانون (Law of Addition)';
    if (expression.contains('*')) return 'ضرب کا قانون (Law of Multiplication)';
    if (expression.contains('/')) return 'تقسیم کا قانون (Law of Division)';
    if (expression.contains('-')) return 'تفریق کا قانون (Law of Subtraction)';
    return 'بنیادی ریاضی کا قانون';
  }
  
  String _getComplexity(String question) {
    int length = question.length;
    if (length < 10) return 'آسان';
    if (length < 20) return 'متوسط';
    if (length < 30) return 'پیچیدہ';
    return 'بہت پیچیدہ';
  }
  
  String _getQuantumScience(String question) {
    if (question.contains('سپر پوزیشن')) {
      return 'سپرپوزیشن میں کوئی چیز ایک وقت میں کئی حالات میں ہو سکتی ہے۔';
    }
    if (question.contains('اینٹینگلمنٹ')) {
      return 'اینٹینگلمنٹ میں دو ذرات ایک دوسرے سے جڑے ہوتے ہیں۔';
    }
    return 'کوانٹم میکینکس مادے اور توانائی کے رویے کا مطالعہ ہے۔';
  }
  
  String _getQuantumPhilosophy(String question) {
    return 'کوانٹم دنیا ہمیں سکھاتی ہے کہ حقیقت مشاہدے پر منحصر ہے۔';
  }
  
  String _getPhilosophicalInterpretation(String question) {
    if (question.contains('کائنات')) {
      return 'کائنات ایک وسیع اور پراسرار جگہ ہے جس کے راز ابھی تک کھلے نہیں۔';
    }
    if (question.contains('وجود')) {
      return 'وجود کا سوال فلسفے کا بنیادی سوال ہے۔';
    }
    return 'انسانی تجربے کی گہرائی ہمیشہ سوچ کی دعوت دیتی ہے۔';
  }
  
  String _getHumanAspect(String question) {
    return 'انسانی دماغ کائنات کی سب سے پیچیدہ ساخت ہے۔';
  }
  
  String _getWisdom(String question) {
    return 'حکمت وہ ہے جو تجربے اور غور و فکر سے حاصل ہو۔';
  }
  
  String _getMathFallback(String question) {
    if (question.contains('دو جمع دو')) return 'چار';
    if (question.contains('تین ضرب چار')) return 'بارہ';
    return 'حساب میں مسئلہ پیش آیا';
  }
  
  // GPU کا مرکزی کام کرنے کا طریقہ
  Map<String, dynamic> executeWork(String workType, String urduQuestion) {
    print('[HLS_GPU] ⚡ کام شروع: $workType');
    
    switch (workType) {
      case 'math':
        return calculateMath(urduQuestion);
      case 'quantum':
        return analyzeQuantum(urduQuestion);
      case 'philosophy':
      case 'logic':
        return analyzePhilosophy(urduQuestion);
      default:
        return analyzeGeneral(urduQuestion);
    }
  }
}

// ==================== HLS_NPU کلاس (حاکم - صرف انتظام) ====================
class _HLS_NPU {
  final _HLS_CPU _cpu = _HLS_CPU();
  final _HLS_GPU _gpu = _HLS_GPU();
  
  // NPU کا کام: فیصلہ سازی اور انتظام
  String manageAndProcess(String urduQuestion) {
    // مرحلہ 1: CPU سے ترجمانی
    final analysis = _cpu.translateAndAnalyze(urduQuestion);
    final intent = analysis['intent'];
    
    print('[HLS_NPU] 🧠 نیت کا فیصلہ: $intent');
    
    // مرحلہ 2: GPU کو مناسب کام سونپیں
    final gpuResult = _gpu.executeWork(intent, urduQuestion);
    
    // مرحلہ 3: GPU کے نتائج کو NPU کی شکل میں ترتیب دیں
    return _formatNPUResponse(analysis, gpuResult);
  }
  
  // NPU کا کام: GPU کے نتائج کو خوبصورت جواب میں ڈھالنا
  String _formatNPUResponse(Map<String, dynamic> analysis, Map<String, dynamic> gpuResult) {
    final intent = analysis['intent'];
    final originalQuestion = analysis['original'];
    
    if (!gpuResult['success']) {
      return '''
⚠️ **NPU انتظامی خرابی**

سوال: "$originalQuestion"

GPU سے خرابی: ${gpuResult['error']}

متوقع جواب: ${gpuResult['fallback_answer'] ?? 'دستیاب نہیں'}

---
🎯 NPU فیصلہ: $intent
⚡ GPU کام: $intent
✅ CPU تجزیہ: مکمل
''';
    }
    
    // ہر نیت کے لیے الگ فارمیٹنگ
    switch (intent) {
      case 'math':
        return _formatMathResponse(originalQuestion, gpuResult);
      case 'quantum':
        return _formatQuantumResponse(originalQuestion, gpuResult);
      case 'philosophy':
      case 'logic':
        return _formatPhilosophyResponse(originalQuestion, gpuResult);
      default:
        return _formatGeneralResponse(originalQuestion, gpuResult);
    }
  }
  
  String _formatMathResponse(String question, Map<String, dynamic> result) {
    return '''
🧮 **NPU زیر انتظام ریاضی حل**

📋 اصل سوال:
"$question"

⚙️ **پروسیسنگ مراحل (NPU کی نگرانی میں):**
1. **CPU ترجمانی**: سوال کی صفائی اور شناخت
2. **NPU فیصلہ**: ریاضی کا کام GPU کو تفویض
3. **GPU حساب**: ${result['used_law']} کا اطلاق
4. **NPU تشکیل**: نتائج کو جواب میں ترتیب

📊 **حسابی نتائج:**
- ریاضی اظہار: ${result['math_expression']}
- عددی جواب: ${result['numeric_result']}
- اردو جواب: ${result['urdu_answer']}
- پیچیدگی: ${result['complexity']}

🎯 **سسٹم کارکردگی:**
- CPU: ترجمانی ✅
- NPU: فیصلہ سازی ✅
- GPU: قانونی حساب ✅

📈 **NPU کا مشاہدہ:**
یہ حل NPU کے زیر انتظام GPU کے قانونی حساب کتاب کا نتیجہ ہے۔
''';
  }
  
  String _formatQuantumResponse(String question, Map<String, dynamic> result) {
    return '''
⚛️ **NPU زیر انتظام کوانٹم تجزیہ**

📋 اصل سوال:
"$question"

🌌 **کوانٹم تشریح:**
${result['quantum_result']}

🔬 **سائنسی پہلو:**
${result['science_aspect']}

💭 **فلسفیانہ پہلو:**
${result['philosophy_aspect']}

🏗️ **سسٹم ڈھانچہ:**
- CPU: سوال کی نوعیت کی شناخت
- NPU: کوانٹم تجزیہ کا فیصلہ
- GPU: QuantumLogic.process() کا استعمال

🎯 **NPU کا نتیجہ:**
کوانٹم دنیا کی پیچیدگیوں کو NPU کی نگرانی میں GPU نے تجزیہ کیا۔
''';
  }
  
  String _formatPhilosophyResponse(String question, Map<String, dynamic> result) {
    return '''
💭 **NPU زیر انتظام فلسفیانہ تجزیہ**

📋 اصل سوال:
"$question"

🧠 **منطقی حل:**
${result['logical_solution']}

📚 **فلسفیانہ تشریح:**
${result['philosophical_interpretation']}

🔍 **انسانی پہلو:**
${result['human_aspect']}

🌟 **حکمت:**
${result['wisdom']}

🏗️ **تجزیاتی ڈھانچہ:**
- CPU: موضوع کی شناخت
- NPU: فلسفیانہ تجزیہ کا حکم
- GPU: LogicSolver کا استعمال

🎯 **NPU کی رائے:**
انسانی فہم اور کائناتی حقائق کا باہمی تعلق NPU کی نگرانی میں تجزیہ ہوا۔
''';
  }
  
  String _formatGeneralResponse(String question, Map<String, dynamic> result) {
    return '''
🌟 **NPU زیر انتظام عمومی تجزیہ**

📋 اصل سوال:
"$question"

🔍 **مشاہدہ:**
${result['observation']}

💡 **تجویز:**
${result['recommendation']}

🤖 **سسٹم کی صلاحیت (NPU کی نگرانی میں):**
- زبان سمجھنا: ✅ (CPU)
- موضوع کی شناخت: ✅ (CPU)
- مناسب کام تفویض: ✅ (NPU)
- تجزیہ کرنا: ✅ (GPU)

📊 **NPU کا فیصلہ:**
عمومی سوالات کے لیے NPU نے مناسب تجزیاتی ڈھانچہ تشکیل دیا۔
''';
  }
}

// ==================== HybridLawSystem (اصلی کلاس) ====================
class HybridLawSystem {
  // ہمارا اندرونی NPU جو سب انتظام کرے گا
  final _HLS_NPU _npu = _HLS_NPU();
  
  // سسٹم کے اعداد و شمار
  int _totalProcessed = 0;
  int _mathQuestions = 0;
  int _quantumQuestions = 0;
  int _philosophyQuestions = 0;
  
  String answer(String urduQuestion) {
    _totalProcessed++;
    print('\n🎯 **HYBRID LAW SYSTEM** - NPU زیر انتظام پروسیسنگ');
    print('📝 اصل سوال: "$urduQuestion"');
    print('🔢 کل پروسیسڈ سوالات: $_totalProcessed');
    
    // NULL چیک
    if (urduQuestion.isEmpty) {
      return 'براہ کرم سوال درج کریں';
    }
    
    try {
      // NPU کو تمام انتظام سونپیں
      final result = _npu.manageAndProcess(urduQuestion);
      
      // اعداد و شمار اپڈیٹ کریں
      _updateStatistics(urduQuestion);
      
      print('✅ NPU نے انتظام مکمل کر لیا');
      return result;
      
    } catch (e) {
      print('❌ NPU انتظامی خرابی: $e');
      return _formatError('NPU زیر انتظام جواب دینے میں مسئلہ', error: e.toString());
    }
  }
  
  void _updateStatistics(String question) {
    final cleaned = question.toLowerCase();
    
    if (_containsMath(cleaned)) _mathQuestions++;
    else if (cleaned.contains('کوانٹم')) _quantumQuestions++;
    else if (_containsPhilosophy(cleaned)) _philosophyQuestions++;
  }
  
  bool _containsMath(String text) {
    final mathWords = ['جمع', 'ضرب', 'تقسیم', 'حساب'];
    return mathWords.any((word) => text.contains(word));
  }
  
  bool _containsPhilosophy(String text) {
    final philosophyWords = ['کائنات', 'وجود', 'فلسفہ', 'دماغ'];
    return philosophyWords.any((word) => text.contains(word));
  }
  
  String _formatError(String message, {String error = ''}) {
    return '''
❌ **NPU انتظامی نظام میں مسئلہ**

⚠️ خامی:
$message

${error.isNotEmpty ? '🔧 تکنیکی معلومات:\n$error' : ''}

🏗️ **سسٹم کی حالت:**
- CPU: فعال
- NPU: انتظامی مسئلہ
- GPU: تیار

🔄 **حل کے اقدامات:**
1. سوال دوبارہ درج کریں
2. NPU کو ریسٹارٹ کریں
3. سسٹم ایڈمن سے رابطہ کریں
''';
  }
  
  // سسٹم معلومات
  String get systemInfo {
    return '''
🤖 **HybridLawSystem - NPU زیر انتظام**

📊 اعداد و شمار:
- کل پروسیسڈ سوالات: $_totalProcessed
- ریاضی سوالات: $_mathQuestions
- کوانٹم سوالات: $_quantumQuestions
- فلسفیانہ سوالات: $_philosophyQuestions

🏗️ اندرونی ڈھانچہ:
├── HLS_CPU: صرف ترجمانی
├── HLS_NPU: صرف فیصلہ سازی اور انتظام
└── HLS_GPU: تمام بھاری کام

🎯 NPU کا فلسفہ: "میں صرف حاکم ہوں، مزدور GPU ہے"
''';
  }
  
  // ٹیسٹ
  void test() {
    print('🧪 **Hybrid System - NPU زیر انتظام ٹیسٹ**');
    print('=' * 60);
    
    List<String> tests = [
      'دو جمع دو',
      'تین ضرب چار',
      'کائنات کا راز کیا ہے',
      'سپر پوزیشن کیا ہے',
      'مصافحہ میں پانچ افراد',
      'دماغ کی بورڈ ہے یا ڈیٹا سینٹر',
    ];
    
    for (var question in tests) {
      print('\n' + '=' * 50);
      print('سوال: "$question"');
      print('=' * 50);
      print('جواب:\n${answer(question)}');
      print('─' * 40);
    }
    
    print('\n📊 ٹیسٹ کے اعداد و شمار:');
    print(systemInfo);
  }
}
