import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

class RealQuantumParticle {
  final int id;

  /// true = NPU (Cluster Logic) | false = GPU (Individual)
  static bool useClusterLogic = false;

  /// تمام پارٹیکلز کی لسٹ
  static final List<RealQuantumParticle> allParticles = [];

  // ==================== نیا: GPU اور NPU کے لیے الگ قوانین ====================
  
  /// GPU کا قانون (پہلے: بوہر کا نظریہ - 35ms، اب: آئن سٹائن کا قانون - 25ms)
  static double gpuLaw = 25.0; // آئن سٹائن: مستحکم، واضح قانون
  
  /// NPU کا قانون (پہلے: آئن سٹائن کا قانون - 25ms، اب: بوہر کا نظریہ - 35ms)  
  static double npuLaw = 35.0; // بوہر: نظریاتی، مبہم ماڈل
  
  /// موجودہ پراسیسر کے مطابق درست قانون واپس کرتا ہے
  double get targetTime => useClusterLogic ? npuLaw : gpuLaw;
  
  // ==================== اصل کوڈ (تبدیلی کے ساتھ) ====================

  double currentTime;
  int stableCount = 0;

  /// استحکام کی پیمائش - اب مختلف قوانین کے لیے مختلف معیار
  bool get isStable {
    final tolerance = useClusterLogic ? 2.0 : 1.5; // NPU کو زیادہ رواداری
    return (currentTime - targetTime).abs() <= tolerance;
  }
  
  bool get isFullyStable => stableCount >= 3;

  double environmentalNoise = 0.0;
  double quantumRandomness = 0.0;

  StreamSubscription? _sensorSub;
  Timer? _randomTimer;

  RealQuantumParticle(this.id)
      : currentTime = useClusterLogic 
          ? 30.0 + Random().nextDouble() * 10.0  // NPU: زیادہ تغیر
          : 20.0 + Random().nextDouble() * 5.0 { // GPU: کم تغیر
    _initializeSensors();
    _startQuantumRandomness();
    allParticles.add(this);
    
    print('پارٹیکل $id پیدا ہوا | '
          'پراسیسر: ${useClusterLogic ? "NPU" : "GPU"} | '
          'قانون: ${targetTime.toStringAsFixed(1)}ms | '
          'ابتدائی وقت: ${currentTime.toStringAsFixed(1)}ms');
  }

  // ------------------ سینسرز ------------------

  void _initializeSensors() {
    try {
      _sensorSub = accelerometerEvents.listen((e) {
        environmentalNoise = (e.x.abs() + e.y.abs() + e.z.abs()) * 0.1;
      });
    } catch (e) {
      environmentalNoise = Random().nextDouble() * 0.5;
    }
  }

  void _startQuantumRandomness() {
    _randomTimer = Timer.periodic(
      Duration(milliseconds: useClusterLogic ? 1500 : 1000), // NPU سست
      (_) => quantumRandomness = Random().nextDouble() * 
            (useClusterLogic ? 1.2 : 0.8), // NPU زیادہ رینڈم
    );
  }

  // ------------------ قانون کا اطلاق (اب مختلف قوانین) ------------------

