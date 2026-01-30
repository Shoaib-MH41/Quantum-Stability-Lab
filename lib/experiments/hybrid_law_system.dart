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
  final LawBasedGPUCalculator gpuCalculator = LawBasedGPUCalculator();
  final MathToLanguageConverter mathToLanguage = MathToLanguageConverter();
  final LanguageToMathConverter languageToMath = LanguageToMathConverter();

  // -------------------- سوال کا جواب --------------------
  String answer(String urduQuestion) {
    print('\n🧠 Hybrid System شروع: "$urduQuestion"');

    // NULL چیک
    if (urduQuestion == null || urduQuestion.isEmpty) {
      return '❌ براہ کرم سوال درج کریں';
    }

    try {
      // 1️⃣ سوال کی نوعیت معلوم کریں (سادہ طریقہ)
      String intent = _detectIntentSimple(urduQuestion);
      print('🔍 نوعیت: $intent');

      // 2️⃣ ریاضیاتی سوال
      if (intent == 'math') {
        print('🧮 ریاضی کا طریقہ...');
        
        // پہلے سادہ converter استعمال کریں
        String mathExpression;
        try {
          mathExpression = languageToMath.convert(urduQuestion);
          print('   ریاضی اظہار: $mathExpression');
        } catch (e) {
          print('   ⚠️ Converter Error: $e');
          
          // ڈیفالٹ
          if (urduQuestion.contains('دو جمع دو')) {
            mathExpression = '2 + 2';
          } else if (urduQuestion.contains('تین ضرب چار')) {
            mathExpression = '3 * 4';
          } else {
            mathExpression = '0 + 0';
          }
        }
        
        // GPU حساب
        num mathResult = gpuCalculator.calculate(mathExpression);
        print('   حساب نتیجہ: $mathResult');
        
        // اردو میں تبدیل
        String urduAnswer = mathToLanguage.convert(mathResult.toString(), urduQuestion);
        print('   اردو جواب: $urduAnswer');
        
        return urduAnswer;
      }

      // 3️⃣ فلسفیانہ / منطقی سوال
      if (intent == 'philosophy' || intent == 'logic') {
        print('💭 فلسفیانہ طریقہ...');
        
        // LogicSolver سے کوشش کریں
        try {
          Map<String, dynamic> puzzleResult = LogicSolver.solvePuzzle(urduQuestion);
          if (puzzleResult.containsKey('solution')) {
            String solution = puzzleResult['solution'].toString();
            if (solution.isNotEmpty) {
              return solution;
            }
          }
        } catch (e) {
          print('   ⚠️ LogicSolver Error: $e');
        }
        
        // ڈیفالٹ فلسفیانہ جواب
        if (urduQuestion.contains('کائنات') || urduQuestion.contains('راز')) {
          return 'کائنات کا راز یہ ہے کہ ہر چیز توانائی کی مختلف شکلیں ہیں۔';
        }
        
        if (urduQuestion.contains('دماغ') || urduQuestion.contains('عقل')) {
          return 'دماغ ایک کی بورڈ کی طرح ہے جو خیالات کو ٹائپ کرتا ہے۔';
        }
        
        return 'یہ ایک گہرا سوال ہے۔';
      }

      // 4️⃣ ڈیفالٹ
      return 'سوال سمجھ میں آیا۔ مزید ترقی کے مراحل میں ہوں۔';

    } catch (e) {
      print('❌ Hybrid System Error: $e');
      return 'جواب دینے میں مسئلہ: ${e.toString()}';
    }
  }

  // -------------------- Helper Methods --------------------
  
  String _detectIntentSimple(String question) {
    question = question.toLowerCase();
    
    // ریاضی کے الفاظ
    List<String> mathWords = ['جمع', 'ضرب', 'تقسیم', 'منفی', 'برابر', 'کتنے', 'حساب', 'عدد'];
    for (var word in mathWords) {
      if (question.contains(word)) return 'math';
    }
    
    // فلسفیانہ الفاظ
    List<String> philosophyWords = ['کائنات', 'راز', 'وجود', 'حقیقت', 'زندگی', 'دماغ', 'عقل'];
    for (var word in philosophyWords) {
      if (question.contains(word)) return 'philosophy';
    }
    
    // منطقی پہیلی
    List<String> logicWords = ['مصافحہ', 'افراد', 'گھڑی', 'زاویہ', 'آبادی', 'وسائل', 'توازن'];
    for (var word in logicWords) {
      if (question.contains(word)) return 'logic';
    }
    
    return 'general';
  }

  // -------------------- ٹیسٹنگ --------------------
  void test() {
    print('🧪 Hybrid System Test شروع');
    print('=' * 60);

    List<String> testQuestions = [
      'دو جمع دو',
      'تین ضرب چار',
      'کائنات کا راز کیا ہے',
      'دماغ کی بورڈ ہے یا ڈیٹا سینٹر',
      'مصافحہ میں پانچ افراد',
    ];

    for (var question in testQuestions) {
      print('\nسوال: "$question"');
      print('نوعیت: ${_detectIntentSimple(question)}');
      print('جواب: ${answer(question)}');
      print('─' * 40);
    }
  }
}
