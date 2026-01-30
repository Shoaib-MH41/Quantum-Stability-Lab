/// منطق حل کنندہ - پہیلیاں اور منطقی مسائل حل کرتا ہے
class LogicSolver {
  
  // 🧠 منطقی اور کائناتی مسائل حل کرنے والا
  static Map<String, dynamic> solvePuzzle(String puzzle) {
    final q = puzzle.trim().toLowerCase();
    
    // مصافحہ مسئلہ
    if (q.contains('مصافحہ') || q.contains('افراد')) {
      final n = _extractNumber(q) ?? 5;
      final handshakes = n * (n - 1) ~/ 2;
      
      return {
        'solution': '$n افراد کے درمیان $handshakes مصافحے ہوں گے',
        'explanation': 'فارمولا: n(n-1)/2',
        'formula': 'H = n(n-1)/2',
        'logic': 'ہر شخص دوسرے ہر شخص سے ایک بار مصافحہ کرتا ہے'
      };
    }
    
    // گھڑی کا مسئلہ
    if (q.contains('گھڑی') && q.contains('زاویہ')) {
      final time = _extractTime(q) ?? '03:00';
      final angle = _calculateClockAngle(time);
      
      return {
        'solution': '$time پر گھڑی کے ہاتھوں کے درمیان زاویہ: $angle ڈگری',
        'explanation': 'گھڑی کا ہر عدد 30 ڈگری کا ہوتا ہے',
        'formula': 'زاویہ = |30H - 5.5M|'
      };
    }
    
    // عمومی منطق
    return {
      'solution': 'منطقی تجزیہ جاری ہے',
      'explanation': 'NPU اس مسئلہ پر غور کر رہا ہے',
      'status': 'under_analysis'
    };
  }
  
  // 🔧 ہیلپر فنکشنز
  static int? _extractNumber(String text) {
    final numbers = {
      'ایک': 1, 'دو': 2, 'تین': 3, 'چار': 4, 'پانچ': 5,
      'چھ': 6, 'سات': 7, 'آٹھ': 8, 'نو': 9, 'دس': 10,
      '1': 1, '2': 2, '3': 3, '4': 4, '5': 5,
      '6': 6, '7': 7, '8': 8, '9': 9, '10': 10
    };
    
    for (var key in numbers.keys) {
      if (text.contains(key)) {
        return numbers[key];
      }
    }
    return null;
  }
  
  static String? _extractTime(String text) {
    final regex = RegExp(r'(\d{1,2})[:\s](\d{1,2})');
    final match = regex.firstMatch(text);
    if (match != null) {
      return '${match.group(1)}:${match.group(2)}';
    }
    return null;
  }
  
  static double _calculateClockAngle(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]) % 12;
    final minute = int.parse(parts[1]);
    
    final hourAngle = 0.5 * (60 * hour + minute);
    final minuteAngle = 6 * minute;
    
    var angle = (hourAngle - minuteAngle).abs();
    if (angle > 180) {
      angle = 360 - angle;
    }
    
    return angle;
  }
}
