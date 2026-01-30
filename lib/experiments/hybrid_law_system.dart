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

// ==================== NPU میں قانونی علم کی توسیع ====================
class _NPU {
  // ... موجودہ کوڈ ...
  
  // Step 1: موجودہ ماڈیولز کو امپورٹ/انضمام
  final AdvancedMathLaws _advancedMath = AdvancedMathLaws();
  final LogicSolver _logicSolver = LogicSolver();
  final QuantumLogic _quantumLogic = QuantumLogic();
  final CPUTranslator _cpuTranslator = CPUTranslator();
  final CPUIntentDetector _intentDetector = CPUIntentDetector();
  
  // Step 2: NPU کے علم کے ذخیرے میں اضافہ
  final Map<String, dynamic> _expandedKnowledgeBase = {
    'advanced_math': {
      'description': 'اعلیٰ ریاضی قوانین کا مجموعہ',
      'source': 'advanced_math_laws.dart',
      'capabilities': [
        'حسابان (Calculus)',
        'الجبرا (Algebra)',
        'ہندسہ (Geometry)',
        'تخمینہ (Statistics)',
      ],
      'processor': '_advancedMath', // ریفرنس
    },
    'quantum_physics': {
      'description': 'کوانٹم میکینکس کے اصول',
      'source': 'quantum_logic.dart',
      'capabilities': [
        'سپرپوزیشن',
        'اینٹینگلمنٹ',
        'کوانٹم منطق',
        'شروڈنگر مساوات',
      ],
      'processor': '_quantumLogic',
    },
    'logic_puzzles': {
      'description': 'منطقی مسائل حل کرنے کا نظام',
      'source': 'logic_solver.dart',
      'capabilities': [
        'پہیلیاں حل کرنا',
        'منطقی تجزیہ',
        'مسائل کی درجہ بندی',
        'حل کے مراحل',
      ],
      'processor': '_logicSolver',
    },
    'language_processing': {
      'description': 'زبان کی بہتر سمجھ',
      'source': 'cpu_intent.dart + cpu_translator.dart',
      'capabilities': [
        'نیت کی شناخت',
        'سیاق و سباق سمجھنا',
        'اردو/انگریزی پروسیسنگ',
        'سوال کی نوعیت',
      ],
      'processor': '_cpuTranslator',
    },
  };
  
  // Step 3: NPU کے فیصلہ سازی میں اضافہ
  Map<String, dynamic> _makeInformedDecision(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    
    // زیادہ ذہین فیصلہ - موجودہ ماڈیولز کی صلاحیتوں کو دیکھتے ہوئے
    if (_shouldUseAdvancedMath(text)) {
      return {
        'decision': 'advanced_math_processing',
        'work_type': 'advanced_math',
        'data': {
          'question': parsedInput['original'],
          'complexity': 'high',
          'recommended_module': 'AdvancedMathLaws',
        },
        'reason': 'NPU نے اعلیٰ ریاضی کا فیصلہ کیا',
        'confidence': _calculateConfidence(text, 'math'),
      };
    }
    
    if (_shouldUseQuantumLogic(text)) {
      return {
        'decision': 'quantum_analysis',
        'work_type': 'quantum_processing',
        'data': {
          'question': parsedInput['original'],
          'depth': 'quantum',
          'recommended_module': 'QuantumLogic',
        },
        'reason': 'NPU نے کوانٹم تجزیہ کا فیصلہ کیا',
        'confidence': _calculateConfidence(text, 'quantum'),
      };
    }
    
    if (_shouldUseLogicSolver(text)) {
      return {
        'decision': 'logic_solution',
        'work_type': 'logic_processing',
        'data': {
          'question': parsedInput['original'],
          'type': 'puzzle',
          'recommended_module': 'LogicSolver',
        },
        'reason': 'NPU نے منطقی حل کا فیصلہ کیا',
        'confidence': _calculateConfidence(text, 'logic'),
      };
    }
    
    // ڈیفالٹ
    return {
      'decision': 'general_processing',
      'work_type': 'basic_processing',
      'reason': 'NPU نے عمومی پروسیسنگ کا فیصلہ کیا',
      'confidence': 0.5,
    };
  }
  
  // Step 4: اعلیٰ ماڈیولز استعمال کرنے کی شرائط
  bool _shouldUseAdvancedMath(String text) {
    final advancedMathKeywords = [
      'مشتق', 'تکامل', 'حد', 'سلسلہ', 'مصفوفہ', 
      'احصاء', 'احتمال', 'تفاضل', 'تکامل'
    ];
    
    // صرف بنیادی ریاضی نہ ہو
    final hasBasicMath = text.contains('جمع') || text.contains('ضرب');
    final hasAdvancedMath = advancedMathKeywords.any((word) => text.contains(word));
    
    return hasAdvancedMath || (text.length > 20 && hasBasicMath);
  }
  
  bool _shouldUseQuantumLogic(String text) {
    final quantumKeywords = [
      'کوانٹم', 'سپر', 'اینٹینگلمنٹ', 'شروڈنگر',
      'طول موج', 'کوانٹم بٹ', 'qubit', 'superposition'
    ];
    return quantumKeywords.any((word) => text.contains(word));
  }
  
  bool _shouldUseLogicSolver(String text) {
    final logicKeywords = [
      'مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'منطق',
      'پہیلی', 'معمہ', 'ترکیب', 'احتمال', 'puzzle'
    ];
    return logicKeywords.any((word) => text.contains(word));
  }
  
