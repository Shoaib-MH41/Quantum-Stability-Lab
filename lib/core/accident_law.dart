import '../utils/constants.dart';

class AccidentLaw {
  // پچھلا ڈیٹا یاد رکھنے کے لیے
  double? lastLight;
  double? lastMagnetic;
  
  // قانون 1: حادثہ ڈیٹیکشن
  bool detectAccident(double currentLight, double currentMagnetic) {
    bool isAccident = false;
    
    // پہلا ڈیٹا نہ ہونے کی صورت میں
    if (lastLight == null || lastMagnetic == null) {
      lastLight = currentLight;
      lastMagnetic = currentMagnetic;
      return false;
    }
    
    // روشنی میں اچانک تبدیلی
    double lightDiff = (currentLight - lastLight!).abs();
    if (lightDiff > QSLConstants.LIGHT_THRESHOLD) {
      isAccident = true;
      print("حادثہ: روشنی میں تبدیلی = $lightDiff");
    }
    
    // مقناطیسی تبدیلی
    double magneticDiff = (currentMagnetic - lastMagnetic!).abs();
    if (magneticDiff > QSLConstants.MAGNETIC_THRESHOLD) {
      isAccident = true;
      print("حادثہ: مقناطیسی تبدیلی = $magneticDiff");
    }
    
    // نیا ڈیٹا یاد رکھیں
    lastLight = currentLight;
    lastMagnetic = currentMagnetic;
    
    return isAccident;
  }
}
