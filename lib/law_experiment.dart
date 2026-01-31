// lib/experiments/law_experiment.dart

import '../core/real_quantum_particle.dart';

class LawExperiment {
  static void runSimpleTest() {
    print('\n🚀 NPU/GPU قانون تبدیلی کا تجربہ\n');
    
    // تجربہ 1: GPU
    print('🧪 GPU = بوہر (35ms)');
    RealQuantumParticle.useClusterLogic = false;
    RealQuantumParticle.gpuLaw = 35.0;
    
    for (int i = 0; i < 50; i++) RealQuantumParticle(i);
    
    for (int i = 0; i < 10; i++) {
      for (var p in RealQuantumParticle.allParticles) p.applyLaw();
    }
    
    RealQuantumParticle.clearAll();
    
    // تجربہ 2: NPU
    print('\n🧪 NPU = بوہر (35ms)');
    RealQuantumParticle.useClusterLogic = true;
    
    for (int i = 0; i < 50; i++) RealQuantumParticle(i);
    
    for (int i = 0; i < 10; i++) {
      for (var p in RealQuantumParticle.allParticles) p.applyLaw();
    }
    
    RealQuantumParticle.clearAll();
    print('\n✅ تجربہ مکمل!');
  }
}
