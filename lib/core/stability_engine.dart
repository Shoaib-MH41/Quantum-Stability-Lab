import '../utils/constants.dart';

class StabilityEngine {
  int stableCycles = 0;
  bool systemStable = false;
  
  // NPU کے مخصوص انداز کے لیے نئے متغیرات
  double currentInferenceTime = 0.0;
  final double targetTime = 30.0; // آپ کا 30ms کا قانون

  // قانون 3: استحکام کا قانون (NPU Optimized)
  // اب یہ صرف ہاں یا نہ نہیں، بلکہ 'انداز' کو دیکھتا ہے
  bool checkStability(double inferenceTime, int particleCount) {
    currentInferenceTime = inferenceTime;

    // اگر پارٹیکل 2000 ہیں تو NPU کو 'سمیٹنے' (Compression) کا اشارہ دیں
    bool isLogicStable = (inferenceTime <= targetTime); 

    if (isLogicStable) {
      stableCycles++;
      
      // جتنا زیادہ ڈیٹا (2000 پارٹیکلز)، اتنا ہی سخت استحکام کا معیار
      int requiredCycles = (particleCount > 100) ? 15 : 5; 

      if (stableCycles >= requiredCycles) {
        systemStable = true;
        return true;
      }
    } else {
      // اگر اسکرین شاٹ یا لائٹ کی وجہ سے اسکور 30ms سے اوپر جائے
      // تو سسٹم اسے 'حادثہ' سمجھ کر ری سیٹ کرے گا
      stableCycles = 0;
      systemStable = false;
    }
    
    return systemStable;
  }
  
  // نظام کی حالت اب اردو 'زبان' میں
  String getSystemStatus() {
    if (systemStable) return "کوانٹم استحکام (Stable) ✅";
    if (currentInferenceTime > targetTime) return "مداخلت (Interference) ⚠️";
    if (stableCycles > 0) return "مشاہدہ جاری... 🔍";
    return "غیر مستحکم 🔄";
  }

  // NPU کے لیے 'سمیٹنے' کا قانون (Data Compression Logic)
  // یہ NPU کو بتاتا ہے کہ 2000 پارٹیکلز کو ایک لہر سمجھو
  double getCompressionFactor(int particleCount) {
    if (particleCount > 100) {
      return 0.05; // 2000 کو سمیٹ کر 'ذہانت' میں بدلنا
    }
    return 1.0; // چھوٹے اسکیل پر بوہر کا انفرادی مشاہدہ
  }
}
