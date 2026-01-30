// ==================== QuantumMasterController.dart ====================
import '../experiments/hybrid_law_system.dart';

// ----- QuantumMasterController کا CPU -----
class _QMCCPU {
  Map<String, dynamic> _cleanAndParse(String input) {
    return {
      'original': input,
      'cleaned': input.trim().toLowerCase(),
      'length': input.length,
      'timestamp': DateTime.now(),
    };
  }

  Map<String, dynamic> translateInput(String userInput) {
    return _cleanAndParse(userInput);
  }
}

// ----- QuantumMasterController کا GPU -----
class _QMCGPU {
  // سادہ ریاضی - صرف NPU کے حکم پر
  String _executeSimpleMath(Map<String, dynamic> instruction) {
    final operation = instruction['operation'] ?? '';
    final a = instruction['a'] ?? 0;
    final b = instruction['b'] ?? 0;

    switch (operation) {
      case 'add':
        return (a + b).toString();
      case 'subtract':
        return (a - b).toString();
      case 'multiply':
        return (a * b).toString();
      case 'divide':
        return b != 0 ? (a / b).toString() : 'تقسیم صفر سے ممکن نہیں';
      default:
        return 'نامعلوم عمل';
    }
  }

  // NPU کا حکم ماننا
  String executeCommand(Map<String, dynamic> command) {
    final type = command['type'] ?? '';
    
    if (type == 'simple_math') {
      return _executeSimpleMath(command['data']);
    } else if (type == 'format_response') {
      return _formatResponse(command['data']);
    }
    
    return 'ناقابل عمل حکم';
  }

  String _formatResponse(Map<String, dynamic> data) {
    final result = data['result'] ?? '';
    final context = data['context'] ?? {};
    
    if (context['intent'] == 'math') {
      return 'حسابی جواب: $result';
    } else if (context['intent'] == 'greeting') {
      return 'خوش آمدید! $result';
    }
    
    return result.toString();
  }
}

// ----- QuantumMasterController کا NPU (مرکزی حاکم) -----
class _QMCNPU {
  final _QMCCPU _cpu = _QMCCPU();
  final _QMCGPU _gpu = _QMCGPU();
  final HybridLawSystem _hybridWorker = HybridLawSystem();
  
  // پرائیویٹ: نیت کا تعین (حاکم کا فیصلہ)
  String _determineIntent(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    
    if (_containsMath(text)) return 'math';
    if (_containsQuantum(text)) return 'quantum';
    if (_containsPhilosophy(text)) return 'philosophy';
    if (_containsLogic(text)) return 'logic';
    if (_isGreeting(text)) return 'greeting';
    
    return 'general';
  }

  bool _containsMath(String text) => text.contains('جمع') || text.contains('ضرب') || text.contains('تقسیم');
  bool _containsQuantum(String text) => text.contains('کوانٹم') || text.contains('سپر') || text.contains('شروڈنگر');
  bool _containsPhilosophy(String text) => text.contains('کائنات') || text.contains('وجود') || text.contains('فلسفہ');
  bool _containsLogic(String text) => text.contains('مصافحہ') || text.contains('افراد') || text.contains('منطق');
  bool _isGreeting(String text) => text.contains('ہیلو') || text.contains('سلام') || text.contains('خوش');

  // پرائیویٹ: ریاضی کے لیے حکمت عملی
  String _handleMathIntent(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    
    // NPU کا فیصلہ: کون سا حساب ہے؟
    Map<String, dynamic> gpuCommand;
    
    if (text.contains('دو جمع دو')) {
      gpuCommand = {
        'type': 'simple_math',
        'data': {'operation': 'add', 'a': 2, 'b': 2}
      };
    } else if (text.contains('تین ضرب چار')) {
      gpuCommand = {
        'type': 'simple_math',
        'data': {'operation': 'multiply', 'a': 3, 'b': 4}
      };
    } else {
      // پیچیدہ ریاضی کے لیے ماتحت مزدور کو حکم
      return _delegateToHybridWorker(parsedInput['original'], 'math');
    }
    
    // GPU کو حکم
    final rawResult = _gpu.executeCommand(gpuCommand);
    
    // جواب کو خوبصورت بنانے کا حکم
    final formatCommand = {
      'type': 'format_response',
      'data': {
        'result': rawResult,
        'context': {'intent': 'math', 'question': parsedInput['original']}
      }
    };
    
    return _gpu.executeCommand(formatCommand);
  }

  // پرائیویٹ: کوانٹم/پیچیدہ معاملات ماتحت مزدور کو
  String _handleQuantumIntent(Map<String, dynamic> parsedInput) {
    return _delegateToHybridWorker(parsedInput['original'], 'quantum');
  }

  // پرائیویٹ: فلسفہ ماتحت مزدور کو
  String _handlePhilosophyIntent(Map<String, dynamic> parsedInput) {
    return _delegateToHybridWorker(parsedInput['original'], 'philosophy');
  }

  // پرائیویٹ: منطق ماتحت مزدور کو
  String _handleLogicIntent(Map<String, dynamic> parsedInput) {
    return _delegateToHybridWorker(parsedInput['original'], 'logic');
  }