  void applyLaw() {
    final String processor = useClusterLogic ? "NPU" : "GPU";
    final double oldTime = currentTime;
    
    final step = useClusterLogic ? _calculateNPUStep() : _calculateGPUStep();
    
    // NPU اور GPU کے لیے مختلف ماحولیاتی اثرات
    final jitterMultiplier = useClusterLogic ? 1.3 : 0.7;
    final jitter = (Random().nextDouble() - 0.5) * 
                  (quantumRandomness + environmentalNoise) * jitterMultiplier;

    currentTime += step + jitter;
    
    // استحکام کا حساب
    if (isStable) {
      stableCount++;
      if (stableCount == 3) {
        print('✅ پارٹیکل $id ($processor) مکمل مستحکم! | '
              'قانون: ${targetTime}ms | '
              'حقیقی وقت: ${currentTime.toStringAsFixed(1)}ms');
      }
    } else {
      stableCount = max(0, stableCount - 1);
      
      // صرف ڈیباگنگ کے لیے
      if (Random().nextDouble() < 0.1) { // 10% مواقع پر
        print('⚠️ پارٹیکل $id ($processor) غیر مستحکم | '
              'منزل: ${targetTime}ms | '
              'موجودہ: ${currentTime.toStringAsFixed(1)}ms | '
              'فاصلہ: ${(currentTime - targetTime).abs().toStringAsFixed(1)}ms');
      }
    }
    
    // تفصیلی لاگ (اختیاری)
    if ((id == 0 || id == allParticles.length ~/ 2) && Random().nextDouble() < 0.05) {
      print('📊 پارٹیکل $id ($processor) | '
            'قدم: ${step.toStringAsFixed(3)} | '
            'جھٹکا: ${jitter.toStringAsFixed(3)} | '
            'پرانا: ${oldTime.toStringAsFixed(1)} → نیا: ${currentTime.toStringAsFixed(1)}');
    }
  }

  // ------------------ NPU (بوہر کا نظریہ - اب مبہم) ------------------

  double _calculateNPUStep() {
    // بوہر کا نظریہ: مبہم، اجتماعیت پر مبنی
    if (allParticles.length < 2) {
      final distance = targetTime - currentTime;
      return distance * 0.12; // کم اعتماد
    }

    // اجتماعیت: 8-12 پارٹیکلز کا گروپ
    final groupSize = min(12, max(8, allParticles.length ~/ 10));
    final start = max(0, id - groupSize ~/ 2);
    final end = min(allParticles.length, start + groupSize);

    double groupSum = 0;
    int count = 0;

    for (int i = start; i < end; i++) {
      groupSum += allParticles[i].currentTime;
      count++;
    }

    final groupAvg = count > 0 ? groupSum / count : currentTime;
    final distance = targetTime - groupAvg;

    // بوہر: غیر یقینی، مبہم عوامل
    double factor;
    if (distance.abs() > 8) {
      factor = 0.08; // بہت دور - کم اعتماد
    } else if (distance.abs() > 4) {
      factor = 0.12; // دور - درمیانا اعتماد
    } else if (distance.abs() > 2) {
      factor = 0.18; // قریب - اچھا اعتماد
    } else {
      factor = 0.22 + (quantumRandomness * 0.1); // بہت قریب + رینڈم
    }

    // NPU کی خصوصیت: کبھی کبھار بڑا قدم (نظریاتی چھلانگ)
    if (Random().nextDouble() < 0.05) { // 5% مواقع پر
      final quantumJump = distance * (factor * 1.5);
      print('⚡ NPU پارٹیکل $id: کوانٹم چھلانگ! ${quantumJump.toStringAsFixed(3)}');
      return quantumJump;
    }

    return distance * factor;
  }

  // ------------------ GPU (آئن سٹائن کا قانون - اب واضح) ------------------

  double _calculateGPUStep() {
    // آئن سٹائن کا قانون: واضح، حتمی
    final distance = targetTime - currentTime;

    // GPU: یقینی، مستحکم عوامل
    double factor;
    if (distance.abs() > 6) {
      factor = 0.15; // بڑا فاصلہ - مضبوط ردعمل
    } else if (distance.abs() > 3) {
      factor = 0.22; // درمیانہ فاصلہ - متوازن
    } else if (distance.abs() > 1) {
      factor = 0.28; // چھوٹا فاصلہ - احتیاطی
    } else {
      factor = 0.32; // بہت قریب - باریک ایڈجسٹمنٹ
    }

    // GPU کی خصوصیت: ہمیشہ مستحکم، کم رینڈم
    final step = distance * factor;
    
    // اضافی: جب قریب ہو تو اور بھی احتیاط
    if (distance.abs() < 0.5) {
      return step * 0.7;
    }
    
    return step;
  }

  // ------------------ تجربہ چلانے کے لیے نئے طریقے ------------------

