import '../utils/constants.dart';

class StabilityEngine {
  // استحکام کا حساب
  int stableCycles = 0;
  bool systemStable = false;
  
  // قانون 3: استحکام کا قانون
  bool checkStability(bool isCurrentlyStable) {
    if (isCurrentlyStable) {
      stableCycles++;
      print("استحکام سائیکل: $stableCycles");
      
      if (stableCycles >= QSLConstants.STABILITY_CYCLES) {
        systemStable = true;
        print("🎉 نظام مکمل مستحکم ہوگیا!");
        return true;
      }
    } else {
      stableCycles = 0;
      systemStable = false;
      print("🔄 استحکام ری سیٹ");
    }
    
    return systemStable;
  }
  
  // نظام کی موجودہ حالت
  String getSystemStatus() {
    if (systemStable) return "مستحکم";
    if (stableCycles > 0) return "استحکام جاری";
    return "غیر مستحکم";
  }
}
