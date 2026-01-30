import '../experiments/hybrid_law_system.dart';
import 'dart:math';

// ==================== CPU (مترجم - سب سے ہلکا) ====================
class _CPU {
  // CPU کا کام: صرف صفائی اور بنیادی پارسنگ
  Map<String, dynamic> translate(String userInput) {
    return {
      'original': userInput,
      'cleaned': userInput.trim().toLowerCase(),
      'length': userInput.length,
      'word_count': userInput.split(' ').length,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'language': _detectLanguage(userInput),
    };
  }
  
  String _detectLanguage(String text) {
    final urduRegex = RegExp(r'[\u0600-\u06FF]');
    return urduRegex.hasMatch(text) ? 'urdu' : 'english';
  }
}

// ==================== GPU (مزدور - تمام بھاری کام) ====================
class _GPU {
  final HybridLawSystem _hybridSystem = HybridLawSystem();
  final Map<String, List<Law>> _lawDatabase = _createLawDatabase();
  
  // GPU کا کام 1: ریاضی کا حساب
  String _calculateMath(Map<String, dynamic> instruction) {
    final operation = instruction['operation'] ?? '';
    final a = instruction['operand1'] ?? 0;
    final b = instruction['operand2'] ?? 0;
    
    switch (operation) {
      case 'add': return (a + b).toString();
      case 'multiply': return (a * b).toString();
      case 'divide': return b != 0 ? (a / b).toString() : 'تقسیم صفر سے ممکن نہیں';
      default: return '0';
    }
  }
  
  // GPU کا کام 2: قوانین کا ڈیٹابیس
  static Map<String, List<Law>> _createLawDatabase() {
    return {
      'physics': [
        Law(
          id: 'newton_1',
          name: 'نیوٹن کا پہلا قانون حرکت',
          formula: 'ΣF = 0 ↔ dv/dt = 0',
          description: 'سکون کی حالت برقرار رہتی ہے جب تک بیرونی قوت نہ لگے',
          explanation: '''یہ قانون جڑت (inertia) کا تصور پیش کرتا ہے۔ کوئی جسم جو ساکن ہے وہ ساکن رہے گا، اور جو حرکت میں ہے وہ یکساں سمتار سے حرکت میں رہے گا، جب تک کہ اس پر کوئی بیرونی غیر متوازن قوت نہ لگے۔

مثالیں:
1. کار کے اچانک رکنے پر آگے جھٹکا لگنا
2. ہوا میں پھینکا گیا گیند بتدریج رکنا (ہوا کی رگڑ کی وجہ سے)''',
        ),
        Law(
          id: 'newton_2',
          name: 'نیوٹن کا دوسرا قانون حرکت',
          formula: 'F = m × a',
          description: 'قوت کمیت اور اسراع کے حاصل ضرب کے برابر ہوتی ہے',
          explanation: '''یہ قانون قوت، کمیت اور اسراع کے باہمی تعلق کو بیان کرتا ہے۔

فارمولا: F = m × a
جہاں:
F = قوت (نیوٹن)
m = کمیت (کلوگرام)
a = اسراع (میٹر/سیکنڈ²)

مثالیں:
1. بھاری ٹرک کو ہلانے کے لیے زیادہ قوت درکار
2. ہلکی فریزبی آسانی سے اڑائی جا سکتی ہے''',
        ),
        Law(
          id: 'newton_3',
          name: 'نیوٹن کا تیسرا قانون حرکت',
          formula: 'F₁₂ = -F₂₁',
          description: 'ہر عمل کا برابر اور مخالف رد عمل ہوتا ہے',
          explanation: '''جب ایک جسم دوسرے جسم پر قوت لگاتا ہے، تو دوسرا جسم پہلے جسم پر اسی قدر لیکن مخالف سمت میں قوت لگاتا ہے۔

مثالیں:
1. راکٹ کا اڑنا (گیسوں کو نیچے دھکیلتا ہے، راکٹ اوپر جاتا ہے)
2. تیراکی (ہاتھ پانی کو پیچھے دھکیلتے ہیں، جسم آگے بڑھتا ہے)''',
        ),
      ],
      'math': [
        Law(
          id: 'pythagoras',
          name: 'مسئلۂ فیثاغورث',
          formula: 'a² + b² = c²',
          description: 'قائمہ زاویہ مثلث میں وتر کا مربع دوسرے دو اطراف کے مربعوں کے مجموعے کے برابر',
          explanation: '''یہ ہندسہ کا بنیادی قانون ہے جو مثلثات میں استعمال ہوتا ہے۔

فارمولا: c = √(a² + b²)
جہاں:
c = وتر (سب سے لمبا رخ)
a, b = دوسرے دو رخ

مثالیں:
1. سیڑھی کی لمبائی معلوم کرنا
2. نقشے پر دو نقطوں کے درمیان فاصلہ''',
        ),
      ],
      'quantum': [
        Law(
          id: 'superposition',
          name: 'سپرپوزیشن کا اصول',
          formula: '|ψ⟩ = α|0⟩ + β|1⟩',
          description: 'کوانٹم سسٹم ایک وقت میں کئی حالات میں ہو سکتا ہے',
          explanation: '''روایتی بٹ (0 یا 1) کے برعکس، کوانٹم بٹ (qubit) ایک وقت میں دونوں حالات میں ہو سکتا ہے۔

مشہور مثال: شروڈنگر کی بلی
بلی ایک ہی وقت میں زندہ اور مردہ ہو سکتی ہے جب تک ڈبہ نہ کھولا جائے۔

یہ اصول کوانٹم کمپیوٹنگ کی بنیاد ہے۔''',
        ),
      ],
    };
  }
  
