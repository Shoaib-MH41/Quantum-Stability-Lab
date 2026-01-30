
import 'dart:math';
import 'cpu_translator.dart';
import 'cpu_intent.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';
import 'logic_solver.dart';
import 'enhanced_language_to_math.dart';
import 'advanced_math_laws.dart';
import 'quantum_logic.dart';

class HybridLawSystem {
  // -------------------- ماڈیولز --------------------
  final CPUTranslator cpu = CPUTranslator();
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();

  // -------------------- سوال کا جواب --------------------
  String answer(String urduQuestion) {
    print('\n🧠 CPU نے سوال وصول کیا: "$urduQuestion"');

    try {
      // 1️⃣ سوال کی نوعیت معلوم کریں
      final intent = cpu.detectIntent(urduQuestion);
      print('🔍 CPU فیصلہ: $intent');

      // 2️⃣ پہیلی / فلسفیانہ سوال
      if (intent == CPUIntent.puzzle) {
        final puzzle = LogicSolver.solvePuzzle(urduQuestion);
        if (!puzzle.containsKey('error')) {
          return puzzle['solution'];
        }
      }

      // 3️⃣ کوانٹم سوال → NPU logic
      if (intent == CPUIntent.quantum) {
        final quantumResult = QuantumLogic.process(urduQuestion);
        return quantumResult;
      }

      // 4️⃣ ریاضیاتی سوال → GPU logic
      if (intent == CPUIntent.math) {
        final mathExpression = EnhancedLanguageToMath.convertAdvanced(urduQuestion);
        final mathResult = gpuCalculator.calculate(mathExpression);

        if (mathResult == null) return '❌ حساب مکمل نہیں ہو سکا';

        return mathToLanguage.convert(mathResult, urduQuestion);
      }

      // 5️⃣ fallback
      return '🤔 سوال سمجھ میں نہیں آیا، دوبارہ پوچھیں';

    } catch (e) {
      return '❌ نظام میں خرابی: $e';
    }
  }

  // -------------------- ٹیسٹنگ --------------------
  void test() {
    print('🧪 Hybrid System Test شروع');

    print(answer('دو جمع دو')); // math
    print(answer('پانچ لاکھ ضرب دو')); // math
    print(answer('کائنات کا راز کیا ہے')); // puzzle / logic
    print(answer('سپر پوزیشن کیا ہے')); // quantum
    print(answer('اینٹینگلمنٹ کی وضاحت کریں')); // quantum
    print(answer('شروڈنگر کی بلی کیا ہے؟')); // quantum
    print(answer('مصافحہ میں پانچ افراد')); // puzzle / logic
  }
}