  /// قوانین تبدیل کرنے کے لیے (آپ کا بنیادی تجربہ)
  static void swapLaws() {
    print('\n🔄 **قوانین تبدیل کیے جا رہے ہیں**');
    print('پہلے: GPU قانون = ${gpuLaw}ms, NPU قانون = ${npuLaw}ms');
    
    // قانون تبدیل کریں
    final temp = gpuLaw;
    gpuLaw = npuLaw;
    npuLaw = temp;
    
    print('بعد: GPU قانون = ${gpuLaw}ms, NPU قانون = ${npuLaw}ms');
    print('نوٹ: GPU اب ${gpuLaw == 25.0 ? "آئن سٹائن کے واضح قانون" : "بوہر کے مبہم نظریہ"} پر کام کرے گا');
    print('نوٹ: NPU اب ${npuLaw == 25.0 ? "آئن سٹائن کے واضح قانون" : "بوہر کے مبہم نظریہ"} پر کام کرے گا');
  }

  /// پراسیسر تبدیل کرنے کے لیے (GPU ↔ NPU)
  static void switchProcessor(bool useNpu) {
    useClusterLogic = useNpu;
    print('\n🔀 **پراسیسر تبدیل کیا گیا**');
    print('نیا پراسیسر: ${useClusterLogic ? "NPU" : "GPU"}');
    print('نیا قانون: ${useClusterLogic ? npuLaw : gpuLaw}ms');
    print('قانون کی نوعیت: ${(useClusterLogic ? npuLaw : gpuLaw) == 25.0 ? "آئن سٹائن (واضح)" : "بوہر (مبہم)"}');
  }

  /// تمام پارٹیکلز پر قانون لاگو کریں اور نتائج جمع کریں
  static Map<String, dynamic> applyLawToAll({int iterations = 1}) {
    final results = {
      'processor': useClusterLogic ? 'NPU' : 'GPU',
      'law': useClusterLogic ? npuLaw : gpuLaw,
      'totalParticles': allParticles.length,
      'stableParticles': 0,
      'fullyStableParticles': 0,
      'avgTime': 0.0,
      'minTime': double.infinity,
      'maxTime': double.negativeInfinity,
      'iterations': iterations,
    };

    for (int i = 0; i < iterations; i++) {
      int stableThisIteration = 0;
      double sumTime = 0.0;
      
      for (var particle in allParticles) {
        particle.applyLaw();
        
        if (particle.isStable) stableThisIteration++;
        if (particle.isFullyStable) results['fullyStableParticles']++;
        
        sumTime += particle.currentTime;
        results['minTime'] = min(results['minTime'], particle.currentTime);
        results['maxTime'] = max(results['maxTime'], particle.currentTime);
      }
      
      results['stableParticles'] = stableThisIteration;
      results['avgTime'] = sumTime / allParticles.length;
      
      // ہر iteration کے بعد لاگ
      if ((i + 1) % 10 == 0 || i == 0 || i == iterations - 1) {
        print('🔄 Iteration ${i + 1}/$iterations | '
              'مستحکم: $stableThisIteration/${allParticles.length} | '
              'اوسط وقت: ${(sumTime / allParticles.length).toStringAsFixed(1)}ms');
      }
    }

    return results;
  }