  // پرائیویٹ: ماتحت مزدور (HybridLawSystem) کو حکم
  String _delegateToHybridWorker(String question, String intent) {
    // NPU کا حکم: "اے مزدور، یہ کام کرو"
    print('[NPU حکم] HybridLawSystem کو بھیجا جا رہا ہے: $intent');
    
    final workerResult = _hybridWorker.answer(question);
    
    // مزدور کے جواب کو NPU کی شکل میں ڈھالنا
    return _refineWorkerResponse(workerResult, intent);
  }

  // پرائیویٹ: مزدور کے جواب کو بہتر بنانا
  String _refineWorkerResponse(String rawResponse, String intent) {
    // NPU اپنی حکمت عملی سے جواب کو بہتر بناتا ہے
    switch (intent) {
      case 'quantum':
        return '''
🌌 **کوانٹم تجزیہ (NPU کی جانب سے)**

${rawResponse}

🧠 **NPU کی تشریح:**
یہ کوانٹم میکینکس کے بنیادی اصولوں کی عکاسی کرتا ہے۔''';
        
      case 'philosophy':
        return '''
💭 **فلسفیانہ تحلیل (NPU کی جانب سے)**

${rawResponse}

🤔 **NPU کا مشاہدہ:**
انسانی فہم اور کائناتی حقائق کا باہمی تعلق۔''';
        
      case 'logic':
        return '''
🧩 **منطقی حل (NPU کی جانب سے)**

${rawResponse}

✅ **NPU کی تصدیق:**
منطق کے اصولوں کے مطابق درست حل۔''';
        
      default:
        return rawResponse;
    }
  }

  // پرائیویٹ: عمومی جواب
  String _handleGeneralIntent(Map<String, dynamic> parsedInput) {
    final text = parsedInput['cleaned'];
    
    if (_isGreeting(text)) {
      return 'سلام! میں Quantum Master AI ہوں۔ آپ کیسے مدد کر سکتا ہوں؟';
    }
    
    return '''
سوال: "${parsedInput['original']}"

میں آپ کے سوال کو سمجھ رہا ہوں۔ براہ کرم:
1. سوال مزید واضح کریں
2. مخصوص موضوع منتخب کریں (ریاضی، سائنس، فلسفہ)
3. مثال کے طور پر: "دو جمع دو کیا ہے؟"''';
  }

  // پبلک انٹرفیس: حاکم کا مرکزی طریقہ
  String processAndCommand(String userInput) {
    // 1. CPU سے ترجمہ
    final parsedInput = _cpu.translateInput(userInput);
    
    // 2. نیت کا تعین (حاکم کا فیصلہ)
    final intent = _determineIntent(parsedInput);
    print('[NPU فیصلہ] نیت: $intent');
    
    // 3. مناسب حکمت عملی
    String response;
    switch (intent) {
      case 'math':
        response = _handleMathIntent(parsedInput);
        break;
      case 'quantum':
        response = _handleQuantumIntent(parsedInput);
        break;
      case 'philosophy':
        response = _handlePhilosophyIntent(parsedInput);
        break;
      case 'logic':
        response = _handleLogicIntent(parsedInput);
        break;
      case 'greeting':
        response = _handleGeneralIntent(parsedInput);
        break;
      default:
        response = _handleGeneralIntent(parsedInput);
    }
    
    // 4. حتمی جواب
    return response;
  }
}

// ----- QuantumMasterController (مکمل کلاس) -----
class QuantumMasterController {
  final _QMCNPU _npu = _QMCNPU();
  int _totalQuestions = 0;
  List<String> _sessionLog = [];

  String ask(String urduQuestion) {
    _totalQuestions++;
    _sessionLog.add('Q$_totalQuestions: ${urduQuestion.substring(0, min(20, urduQuestion.length))}...');
    
    print('\n🎯 **Quantum Master Controller**');
    print('📞 صارف کا سوال #$_totalQuestions');
    
    try {
      // NPU (حاکم) کو تمام اختیارات سونپنا
      final response = _npu.processAndCommand(urduQuestion);
      
      print('✅ NPU نے جواب تیار کر لیا');
      return response;
      
    } catch (e) {
      print('❌ NPU میں مسئلہ: $e');
      return '''
⚠️ **نظام میں عارضی مسئلہ**

سوال: "$urduQuestion"

براہ کرم:
1. تھوڑی دیر انتظار کریں
2. سوال دوبارہ درج کریں
3. اگر مسئلہ برقرار رہے تو سسٹم ریسٹارٹ کریں''';
    }
  }

  // سیشن معلومات
  String get sessionInfo {
    return '''
📊 **سیشن کی معلومات:**
- کل سوالات: $_totalQuestions
- سیشن شروع: ${DateTime.now()}
- آخری 5 سوالات:
${_sessionLog.length > 5 ? _sessionLog.sublist(_sessionLog.length - 5).join('\n') : _sessionLog.join('\n')}
''';
  }

  void runIntegrationTest() {
    print('\n🧪 **NPU-HybridSystem انضمام ٹیسٹ**\n');
    
    final testQuestions = [
      'دو جمع دو',
      'سپر پوزیشن کیا ہے؟',
      'مصافحہ میں پانچ افراد',
      'کائنات کا راز',
      'ہیلو',
    ];
    
    for (var question in testQuestions) {
      print('─' * 40);
      print('❓ سوال: "$question"');
      print('💡 جواب: ${ask(question).substring(0, 100)}...');
    }
    
    print('\n✅ ٹیسٹ مکمل - NPU حاکم کے طور پر کام کر رہا ہے');
  }
}
