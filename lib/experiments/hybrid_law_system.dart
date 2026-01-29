// تمام اہم فائلوں کا امپورٹ
import 'language_to_math.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';
import 'logic_solver.dart'; // پہیلیوں کے لیے
import 'enhanced_language_to_math.dart'; // بڑے اعداد کے لیے
import 'advanced_math_laws.dart'; // گہرے قوانین کے لیے
import 'quantum_logic.dart'; // کوانٹم حساب کے لیے

class HybridLawSystem {
  // تمام ماڈیولز کے ابجیکٹس بنائیں
  final LanguageToMathConverter languageToMath = LanguageToMathConverter();
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();
  
  String answer(String urduQuestion) {
    print('\n🎯 کوانٹم پروسیسنگ شروع: "$urduQuestion"');
    
    try {
      // 1. پہلے چیک کریں کہ کیا یہ کوئی کائناتی پہیلی ہے؟
      final puzzleResponse = LogicSolver.solvePuzzle(urduQuestion);
      if (!puzzleResponse.containsKey('error')) {
        return puzzleResponse['solution']; // اگر LogicSolver کے پاس جواب ہے تو وہیں سے دے دے
      }

      // 2. اگر پہیلی نہیں ہے، تو بڑے اعداد کا قانون استعمال کریں (Enhanced L2M)
      final mathExpression = EnhancedLanguageToMath.convertAdvanced(urduQuestion);
      
      // 3. GPU/NPU پر قانون لاگو کریں
      final mathResult = gpuCalculator.calculate(mathExpression);
      
      // 4. نتیجے کو واپس اردو میں بدلیں
      return mathToLanguage.convert(mathResult, urduQuestion);

    } catch (e) {
      return '❌ نظام میں قانونی رکاوٹ: $e';
    }
  }

  void test() {
    print('🧪 مکمل نظام کا ٹیسٹ:');
    print(answer('کائنات کا راز کیا ہے')); // LogicSolver ٹیسٹ
    print(answer('پانچ لاکھ ضرب دو')); // Enhanced Math ٹیسٹ
    print(answer('دو جمع دو')); // Basic Math ٹیسٹ
  }
}
