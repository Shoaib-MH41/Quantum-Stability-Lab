import '../utils/constants.dart';

class FixationLaw {
  // 30ms تثبیت کا ہدف (Target Fixation)
  static const double TARGET_FIXATION = 30.0; 
  static const double TOLERANCE = 5.0; // لچک

  // قانون 2: متحرک تثبیت (Dynamic Fixation)
  // اب یہ صرف چیک نہیں کرتا، بلکہ 'زبان' دیتا ہے
  Map<String, dynamic> applyQuantumFixation(double currentNpuTime, double fixationStrength) {
    double difference = (currentNpuTime - TARGET_FIXATION).abs();
    
    // بوہر اور آئنسٹائن کا ملاپ: کیا وقت قانون کے اندر ہے؟
    bool isWithinLaw = difference <= TOLERANCE;

    // اگر 'حادثہ' بڑا ہے (ٹرین)، تو تثبیت کو سخت کریں
    // اگر چھوٹا ہے (کار)، تو اسے کوانٹم بہاؤ میں رہنے دیں
    double adjustedTime = isWithinLaw 
        ? currentNpuTime 
        : (currentNpuTime * (1.0 - fixationStrength)) + (TARGET_FIXATION * fixationStrength);

    return {
      'isFixed': isWithinLaw,
      'adjustedTime': adjustedTime,
      'status': _getLawStatus(isWithinLaw, fixationStrength),
    };
  }

  // قانون کی حالت کی وضاحت
  String _getLawStatus(bool isFixed, double strength) {
    if (isFixed) return "قانونِ تثبیت مکمل لاگو ✅";
    if (strength > 0.8) return "سخت تثبیت (Train Law) 🚂";
    if (strength > 0.3) return "لچکدار تثبیت (Car Law) 🚗";
    return "تلاشِ استحکام... 🔍";
  }
}
