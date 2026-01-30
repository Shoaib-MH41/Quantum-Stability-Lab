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


/// ============================================================= /// HybridLawSystem /// CPU = مترجم (صفائی + زبان) /// NPU = حاکم دماغ (فیصلہ + تشریح + حتمی جواب) /// GPU = مزدور (صرف حساب / طاقت) /// ============================================================= class HybridLawSystem { // -------------------- Modules -------------------- final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator(); // مزدور final MathToLanguageConverter mathToLanguage = MathToLanguageConverter(); final LanguageToMathConverter languageToMath = LanguageToMathConverter();

// -------------------- Statistics -------------------- int _totalProcessed = 0; int _mathQuestions = 0; int _quantumQuestions = 0; int _philosophyQuestions = 0;

// ================================================== // Entry Point // ================================================== String answer(String urduQuestion) { _totalProcessed++;

if (urduQuestion.isEmpty) {
  return _formatError('براہ کرم سوال درج کریں');
}

print('\n🎯 HYBRID LAW SYSTEM (Coordinator)');
print('📝 سوال: "$urduQuestion"');

try {
  // ---------------- CPU : Translator ----------------
  final cpuPacket = CpuTranslator.cleanAndNormalize(urduQuestion);
  print('🧠 CPU → صاف سوال: ${cpuPacket.cleaned}');

  // ---------------- NPU : Ruler Brain ----------------
  final npuDecision = QuantumLogic.decide(cpuPacket.cleaned);
  print('👑 NPU → فیصلہ: ${npuDecision.intent}');

  _updateStatistics(npuDecision.intent);

  // ---------------- Execute by NPU order ----------------
  switch (npuDecision.intent) {
    case 'math':
      _mathQuestions++;
      return _npuHandleMath(urduQuestion, npuDecision);

    case 'quantum':
      _quantumQuestions++;
      return _npuHandleQuantum(urduQuestion);

    case 'philosophy':
    case 'logic':
      _philosophyQuestions++;
      return _npuHandlePhilosophy(urduQuestion);

    default:
      return _handleGeneral(urduQuestion);
  }
} catch (e) {
  return _formatError('سسٹم ایرر', error: e.toString());
}

}

// ================================================== // NPU controlled handlers // ==================================================

String _npuHandleMath(String urduQuestion, NpuDecision decision) { try { // CPU already translated → now math extraction final mathExpression = languageToMath.convert(urduQuestion);

// ---------------- GPU : Worker ----------------
  final mathResult = gpuCalculator.calculate(mathExpression);

  // ---------------- NPU : Judge ----------------
  final judgement = QuantumLogic.judge(
    question: urduQuestion,
    expression: mathExpression,
    result: mathResult,
    law: _getMathLaw(mathExpression),
  );

  return '''

🧠 حاکم دماغ (NPU) کا فیصلہ

📋 سوال: $urduQuestion

⚙️ مزدور GPU کا نتیجہ: $mathResult

📐 استعمال شدہ قانون: ${judgement.law}

🧾 حتمی جواب: ${judgement.finalAnswer}

💡 تشریح: ${judgement.explanation}

🎯 حکمت: ${judgement.philosophy} '''; } catch (e) { return _formatMathDefault(urduQuestion, e.toString()); } }

String _npuHandleQuantum(String urduQuestion) { final judgement = QuantumLogic.explainQuantum(urduQuestion);

return '''

⚛️ کوانٹم فیصلہ (NPU)

📋 سوال: $urduQuestion

🌌 تشریح: ${judgement.explanation}

🧠 فلسفہ: ${judgement.philosophy} '''; }

String _npuHandlePhilosophy(String urduQuestion) { final judgement = QuantumLogic.philosophicalJudge(urduQuestion);

return '''

💭 فلسفیانہ فیصلہ (NPU)

📋 سوال: $urduQuestion

🧠 نتیجہ: ${judgement.finalAnswer}

🌟 حکمت: ${judgement.philosophy} '''; }

// ================================================== // General / fallback // ==================================================

String _handleGeneral(String urduQuestion) { return ''' 🌟 عمومی جواب

📋 سوال: $urduQuestion

👑 NPU کا مشورہ: براہ کرم سوال کو مزید واضح کریں۔

📊 اعداد و شمار: کل سوالات: $_totalProcessed ریاضی: $_mathQuestions کوانٹم: $_quantumQuestions فلسفہ: $_philosophyQuestions '''; }

// ================================================== // Helpers // ==================================================

void _updateStatistics(String intent) {}

String _getMathLaw(String expression) { if (expression.contains('+')) return 'جمع کا قانون'; if (expression.contains('*')) return 'ضرب کا قانون'; if (expression.contains('/')) return 'تقسیم کا قانون'; if (expression.contains('-')) return 'تفریق کا قانون'; return 'بنیادی ریاضی قانون'; }

String _formatError(String message, {String error = ''}) { return ''' ❌ مسئلہ $message ${error.isNotEmpty ? error : ''} '''; }

String _formatMathDefault(String question, String error) { return ''' 🧮 سادہ جواب سوال: $question خرابی: $error '''; } }
