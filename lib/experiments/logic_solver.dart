class LogicSolver {
  // منطقی پہیلیاں حل کرنے والا
  
  static Map<String, dynamic> solvePuzzle(String puzzle) {
    if (puzzle.contains('مصافحہ') && puzzle.contains('افراد')) {
      return _solveHandshake(puzzle);
    }
    
    if (puzzle.contains('گھڑی') && puzzle.contains('زاویہ')) {
      return _solveClockAngle(puzzle);
    }
    
    if (puzzle.contains('آبادی') && puzzle.contains('بڑھتی')) {
      return _solvePopulation(puzzle);
    }
    
    return {'error': 'اس قسم کا مسئلہ ابھی حل نہیں کر سکتا'};
  }
  
  static Map<String, dynamic> _solveHandshake(String puzzle) {
    // "۴۵ مصافحے" سے عدد نکالیں
    final regex = RegExp(r'(\d+)\s*مصافحے');
    final match = regex.firstMatch(puzzle);
    
    if (match != null) {
      final handshakes = int.parse(match.group(1)!);
      final n = AdvancedMathLaws.laws['handshake_problem']!(handshakes);
      
      return {
        'type': 'handshake',
        'problem': puzzle,
        'solution': '$n افراد',
        'explanation': 'اگر $n افراد ہوں تو مصافحوں کی تعداد n(n-1)/2 = $handshakes ہوگی',
      };
    }
    
    return {'error': 'اعداد نہیں ملے'};
  }
  
  static Map<String, dynamic> _solveClockAngle(String puzzle) {
    // وقت نکالیں
    final timeRegex = RegExp(r'(\d+)\s*بجے\s*(\d+)');
    final match = timeRegex.firstMatch(puzzle);
    
    if (match != null) {
      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final angle = AdvancedMathLaws.laws['clock_angle']!(hour, minute);
      
      return {
        'type': 'clock_angle',
        'problem': puzzle,
        'solution': '$angle ڈگری',
        'explanation': '$hour بج کر $minute منٹ پر گھڑی کے سوئیوں کے درمیان زاویہ',
      };
    }
    
    return {'error': 'وقت نہیں ملا'};
  }
  
  static Map<String, dynamic> _solvePopulation(String puzzle) {
    // آبادی اور شرح نکالیں
    final populationRegex = RegExp(r'(\d+)\s*لاکھ');
    final rateRegex = RegExp(r'(\d+)\s*فیصد');
    final yearsRegex = RegExp(r'(\d+)\s*سال');
    
    final populationMatch = populationRegex.firstMatch(puzzle);
    final rateMatch = rateRegex.firstMatch(puzzle);
    final yearsMatch = yearsRegex.firstMatch(puzzle);
    
    if (populationMatch != null && rateMatch != null && yearsMatch != null) {
      final population = int.parse(populationMatch.group(1)!) * 100000;
      final rate = int.parse(rateMatch.group(1)!);
      final years = int.parse(yearsMatch.group(1)!);
      
      final futurePopulation = AdvancedMathLaws.laws['population_growth']!(
        population.toDouble(), 
        rate.toDouble(), 
        years
      );
      
      return {
        'type': 'population_growth',
        'problem': puzzle,
        'solution': '${futurePopulation.toInt()} افراد',
        'explanation': 'آبادی میں اضافہ کا فارمولا: P = P₀(1 + r)ⁿ',
      };
    }
    
    return {'error': 'مکمل معلومات نہیں ملی'};
  }
}
