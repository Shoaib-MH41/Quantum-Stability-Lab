import '../utils/constants.dart';

class AccidentLaw {
  double? lastLight;
  double? lastMagnetic;
  
  // حادثے کی نوعیت (ٹرین یا کار) کا تعین کرنے والے پیرامیٹرز
  static const double TRAIN_THRESHOLD = 50.0; // بڑی لہر (سپر امپیکٹ)
  static const double CAR_THRESHOLD = 15.0;  // چھوٹی لہر (معمولی مداخلت)

  // قانون 1: حادثہ ڈیٹیکشن (Bohr vs Einstein Style)
  String detectAccidentType(double currentLight, double currentMagnetic) {
    if (lastLight == null || lastMagnetic == null) {
      lastLight = currentLight;
      lastMagnetic = currentMagnetic;
      return "نارمل";
    }

    // تبدیلیوں کا حساب
    double lightDiff = (currentLight - lastLight!).abs();
    double magneticDiff = (currentMagnetic - lastMagnetic!).abs();
    double totalImpact = lightDiff + magneticDiff;

    lastLight = currentLight;
    lastMagnetic = currentMagnetic;

    // آپ کا فلسفہ: ٹرین بمقابلہ کار
    if (totalImpact > TRAIN_THRESHOLD) {
      return "ٹرین کا حادثہ"; // NPU کو مکمل ری سیٹ کی ضرورت ہے
    } else if (totalImpact > CAR_THRESHOLD) {
      return "کار کا حادثہ"; // NPU کو صرف ایڈجسٹمنٹ کی ضرورت ہے
    }

    return "مستحکم";
  }

  // NPU کے لیے 'زبان' (Decision Logic)
  // یہ طے کرتا ہے کہ 2000 پارٹیکلز کو بکھرنے سے کیسے بچانا ہے
  double getFixationStrength(String accidentType) {
    switch (accidentType) {
      case "ٹرین کا حادثہ":
        return 0.9; // آئنسٹائن کا سخت قانون (Full Fixation)
      case "کار کا حادثہ":
        return 0.4; // بوہر کا لچکدار مشاہدہ (Partial Fixation)
      default:
        return 0.1; // کوانٹم بہاؤ (Natural Flow)
    }
  }
}
