// lib/experiments/hybrid_law_system.dart

import 'language_to_math.dart';
import 'cpu_translator.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';
import 'logic_solver.dart';
import 'enhanced_language_to_math.dart';
import 'advanced_math_laws.dart';
import 'quantum_logic.dart';

class HybridLawSystem {
  // -------------------- ماڈیولز --------------------

  final CPUTranslator cpu = CPUTranslator();
  final LawBasedGPUCalculator gpu = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();

  // -------------------- مرکزی جواب --------------------

  String answer(String urduQuestion) {
    print('\n🎯 Hybrid Processing Start: "$urduQuestion"');

    try {
      // 1️⃣ پہلے منطقی / فلسفیانہ پہیلی؟
      final logic = LogicSolver.solvePuzzle(urduQuestion);
      if (!logic.containsKey('error')) {
        return _formatLogicResponse(logic);
      }

      // 2️⃣ کوانٹم سوال؟
      if (_isQuantumQuestion(urduQuestion)) {
        final q = QuantumLogic.solveQuantumProblem(urduQuestion);
        return _formatQuantumResponse(q);
      }

      // 3️⃣ ریاضیاتی سوال → Language → Math
      final mathExpression =
          EnhancedLanguageToMath.convertAdvanced(urduQuestion);

      if (mathExpression == null || mathExpression.toString().isEmpty) {
        return '❓ سوال واضح نہیں، مزید وضاحت کریں۔';
      }

      // 4️⃣ GPU (Einstein) حساب
      final mathResult = gpu.calculate(mathExpression);

      // 5️⃣ CPU → اردو + معنی
      return cpu.translateToUrdu(mathResult);

    } catch (e) {
      return '❌ نظام میں رکاوٹ: $e';
    }
  }

  // -------------------- Helper Methods --------------------

  bool _isQuantumQuestion(String q) {
    return q.contains('کوانٹم') ||
        q.contains('سپر پوزیشن') ||
        q.contains('اینٹینگلمنٹ') ||
        q.contains('کوانٹم بٹ') ||
        q.contains('حالت');
  }

  String _formatLogicResponse(Map<String, dynamic> logic) {
    final buffer = StringBuffer();

    if (logic.containsKey('solution')) {
      buffer.writeln('🧠 منطقی جواب:');
      buffer.writeln(logic['solution']);
    }

    if (logic.containsKey('explanation')) {
      buffer.writeln('\n📘 وضاحت:');
      buffer.writeln(logic['explanation']);
    }

    if (logic.containsKey('npu_status')) {
      buffer.writeln('\n⚙️ نظام: ${logic['npu_status']}');
    }

    return buffer.toString().trim();
  }

  String _formatQuantumResponse(Map<String, dynamic> q) {
    final buffer = StringBuffer('⚛️ کوانٹم جواب:\n');

    if (q.containsKey('solution')) {
      buffer.writeln(q['solution']);
    }

    if (q.containsKey('explanation')) {
      buffer.writeln('\n📘 وضاحت:');
      buffer.writeln(q['explanation']);
    }

    return buffer.toString().trim();
  }

  // -------------------- ٹیسٹ --------------------

  void test() {
    print('🧪 Hybrid System Tests:\n');

    print(answer('دو جمع دو'));
    print('----------------');

    print(answer('تین کوانٹم بٹس میں کتنی حالتیں ہیں'));
    print('----------------');

    print(answer('کائنات کا راز کیا ہے'));
    print('----------------');

    print(answer('پانچ لاکھ ضرب دو'));
  }
}