  double _calculateConfidence(String text, String category) {
    // AI-based confidence calculation
    int keywordMatches = 0;
    
    switch (category) {
      case 'math':
        final mathWords = ['جمع', 'ضرب', 'تقسیم', 'ریاضی', 'حساب'];
        keywordMatches = mathWords.where((word) => text.contains(word)).length;
        break;
      case 'quantum':
        final quantumWords = ['کوانٹم', 'سپر', 'شروڈنگر'];
        keywordMatches = quantumWords.where((word) => text.contains(word)).length;
        break;
      case 'logic':
        final logicWords = ['مصافحہ', 'افراد', 'منطق'];
        keywordMatches = logicWords.where((word) => text.contains(word)).length;
        break;
    }
    
    return (keywordMatches / 5).clamp(0.0, 1.0);
  }
  
  // Step 5: GPU کو بہتر حکم
  String _giveCommandToGPU(Map<String, dynamic> decision) {
    final workType = decision['work_type'];
    final data = decision['data'];
    
    print('[NPU فیصلہ] ${decision['reason']}');
    print('[NPU اعتماد] ${(decision['confidence'] * 100).toStringAsFixed(1)}%');
    
    // مختلف ماڈیولز کے مطابق مختلف کام
    switch (workType) {
      case 'advanced_math':
        // AdvancedMathLaws استعمال کریں
        final advancedResult = _advancedMath.process(data['question']);
        return '''
🎓 **اعلیٰ ریاضی تجزیہ (NPU + AdvancedMathLaws)**
سوال: ${data['question']}
ماڈیول: ${data['recommended_module']}
اعتماد: ${(decision['confidence'] * 100).toStringAsFixed(1)}%

نتیجہ:
$advancedResult

📚 اضافی معلومات:
یہ تجزیہ advanced_math_laws.dart ماڈیول کا استعمال کرتے ہوئے کیا گیا۔''';
        
      case 'quantum_processing':
        // QuantumLogic استعمال کریں
        final quantumResult = _quantumLogic.process(data['question']);
        return '''
⚛️ **کوانٹم تجزیہ (NPU + QuantumLogic)**
سوال: ${data['question']}
ماڈیول: ${data['recommended_module']}
اعتماد: ${(decision['confidence'] * 100).toStringAsFixed(1)}%

نتیجہ:
$quantumResult

🔬 کوانٹم بنیاد:
quantum_logic.dart ماڈیول سے اخذ کردہ''';
        
      case 'logic_processing':
        // LogicSolver استعمال کریں
        final logicResult = _logicSolver.solvePuzzle(data['question']);
        return '''
🧩 **منطقی حل (NPU + LogicSolver)**
مسئلہ: ${data['question']}
ماڈیول: ${data['recommended_module']}
اعتماد: ${(decision['confidence'] * 100).toStringAsFixed(1)}%

حل:
${logicResult['solution'] ?? 'حل دستیاب نہیں'}

مراحل:
${logicResult['steps'] ?? 'مراحل دستیاب نہیں'}

🧠 منطقی تجزیہ:
logic_solver.dart کے اصولوں پر مبنی''';
        
      default:
        // عمومی GPU کام
        return _gpu.executeWork(decision);
    }
  }
  
  // NPU کا بہتر انتظام
  String manageWithModules(String userInput) {
    // 1. بہتر CPU پروسیسنگ (cpu_translator.dart سے)
    final parsedInput = _cpuTranslator.translate(userInput);
    
    // 2. بہتر نیت شناخت (cpu_intent.dart سے)
    final intent = _intentDetector.detect(userInput);
    parsedInput['detected_intent'] = intent;
    
    // 3. ذہین فیصلہ (تمام ماڈیولز کو دیکھتے ہوئے)
    final decision = _makeInformedDecision(parsedInput);
    
    // 4. مناسب ماڈیول کو کام سونپیں
    final result = _giveCommandToGPU(decision);
    
    // 5. حتمی جواب
    return _formatIntegratedResponse(result, decision, parsedInput);
  }
  
  String _formatIntegratedResponse(String result, Map<String, dynamic> decision, Map<String, dynamic> parsedInput) {
    return '''
🌐 **انضمام شدہ NPU سسٹم**
${'-' * 40}

🔍 **سوال کا تجزیہ:**
سوال: ${parsedInput['original']}
نیت: ${parsedInput['detected_intent']}
الفاظ: ${parsedInput['word_count']}

🤖 **NPU فیصلہ:**
فیصلہ: ${decision['decision']}
وجہ: ${decision['reason']}
اعتماد: ${(decision['confidence'] * 100).toStringAsFixed(1)}%
ماڈیول: ${decision['data']?['recommended_module'] ?? 'بنیادی GPU'}

⚡ **نتیجہ:**
$result

📊 **استعمال شدہ وسائل:**
${_getUsedModules(decision)}

🏆 **سسٹم کی طاقت:**
آپ کے NPU نے ${_expandedKnowledgeBase.length} مختلف قانونی ماڈیولز کو 
ایک ساتھ مربوط کر کے یہ جواب تیار کیا ہے۔
''';
  }
  
  String _getUsedModules(Map<String, dynamic> decision) {
    final modules = <String>[];
    
    if (decision['data']?['recommended_module'] != null) {
      modules.add(decision['data']!['recommended_module']);
    }
    
    // CPU ماڈیولز
    modules.addAll(['CPUTranslator', 'CPUIntentDetector']);
    
    return modules.map((m) => '• $m').join('\n');
  }
}
    
