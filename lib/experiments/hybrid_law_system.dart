// تمام اہم فائلوں کا امپورٹ
import 'language_to_math.dart';
import 'cpu_translator.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';
import 'logic_solver.dart';
import 'enhanced_language_to_math.dart';
import 'advanced_math_laws.dart';
import 'quantum_logic.dart';

class HybridLawSystem {
  // ماڈیولز
  final LanguageToMathConverter languageToMath = LanguageToMathConverter();
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();
  final CPUTranslator cpu = CPUTranslator(); // 🔑 اصل دماغ

  String answer(String urduQuestion) {
    print('\n🧠 CPU نے سوال وصول کیا: "$urduQuestion"');

    try {
      // 1️⃣ CPU فیصلہ کرے: سوال کی نوعیت کیا ہے؟
      final intent = cpu.detectIntent(urduQuestion);
      print('🔍 CPU فیصلہ: $intent');

      // 2️⃣ اگر پہیلی / فلسفہ / عمومی سوال
      if (intent == CPUIntent.puzzle) {
        final puzzle = LogicSolver.solvePuzzle(urduQuestion);
        if (!puzzle.containsKey('error')) {
          return puzzle['solution'];
        }
      }

      // 3️⃣ اگر کوانٹم سوال ہے → NPU / Bohr logic
      if (intent == CPUIntent.quantum) {
        final quantumResult = QuantumLogic.process(urduQuestion);
        if (quantumResult != null && quantumResult.isNotEmpty) {
          return quantumResult;
        }
      }

      // 4️⃣ اگر ریاضی ہے → GPU / Einstein logic
      if (intent == CPUIntent.math) {
        final mathExpression =
            EnhancedLanguageToMath.convertAdvanced(urduQuestion);

        final mathResult = gpuCalculator.calculate(mathExpression);

        // ⚠️ اگر نتیجہ null یا خالی ہو تو سوال واپس مت دو
        if (mathResult == null) {
          return '❌ حساب مکمل نہیں ہو سکا';
        }

        return mathToLanguage.convert(mathResult, urduQuestion);
      }

      // 5️⃣ fallback (اگر CPU کنفیوز ہو)
      return '🤔 سوال سمجھ میں نہیں آیا، دوبارہ پوچھیں';

    } catch (e) {
      return '❌ نظام میں خرابی: $e';
    }
  }

  // ٹیسٹنگ
  void test() {
    print('🧪 Hybrid System Test شروع');

    print(answer('دو جمع دو'));
    print(answer('پانچ لاکھ ضرب دو'));
    print(answer('کائنات کا راز کیا ہے'));
    print(answer('سپر پوزیشن کیا ہے'));
  }
}