  /// تفصیلی رپورٹ دکھائیں
  static void showDetailedReport() {
    print('\n📊 **تفصیلی رپورٹ**');
    print('=' * 60);
    print('پراسیسر: ${useClusterLogic ? "NPU" : "GPU"}');
    print('قانون: ${useClusterLogic ? npuLaw : gpuLaw}ms '
          '(${((useClusterLogic ? npuLaw : gpuLaw) == 25.0 ? "آئن سٹائن - واضح" : "بوہر - مبہم")})');
    print('کل پارٹیکلز: ${allParticles.length}');
    
    int stableCount = 0;
    int fullyStableCount = 0;
    double totalTime = 0;
    
    for (var p in allParticles) {
      if (p.isStable) stableCount++;
      if (p.isFullyStable) fullyStableCount++;
      totalTime += p.currentTime;
    }
    
    print('مستحکم پارٹیکلز: $stableCount (${(stableCount / allParticles.length * 100).toStringAsFixed(1)}%)');
    print('مکمل مستحکم: $fullyStableCount');
    print('اوسط وقت: ${(totalTime / allParticles.length).toStringAsFixed(2)}ms');
    print('قانون سے اوسط فاصلہ: ${((totalTime / allParticles.length) - (useClusterLogic ? npuLaw : gpuLaw)).abs().toStringAsFixed(2)}ms');
    
    // پہلے 5 پارٹیکلز کی تفصیل
    print('\nپہلے 5 پارٹیکلز کی کیفیت:');
    for (int i = 0; i < min(5, allParticles.length); i++) {
      final p = allParticles[i];
      print('  پارٹیکل ${p.id}: ${p.currentTime.toStringAsFixed(1)}ms | '
            'مستحکم: ${p.isStable ? "✅" : "❌"} | '
            'مکمل: ${p.isFullyStable ? "✅" : "❌"} | '
            'فاصلہ: ${(p.currentTime - p.targetTime).abs().toStringAsFixed(1)}ms');
    }
    
    print('=' * 60);
  }

  // ------------------ صفائی ------------------

  void dispose() {
    _sensorSub?.cancel();
    _randomTimer?.cancel();
    allParticles.remove(this);
  }

  static void clearAll() {
    for (var particle in allParticles.toList()) {
      particle.dispose();
    }
    allParticles.clear();
    print('🧹 تمام پارٹیکلز صاف کیے گئے');
  }
}

// ==================== تجربہ چلانے کے لیے علیحدہ کلاس ====================

class LawSwapExperiment {
  /// پہلا تجربہ: GPU=بوہر (35ms), NPU=آئن سٹائن (25ms)
  static void runExperiment1({int particles = 2000, int iterations = 100}) {
    print('\n🧪 **تجربہ 1 شروع ہو رہا ہے**');
    print('=' * 60);
    print('ترتیب: GPU = بوہر کا نظریہ (35ms)');
    print('        NPU = آئن سٹائن کا قانون (25ms)');
    print('=' * 60);
    
    // قوانین سیٹ کریں
    RealQuantumParticle.gpuLaw = 35.0; // بوہر
    RealQuantumParticle.npuLaw = 25.0; // آئن سٹائن
    
    // پہلے GPU کے ساتھ ٹیسٹ
    print('\n📈 **GPU ٹیسٹ (بوہر کا نظریہ)**');
    RealQuantumParticle.switchProcessor(false); // GPU
    
    // پارٹیکلز بنائیں
    for (int i = 0; i < particles; i++) {
      RealQuantumParticle(i);
    }
    
    // قانون لاگو کریں
    final gpuResults = RealQuantumParticle.applyLawToAll(iterations: iterations);
    RealQuantumParticle.showDetailedReport();
    
    // صاف کریں اور NPU کے لیے تیار کریں
    RealQuantumParticle.clearAll();
    
    // اب NPU کے ساتھ ٹیسٹ
    print('\n📈 **NPU ٹیسٹ (آئن سٹائن کا قانون)**');
    RealQuantumParticle.switchProcessor(true); // NPU
    
    // پارٹیکلز بنائیں
    for (int i = 0; i < particles; i++) {
      RealQuantumParticle(i);
    }
    
    // قانون لاگو کریں
    final npuResults = RealQuantumParticle.applyLawToAll(iterations: iterations);
    RealQuantumParticle.showDetailedReport();
    
    // موازنہ
    print('\n🏆 **تجربہ 1 کا موازنہ**');
    print('=' * 60);
    _compareResults(gpuResults, npuResults);
    
    RealQuantumParticle.clearAll();
  }
  