  // GPU کا کام 3: Hybrid System کو استعمال کرنا
  String _processWithHybrid(String question) {
    return _hybridSystem.answer(question);
  }
  
  // GPU کا کام 4: منطق حل کرنا
  String _solveLogic(String question) {
    // LogicSolver وغیرہ استعمال کرے
    if (question.contains('مصافحہ')) {
      return 'n افراد کے درمیان مصافحوں کی تعداد: n(n-1)/2';
    }
    return 'منطقی حل دستیاب نہیں';
  }
  
  // GPU کا مرکزی فنکشن: NPU سے حکم پاکر کام کرنا
  String executeWork(Map<String, dynamic> command) {
    final workType = command['work_type'] ?? '';
    
    switch (workType) {
      case 'calculate_math':
        return _calculateMath(command['data']);
      case 'explain_law':
        return _explainLaw(command['data']);
      case 'process_hybrid':
        return _processWithHybrid(command['question']);
      case 'solve_logic':
        return _solveLogic(command['question']);
      case 'search_knowledge':
        return _searchInDatabase(command['query']);
      default:
        return 'کام کی قسم نامعلوم';
    }
  }
  
  String _explainLaw(Map<String, dynamic> data) {
    final category = data['category'] ?? '';
    final lawId = data['law_id'] ?? '';
    
    final laws = _lawDatabase[category];
    if (laws != null) {
      final law = laws.firstWhere((l) => l.id == lawId, orElse: () => Law.empty());
      if (law.id.isNotEmpty) {
        return '''
📖 **${law.name}**
📐 فارمولا: ${law.formula}
📝 تفصیل: ${law.description}

🧠 **مکمل وضاحت:**
${law.explanation}

✅ **حقیقی دنیا کی مثالیں شامل ہیں**''';
      }
    }
    return 'قانون کی وضاحت دستیاب نہیں';
  }
  
  String _searchInDatabase(String query) {
    // GPU کی ڈیٹابیس میں تلاش
    for (var category in _lawDatabase.keys) {
      for (var law in _lawDatabase[category]!) {
        if (law.name.contains(query) || law.description.contains(query)) {
          return _explainLaw({'category': category, 'law_id': law.id});
        }
      }
    }
    return 'تلاش کا نتیجہ نہیں ملا';
  }
}

// قانون کی کلاس
class Law {
  final String id;
  final String name;
  final String formula;
  final String description;
  final String explanation;
  
  Law({
    required this.id,
    required this.name,
    required this.formula,
    required this.description,
    required this.explanation,
  });
  
  factory Law.empty() => Law(
    id: '',
    name: '',
    formula: '',
    description: '',
    explanation: '',
  );
}

// ==================== NPU (حاکم - صرف انتظام) ====================
class _NPU {
  final _CPU _cpu = _CPU();
  final _GPU _gpu = _GPU();
  
