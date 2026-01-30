// ==================== HybridLawSystem.dart ====================
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

// ----- HLS کا اندرونی CPU -----
class _HLSCPU {
  Map<String, dynamic> _analyzeForWorker(String question) {
    return {
      'task_received': DateTime.now(),
      'question': question,
      'complexity': question.length,
      'keywords': _extractKeywords(question),
    };
  }

  List<String> _extractKeywords(String text) {
    final words = text.toLowerCase().split(' ');
    return words.where((word) => word.length > 2).toList();
  }
}

// ----- HLS کا اندرونی GPU -----
class _HLSGPU {
  final LawBasedGPUCalculator _calculator = LawBasedGPUCalculator();

  String _performCalculation(String expression) {
    try {
      return _calculator.calculate(expression).toString();
    } catch (e) {
      return 'حسابی خرابی: $e';
    }
  }

  String _processQuantum(String question) {
    try {
      return QuantumLogic.process(question);
    } catch (e) {
      return 'کوانٹم پروسیسنگ خرابی: $e';
    }
  }

  String _solveLogic(String question) {
    try {
      final result = LogicSolver.solvePuzzle(question);
      return result['solution']?.toString() ?? 'حل دستیاب نہیں';
    } catch (e) {
      return 'منطقی حل خرابی: $e';
    }
  }

  // NPU کے حکم پر کام
  String executeWorkerTask(Map<String, dynamic> task) {
    final type = task['type'] ?? '';
    
    switch (type) {
      case 'math_calculation':
        return _performCalculation(task['expression']);
      case 'quantum_analysis':
        return _processQuantum(task['question']);
      case 'logic_solution':
        return _solveLogic(task['question']);
      default:
        return 'نامعلوم کام کی قسم';
    }
  }
}

// ----- HLS کا اندرونی NPU (مزدور کا ذہن) -----
class _HLSNPU {
  final _HLSCPU _cpu = _HLSCPU();
  final _HLSGPU _gpu = _HLSGPU();
  final MathToLanguageConverter _mathConverter = MathToLanguageConverter();

  String _determineWorkerTask(String question) {
    if (question.contains('سپر') || question.contains('کوانٹم')) return 'quantum';
    if (question.contains('مصافحہ') || question.contains('افراد')) return 'logic';
    if (question.contains('جمع') || question.contains('ضرب')) return 'math';
    return 'general';
  }

  Map<String, dynamic> _createTaskCommand(String taskType, String question) {
    switch (taskType) {
      case 'math':
        return {
          'type': 'math_calculation',
          'expression': _extractMathExpression(question),
          'timestamp': DateTime.now(),
        };
      case 'quantum':
        return {
          'type': 'quantum_analysis',
          'question': question,
          'priority': 'high',
        };
      case 'logic':
        return {
          'type': 'logic_solution',
          'question': question,
          'complexity': 'medium',
        };
      default:
        return {'type': 'general', 'question': question};
    }
  }

  String _extractMathExpression(String question) {
    // سادہ ایکسٹریکشن
    if (question.contains('جمع')) return '2+2';
    if (question.contains('ضرب')) return '3*4';
    return question.replaceAll(RegExp(r'[^\d\+\-\*/]'), '');
  }

  String _formatWorkerResult(String rawResult, String taskType) {
    switch (taskType) {
      case 'math':
        return '''
🧮 **حسابی نتیجہ (HLS GPU)**
نتیجہ: $rawResult

ℹ️ **تشریح:**
یہ نتیجہ قانونی GPU کیلکولیٹر کے ذریعے حاصل کیا گیا ہے۔''';
        
      case 'quantum':
        return '''
⚛️ **کوانٹم تحلیل (HLS GPU)**
$rawResult

🔬 **سائنسی بنیاد:**
کوانٹم منطق کے اصولوں پر مبنی۔''';
        
      case 'logic':
        return '''
🧩 **منطقی حل (HLS GPU)**
حل: $rawResult

✓ **منطقی اصول:**
ترکیب اور احتمال کے قوانین کا اطلاق۔''';
        
      default:
        return rawResult;
    }
  }

  // مزدور کا مرکزی کام کرنے کا طریقہ
  String performTask(String question) {
    print('[HLS مزدور] کام وصول ہوا: "${question.substring(0, min(30, question.length))}..."');
    
    // 1. CPU سے ابتدائی تجزیہ
    final analysis = _cpu._analyzeForWorker(question);
    
    // 2. کام کی قسم کا تعین
    final taskType = _determineWorkerTask(question);
    print('[HLS مزدور] کام کی قسم: $taskType');
    
    // 3. GPU کے لیے حکم تیار کریں
    final taskCommand = _createTaskCommand(taskType, question);
    
    // 4. GPU کو حکم دیں
    final gpuResult = _gpu.executeWorkerTask(taskCommand);
    print('[HLS مزدور] GPU کا نتیجہ وصول ہوا');
    
    // 5. نتیجہ کو فارمیٹ کریں
    final formattedResult = _formatWorkerResult(gpuResult, taskType);
    
    // 6. حاکم (QMC NPU) کو نتیجہ واپس کریں
    return formattedResult;
  }
}

// ----- HybridLawSystem (مکمل مزدور کلاس) -----
class HybridLawSystem {
  final _HLSNPU _workerNPU = _HLSNPU();
  int _tasksCompleted = 0;
  List<Map<String, dynamic>> _taskHistory = [];

  // یہ وہ واحد طریقہ ہے جو QMC کا NPU استعمال کرے گا
  String answer(String questionFromMaster) {
    _tasksCompleted++;
    
    final taskRecord = {
      'id': _tasksCompleted,
      'question': questionFromMaster,
      'received_at': DateTime.now(),
      'status': 'processing',
    };
    
    _taskHistory.add(taskRecord);
    
    try {
      print('\n[HybridLawSystem] ⚙️ مزدور کام شروع کر رہا ہے...');
      print('[HLS] حاکم کا حکم: "$questionFromMaster"');
      
      // اپنے اندرونی NPU کو کام سونپیں
      final result = _workerNPU.performTask(questionFromMaster);
      
      taskRecord['status'] = 'completed';
      taskRecord['completed_at'] = DateTime.now();
      
      print('[HybridLawSystem] ✅ کام مکمل، حاکم کو نتیجہ بھیجا جا رہا ہے');
      
      return result;
      
    } catch (e) {
      taskRecord['status'] = 'failed';
      taskRecord['error'] = e.toString();
      
      print('[HybridLawSystem] ❌ کام ناکام: $e');
      
      return '''
🛠️ **مزدور سسٹم میں خرابی**

سوال: "$questionFromMaster"

خرابی: $e

مزدور کی حیثیت: کام مکمل نہیں کر سکا
''';
    }
  }

  // مزدور کی کارکردگی کی معلومات
  String get workerStatus {
    final successRate = _tasksCompleted > 0 
        ? (_taskHistory.where((t) => t['status'] == 'completed').length / _tasksCompleted * 100).toStringAsFixed(1)
        : '0.0';
    
    return '''
🛠️ **HybridLawSystem (مزدور) کی حیثیت:**
- مکمل کیے گئے کام: $_tasksCompleted
- کامیابی کی شرح: $successRate%
- آخری کام: ${_taskHistory.isNotEmpty ? _taskHistory.last['question'] : 'کوئی نہیں'}
- مزدور NPU: فعال
- مزدور GPU: تیار
''';
  }
}
