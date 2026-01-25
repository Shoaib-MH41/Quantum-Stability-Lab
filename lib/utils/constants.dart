class QSLConstants {
  // 35ms کا بنیادی قانون
  static const double FIXATION_TIME_MS = 35.0;
  
  // حادثہ ڈیٹیکشن کے thresholds
  static const double LIGHT_THRESHOLD = 50.0;
  static const double MAGNETIC_THRESHOLD = 100.0;
  
  // استحکام کے لیے cycles
  static const int STABILITY_CYCLES = 3;
  
  // رنگ
  static const int STABLE_COLOR = 0xFF4CAF50; // سبز
  static const int UNSTABLE_COLOR = 0xFFF44336; // سرخ
  static const int ACCIDENT_COLOR = 0xFFFF9800; // اورنج
}
