import 'advanced_math_laws.dart';
import 'logic_solver.dart';
import 'enhanced_language_to_math.dart';

class SuperHybridSystem {
  final EnhancedLanguageToMath languageConverter = EnhancedLanguageToMath();
  final LogicSolver logicSolver = LogicSolver();
  
  String answerSuperQuestion(String urduQuestion) {
    print('\n🚀 سپر کمپیوٹر ٹیسٹ: "$urduQuestion"');
    
    // 1. منطقی مسئلہ کی شناخت
    if (_isLogicProblem(urduQuestion)) {
      return _solveLogicProblem(urduQuestion);
    }
    
    // 2. ریاضیاتی مسئلہ
    if (_isMathProblem(urduQuestion)) {
      return _solveMathProblem(urduQuestion);
    }
    
    // 3. عام مسئلہ
    return HybridLawSystem().answer(urduQuestion);
  }
  
  bool _isLogicProblem(String question) {
    final keywords = ['مصافحہ', 'زاویہ', 'آبادی', 'پہیلی', 'مسئلہ'];
    return keywords.any((word) => question.contains(word));
  }
  
  bool _isMathProblem(String question) {
    final keywords = ['فبونیکی', 'پرائم', 'سیریز', 'مربع', 'جذر'];
    return keywords.any((word) => question.contains(word));
  }
  
  String _solveLogicProblem(String question) {
    final solution = logicSolver.solvePuzzle(question);
    
    if (solution.containsKey('error')) {
      return '❌ یہ منطقی مسئلہ ابھی حل نہیں کر سکتا';
    }
    
    return '''
✅ منطقی حل:
مسئلہ: ${solution['problem']}
حل: ${solution['solution']}
وضاحت: ${solution['explanation']}
''';
  }
  
  String _solveMathProblem(String question) {
    final expression = languageConverter.convertAdvanced(question);
    
    if (expression.contains('fib')) {
      // فبونیکی سیریز
      final n = _extractNumber(question);
      final result = AdvancedMathLaws.laws['fibonacci_series']!(n);
      return 'فبونیکی سیریز کا $n وا عدد: $result';
    }
    
    if (expression.contains('prime')) {
      // پرائم نمبر
      final n = _extractNumber(question);
      final isPrime = AdvancedMathLaws.laws['is_prime']!(n);
      return '$n ${isPrime ? 'پرائم نمبر ہے' : 'پرائم نمبر نہیں ہے'}';
    }
    
    return '❌ یہ ریاضیاتی مسئلہ ابھی حل نہیں کر سکتا';
  }
  
  int _extractNumber(String text) {
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(text);
    return match != null ? int.parse(match.group(1)!) : 0;
  }
  
  // ٹیسٹ تمام سپر سوالات
  void runSuperTests() {
    print('🧪 سپر کمپیوٹر ٹیسٹس');
    print('=' * 50);
    
    final superQuestions = [
      'ایک کمرے میں ہر شخص ہر دوسرے شخص سے مصافحہ کرے اور کل ۴۵ مصافحے ہوں تو کمرے میں کتنے افراد ہیں؟',
      'اگر ایک شہر کی آبادی دس لاکھ ہے اور ہر سال ۵ فیصد بڑھتی ہے تو تین سال بعد آبادی کیا ہوگی؟',
      'پہلے دس فبونیکی اعداد کا مجموعہ کیا ہے؟',
      'کیا ۹۷ پرائم نمبر ہے؟',
      'پہلے بیس قدرتی اعداد کے مربعوں کا مجموعہ کیا ہے؟',
      'گیارہ بجے پچیس منٹ پر گھڑی کے دونوں سوئیوں کے درمیان زاویہ کیا ہے؟',
      'تین کوانٹم بٹس میں کتنے ممکنہ حالت ہیں؟',
    ];
    
    for (var question in superQuestions) {
      print('\nسوال: $question');
      print('─' * 50);
      print(answerSuperQuestion(question));
      print('─' * 50);
    }
  }
}
