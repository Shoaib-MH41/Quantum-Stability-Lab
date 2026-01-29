import 'language_to_math.dart';
import 'law_based_gpu.dart';
import 'math_to_language.dart';

class HybridLawSystem {
  // تینوں ماڈیولز
  final LanguageToMathConverter languageToMath = LanguageToMathConverter();
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();
  
  // اردو سوال کا جواب دیں
  String answer(String urduQuestion) {
    print('\n🎯 نیا سوال: "$urduQuestion"');
    print('─' * 50);
    
    // مرحلہ 1: اردو → حساب
    print('📝 مرحلہ 1: زبان سمجھنا (NPU)');
    final mathExpression = languageToMath.convert(urduQuestion);
    
    // مرحلہ 2: حساب کریں (GPU)
    print('\n⚡ مرحلہ 2: حساب کرنا (GPU)');
    final mathResult = gpuCalculator.calculate(mathExpression);
    
    // مرحلہ 3: حساب → اردو جواب
    print('\n🔤 مرحلہ 3: جواب بنانا (NPU)');
    final urduAnswer = mathToLanguage.convert(mathResult, urduQuestion);
    
    print('\n✅ مکمل جواب: $urduAnswer');
    print('─' * 50);
    
    return urduAnswer;
  }
  
  // ٹیسٹ تمام سوالات
  void runAllTests() {
    print('🧪 ہائبرڈ قانونی نظام - مکمل ٹیسٹ');
    print('=' * 50);
    
    final tests = [
      'دو جمع دو کیا ہے',
      'تین ضرب چار کتنے',
      'دس تفریق پانچ ہے',
      'آٹھ تقسیم دو ہے',
      'پانچ جمع تین کیا ہے',
    ];
    
    for (var question in tests) {
      answer(question);
    }
  }
}