  /// دوسرا تجربہ: GPU=آئن سٹائن (25ms), NPU=بوہر (35ms)
  static void runExperiment2({int particles = 2000, int iterations = 100}) {
    print('\n🧪 **تجربہ 2 شروع ہو رہا ہے**');
    print('=' * 60);
    print('ترتیب: GPU = آئن سٹائن کا قانون (25ms)');
    print('        NPU = بوہر کا نظریہ (35ms)');
    print('=' * 60);
    print('نوٹ: یہ وہ تبدیلی ہے جس کے بارے میں آپ نے سوچا!');
    print('=' * 60);
    
    // **قوانین تبدیل کریں!**
    RealQuantumParticle.gpuLaw = 25.0; // آئن سٹائن
    RealQuantumParticle.npuLaw = 35.0; // بوہر
    
    // پہلے GPU کے ساتھ ٹیسٹ
    print('\n📈 **GPU ٹیسٹ (آئن سٹائن کا قانون)**');
    RealQuantumParticle.switchProcessor(false); // GPU
    
    // پارٹیکلز بنائیں
    for (int i = 0; i < particles; i++) {
      RealQuantumParticle(i);
    }
    
    // قانون لاگو کریں
    final gpuResults = RealQuantumParticle.applyLawToAll(iterations: iterations);
    RealQuantumParticle.showDetailedReport();
    
    // صاف کریں اور NPU کے لیے تیار کریں
    RealQuantumParticle.clearAll();
    
    // اب NPU کے ساتھ ٹیسٹ
    print('\n📈 **NPU ٹیسٹ (بوہر کا نظریہ)**');
    RealQuantumParticle.switchProcessor(true); // NPU
    
    // پارٹیکلز بنائیں
    for (int i = 0; i < particles; i++) {
      RealQuantumParticle(i);
    }
    
    // قانون لاگو کریں
    final npuResults = RealQuantumParticle.applyLawToAll(iterations: iterations);
    RealQuantumParticle.showDetailedReport();
    
    // موازنہ
    print('\n🏆 **تجربہ 2 کا موازنہ**');
    print('=' * 60);
    _compareResults(gpuResults, npuResults);
    
    RealQuantumParticle.clearAll();
  }
  
  /// دونوں تجربوں کا موازنہ
  static void _compareResults(Map<String, dynamic> gpuResults, Map<String, dynamic> npuResults) {
    print('پراسیسر  | قانون  | مستحکم%  | مکمل مستحکم | اوسط وقت | فاصلہ');
    print('-' * 70);
    
    final gpuStablePercent = (gpuResults['stableParticles'] / gpuResults['totalParticles'] * 100).toStringAsFixed(1);
    final npuStablePercent = (npuResults['stableParticles'] / npuResults['totalParticles'] * 100).toStringAsFixed(1);
    
    final gpuDistance = (gpuResults['avgTime'] - gpuResults['law']).abs().toStringAsFixed(2);
    final npuDistance = (npuResults['avgTime'] - npuResults['law']).abs().toStringAsFixed(2);
    
    print('${gpuResults['processor']} | ${gpuResults['law']}ms | $gpuStablePercent% | '
          '${gpuResults['fullyStableParticles']} | ${gpuResults['avgTime'].toStringAsFixed(1)}ms | ${gpuDistance}ms');
    
    print('${npuResults['processor']}  | ${npuResults['law']}ms | $npuStablePercent% | '
          '${npuResults['fullyStableParticles']} | ${npuResults['avgTime'].toStringAsFixed(1)}ms | ${npuDistance}ms');
    
    // فاتح کا اعلان
    final gpuScore = (double.parse(gpuStablePercent) / 100) * (1 / (double.parse(gpuDistance) + 0.1));
    final npuScore = (double.parse(npuStablePercent) / 100) * (1 / (double.parse(npuDistance) + 0.1));
    
    print('\n🏆 فاتح: ${gpuScore > npuScore ? "GPU" : "NPU"} '
          '(${(gpuScore > npuScore ? gpuScore / npuScore : npuScore / gpuScore).toStringAsFixed(2)}x بہتر)');
    
    if (gpuResults['law'] == 25.0 && npuResults['law'] == 35.0) {
      print('💡 مشاہدہ: GPU واضح قانون (25ms) پر بہتر کام کرتا ہے!');
    } else if (gpuResults['law'] == 35.0 && npuResults['law'] == 25.0) {
      print('💡 مشاہدہ: NPU واضح قانون (25ms) پر بہتر کام کرتا ہے!');
    }
  }
}
