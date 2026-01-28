import 'dart:math';

// ⚡ GPU vs NPU: طاقت vs ذہانت کا درست تجربہ
class QuantumIntelligenceSystem {
  final int id;
  bool isNPUMode;
  
  double currentTime;
  final double targetTime = 35.0;
  int intelligenceScore = 0;
  int strengthScore = 0;
  
  // Pattern recognition کے لیے
  List<double> memoryPattern = [];
  static final Random _random = Random();
  
  QuantumIntelligenceSystem(this.id, {this.isNPUMode = false})
      : currentTime = 10.0 + _random.nextDouble() * 50.0 {
    // Memory pattern initialize کریں
    _initializePatternMemory();
  }
  
  void _initializePatternMemory() {
    // 10 مختلف patterns memorize کریں
    for (int i = 0; i < 10; i++) {
      memoryPattern.add(20.0 + _random.nextDouble() * 30.0);
    }
  }
  
  // 🔥 GPU کا Test: طاقت کا استعمال (Brute Force)
  void applyGPUStrength() {
    Stopwatch timer = Stopwatch()..start();
    
    // ========== GPU: طاقت کا استعمال ==========
    // Heavy computation - GPU کی طاقت دکھائیں
    double computationResult = 0.0;
    
    // GPU کا brute force approach
    for (int i = 0; i < 50000; i++) { // Heavy loop
      double x = i * 0.0001;
      computationResult += sin(x) * cos(x) * tan(x);
    }
    
    // طاقت سے solution
    double bruteForceStep = (targetTime - currentTime).abs();
    
    if (bruteForceStep > 20) {
      // بہت دور ہے - بڑا step
      currentTime += (targetTime - currentTime) * 0.4;
      strengthScore += 5; // زیادہ طاقت کا استعمال
    } else if (bruteForceStep > 10) {
      // درمیانہ فاصلہ
      currentTime += (targetTime - currentTime) * 0.25;
      strengthScore += 3;
    } else {
      // قریب ہے
      currentTime += (targetTime - currentTime) * 0.15;
      strengthScore += 1;
    }
    
    timer.stop();
    // GPU طاقت: کم وقت میں زیادہ computation
    if (timer.elapsedMilliseconds < 100) {
      strengthScore += 10; // سپیڈ بونس
    }
    
    // Current time کو reasonable range میں رکھیں
    currentTime = currentTime.clamp(10.0, 60.0);
  }
  
  // 🧠 NPU کا Test: ذہانت کا استعمال (Pattern Recognition)
  void applyNPUIntelligence() {
    // ========== NPU: ذہانت کا استعمال ==========
    // Step 1: Pattern recognize کریں
    double recognizedPattern = _recognizePattern();
    
    // Step 2: Smart decision لو
    double smartStep = _makeIntelligentDecision(recognizedPattern);
    
    // Step 3: Apply with intelligence
    currentTime += smartStep;
    
    // Intelligence score بڑھائیں
    double accuracy = 1.0 - ((currentTime - targetTime).abs() / 50.0);
    intelligenceScore += (accuracy * 10).toInt();
    
    // اگر قریب پہنچ گئے تو extra bonus
    if ((currentTime - targetTime).abs() < 2.0) {
      intelligenceScore += 20; // Smart solution bonus
    }
  }
  
  double _recognizePattern() {
    // NPU کی pattern recognition صلاحیت
    // memory میں سے similar pattern ڈھونڈیں
    
    double bestMatch = memoryPattern[0];
    double smallestDiff = double.infinity;
    
    for (double pattern in memoryPattern) {
      double diff = (pattern - currentTime).abs();
      if (diff < smallestDiff) {
        smallestDiff = diff;
        bestMatch = pattern;
      }
    }
    
    // Pattern کے مطابق predict کریں
    double prediction = bestMatch + ((targetTime - bestMatch) * 0.3);
    return prediction;
  }
  
  double _makeIntelligentDecision(double predictedValue) {
    // NPU کی decision making صلاحیت
    
    double distanceToTarget = (targetTime - currentTime).abs();
    double confidence = 1.0 - (distanceToTarget / 50.0);
    
    // Smart decision: confidence کے مطابق step size
    if (confidence > 0.7) {
      // High confidence - بڑا step
      return (predictedValue - currentTime) * 0.4;
    } else if (confidence > 0.4) {
      // Medium confidence - درمیانہ step
      return (predictedValue - currentTime) * 0.25;
    } else {
      // Low confidence - چھوٹا step
      return (predictedValue - currentTime) * 0.1;
    }
  }
  
  // درست Test چلائیں
  void applyCorrectTest() {
    if (isNPUMode) {
      applyNPUIntelligence(); // NPU: ذہانت کا test
    } else {
      applyGPUStrength();     // GPU: طاقت کا test
    }
  }
  
  // Results
  bool get isSuccessful {
    return (currentTime - targetTime).abs() < 1.5;
  }
  
  String get performanceReport {
    if (isNPUMode) {
      return "🧠 NPU Intelligence: Score $intelligenceScore | "
             "Smart Decisions: ${intelligenceScore ~/ 10}";
    } else {
      return "⚡ GPU Strength: Score $strengthScore | "
             "Compute Power: ${strengthScore ~/ 5} units";
    }
  }
  
  String get philosophy {
    return isNPUMode
        ? "ذہانت: Pattern Recognition + Smart Decisions"
        : "طاقت: Brute Force + Heavy Computation";
  }
}
