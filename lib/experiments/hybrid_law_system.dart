import 'language_to_math.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';

class HybridLawSystem {
  // تینوں ماڈیولز
  final LanguageToMathConverter languageToMath = LanguageToMathConverter();
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();
  
  // ✅ answer method شامل کریں:
  String answer(String urduQuestion) {
    print('\n🎯 نیا سوال: "$urduQuestion"');
    
    try {
      // مرحلہ 1: اردو → حساب
      final mathExpression = languageToMath.convert(urduQuestion);
      
      // مرحلہ 2: حساب کریں
      final mathResult = gpuCalculator.calculate(mathExpression);
      
      // مرحلہ 3: حساب → اردو جواب
      final urduAnswer = mathToLanguage.convert(mathResult, urduQuestion);
      
      return urduAnswer;
    } catch (e) {
      return '❌ حساب میں مسئلہ: $e';
    }
  }
  
  // اضافی: ٹیسٹ method
  void test() {
    print('🧪 Hybrid Law System Test:');
    print(answer('دو جمع دو کیا ہے'));
    print(answer('تین ضرب چار کتنے'));
    print(answer('دس تفریق پانچ ہے'));
  }
}
