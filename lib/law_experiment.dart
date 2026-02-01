import '../core/real_quantum_particle.dart';

class LawExperiment {
  // 👈 آپ کے 'main.dart' کے نئے نام کے مطابق
  static void runCrossMatchTest() { 
    print('\n🚀 آئن سٹائن بمقابلہ بوہر: کراس میچ تجربہ شروع\n');

    // 🧪 ٹیسٹ 1: GPU ہارڈویئر + بوہر کی منطق (35ms)
    // یہاں ہم دیکھیں گے کہ GPU کی انفرادی طاقت 35ms کے کوانٹم ہدف کو کیسے سنبھالتی ہے
    print('--- ٹیسٹ 1: GPU (Individual) + نیلز بوہر (35ms) ---');
    RealQuantumParticle.useClusterLogic = false; // ہارڈویئر: GPU (انفرادی)
    RealQuantumParticle.gpuLaw = 35.0;            // قانون: بوہر (35ms)
    
    _executeTest(50);
    RealQuantumParticle.clearAll();

    // 🧪 ٹیسٹ 2: NPU ہارڈویئر + آئن سٹائن کی منطق (25ms)
    // یہاں ہم دیکھیں گے کہ NPU کی کلسٹرنگ لاجک 25ms کے سخت ہدف کو کیسے حل کرتی ہے
    print('\n--- ٹیسٹ 2: NPU (Cluster) + آئن سٹائن (25ms) ---');
    RealQuantumParticle.useClusterLogic = true;  // ہارڈویئر: NPU (گروپ)
    RealQuantumParticle.npuLaw = 25.0;           // قانون: آئن سٹائن (25ms)
    
    _executeTest(50);
    RealQuantumParticle.clearAll();

    print('\n✅ کراس موازنہ مکمل!');
  }

  static void _executeTest(int count) {
    for (int i = 0; i < count; i++) {
      RealQuantumParticle(i);
    }

    for (int tick = 1; tick <= 10; tick++) {
      int stableOnes = 0;
      for (var p in RealQuantumParticle.allParticles) {
        p.applyLaw();
        if (p.isFullyStable) stableOnes++;
      }
      print('ٹک $tick: مستحکم ذرات = $stableOnes / $count');
    }
  }
}