  // NPU کا کام 1: فیصلہ کرنا کہ کیا کرنا ہے
  Map<String, dynamic> _makeDecision(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    
    // NPU صرف فیصلہ کرتا ہے - حساب نہیں کرتا
    if (text.contains('نیوٹن') || text.contains('قوت') || text.contains('حرکت')) {
      return {
        'decision': 'explain_law',
        'work_type': 'explain_law',
        'data': {'category': 'physics', 'law_id': 'newton_2'},
        'reason': 'صارف طبیعیات کا قانون پوچھ رہا ہے',
      };
    }
    else if (text.contains('دو جمع دو') || text.contains('تین ضرب چار')) {
      return {
        'decision': 'calculate_math',
        'work_type': 'calculate_math',
        'data': _extractMathData(text),
        'reason': 'صارف ریاضی کا حساب چاہتا ہے',
      };
    }
    else if (text.contains('سپر') || text.contains('کوانٹم')) {
      return {
        'decision': 'process_hybrid',
        'work_type': 'process_hybrid',
        'question': parsedInput['original'],
        'reason': 'صارف کوانٹم موضوع پوچھ رہا ہے',
      };
    }
    else if (text.contains('مصافحہ') || text.contains('افراد')) {
      return {
        'decision': 'solve_logic',
        'work_type': 'solve_logic',
        'question': parsedInput['original'],
        'reason': 'صارف منطقی مسئلہ حل کرنا چاہتا ہے',
      };
    }
    
    return {
      'decision': 'search_knowledge',
      'work_type': 'search_knowledge',
      'query': text,
      'reason': 'عام معلومات کی تلاش',
    };
  }
  
  Map<String, dynamic> _extractMathData(String text) {
    if (text.contains('دو جمع دو')) {
      return {'operation': 'add', 'operand1': 2, 'operand2': 2};
    } else if (text.contains('تین ضرب چار')) {
      return {'operation': 'multiply', 'operand1': 3, 'operand2': 4};
    }
    return {'operation': 'add', 'operand1': 0, 'operand2': 0};
  }
  
  // NPU کا کام 2: GPU کو حکم دینا
  String _giveCommandToGPU(Map<String, dynamic> decision) {
    print('[NPU حکم] GPU کو کام سونپا جا رہا ہے: ${decision['work_type']}');
    print('[NPU وجہ] ${decision['reason']}');
    
    // GPU کو حکم (تمام بھاری کام GPU کرے گا)
    final gpuResult = _gpu.executeWork(decision);
    
    return gpuResult;
  }
  
  // NPU کا کام 3: حتمی جواب کو ترتیب دینا
  String _formatFinalResponse(String gpuResult, Map<String, dynamic> decision) {
    return '''
🧠 **NPU فیصلہ:** ${decision['reason']}
⚡ **GPU کام:** ${decision['work_type']}

📋 **نتیجہ:**
$gpuResult

---
🤖 **سسٹم کا خلاصہ:**
NPU: فیصلہ سازی ✅
CPU: ترجمانی ✅  
GPU: بھاری کام ✅
''';
  }
  
  // NPU کا مرکزی فنکشن: صرف انتظام کرنا
  String manageProcess(String userInput) {
    // مرحلہ 1: CPU سے صفائی (سب سے ہلکا کام)
    final parsedInput = _cpu.translate(userInput);
    
    // مرحلہ 2: NPU فیصلہ سازی (دماغ کا کام)
    final decision = _makeDecision(parsedInput);
    
    // مرحلہ 3: GPU کو حکم (تمام بھاری کام)
    final gpuResult = _giveCommandToGPU(decision);
    
    // مرحلہ 4: NPU حتمی جواب ترتیب دے
    return _formatFinalResponse(gpuResult, decision);
  }
}

// ==================== QuantumMasterController ====================
class QuantumMasterController {
  final _NPU _npu = _NPU();
  int _totalQuestions = 0;
  
  String ask(String question) {
    _totalQuestions++;
    
    print('\n🚀 **Quantum Master - نیا سوال #$_totalQuestions**');
    print('📥 CPU: ان پٹ کی صفائی کی جا رہی ہے...');
    
    // NPU کو تمام انتظام سونپ دو
    final response = _npu.manageProcess(question);
    
    print('✅ NPU: کام مکمل، GPU نے تمام بھاری کام کیا');
    print('📤 جواب تیار ہے\n');
    
    return response;
  }
  
  String get systemInfo {
    return '''
🤖 **سسٹم کی تقسیم کار:**
├── CPU (مترجم): صرف صفائی اور پارسنگ
├── NPU (حاکم): صرف فیصلہ سازی اور انتظام
└── GPU (مزدور): تمام بھاری کام (حساب، ڈیٹابیس، منطق)

📊 کارکردگی: $_totalQuestions سوالات پروسیس
''';
  }
}
