import '../utils/constants.dart';

class FixationLaw {
  // قانون 2: 35ms پر تثبیت
  bool applyFixationLaw(double currentNpuTime) {
    // NPU time 35ms کے قریب ہے؟
    double difference = (currentNpuTime - QSLConstants.FIXATION_TIME_MS).abs();
    
    if (difference <= 5.0) { // 5ms tolerance
      print("✅ قانونِ تثبیت: NPU وقت = ${currentNpuTime.toStringAsFixed(1)}ms");
      return true;
    } else {
      print("❌ نظام غیر مستحکم: ${currentNpuTime.toStringAsFixed(1)}ms");
      return false;
    }
  }
}
