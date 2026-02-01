import '../core/real_quantum_particle.dart';

class LawExperiment {
  static void runCrossMatchTest() {
    print('\n🚀 آئن سٹائن بمقابلہ بوہر: کراس میچ تجربہ شروع\n');

    // 🧪 تجربہ 1: GPU ہارڈویئر پر بوہر کا قانون (35ms) چلانا
    print('--- ٹیسٹ 1: GPU + نیلز بوہر (35ms) ---');
    RealQuantumParticle.useClusterLogic = false; // GPU ہارڈویئر
    RealQuantumParticle.gpuLaw = 35.0; // بوہر کا قانون سیٹ کیا
    
    _executeTest(50);
    RealQuantumParticle.clearAll();

    // 🧪 تجربہ 2: NPU ہارڈویئر پر آئن سٹائن کا قانون (25ms) چلانا
    print('\n--- ٹیسٹ 2: NPU + آئن سٹائن (25ms) ---');
    RealQuantumParticle.useClusterLogic = true; // NPU ہارڈویئر
    RealQuantumParticle.npuLaw = 25.0; // آئن سٹائن کا قانون سیٹ کیا
    
    _executeTest(50);
    RealQuantumParticle.clearAll();

    print('\n✅ تمام کراس ٹیسٹ مکمل ہو گئے!');
  }

  static void _executeTest(int count) {
    for (int i = 0; i < count; i++) {
      RealQuantumParticle(i);
    }

    for (int tick = 0; tick < 5; tick++) {
      int stableOnes = 0;
      for (var p in RealQuantumParticle.allParticles) {
        p.applyLaw();
        if (p.isFullyStable) stableOnes++;
      }
      print('ٹک $tick: مستحکم ذرات = $stableOnes / $count');
    }
  }
}
