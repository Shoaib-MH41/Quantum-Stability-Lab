import 'dart:math';

// ⚛️ Hybrid Particle: Quantum (Bohr) + Classical (Einstein)
class HybridParticle {
  final int id;
  
  // Quantum Properties (بوہر)
  List<double> superpositionStates = []; // ایک ساتھ کئی حالتیں
  List<double> probabilityAmplitudes = []; // ہر state کا probability
  bool isCollapsed = false;
  double? collapsedState;
  
  // Classical Properties (آئن اسٹائن)
  double classicalState;
  bool useQuantumLogic = false;
  
  // Entanglement (کوانٹم جڑاؤ)
  List<int> entangledParticles = [];
  
  HybridParticle(this.id) 
    : classicalState = 20 + Random().nextDouble() * 40 {
    
    // Initialize quantum superposition
    _initializeSuperposition();
  }
  
  void _initializeSuperposition() {
    // 5 possible quantum states (superposition)
    superpositionStates = [30.0, 32.5, 35.0, 37.5, 40.0];
    
    // Probability amplitudes (بوہر کا probability distribution)
    // 35.0 سب سے زیادہ probable (40%)
    probabilityAmplitudes = [0.15, 0.20, 0.40, 0.20, 0.15];
  }
  
  // ⚛️ QUANTUM MODE: Bohr's Philosophy (NPU)
  double solveWithQuantumLogic() {
    if (isCollapsed && collapsedState != null) {
      // Already collapsed - return same state
      return collapsedState!;
    }
    
    // Quantum measurement (مشاہدہ)
    double measurement = Random().nextDouble();
    double cumulative = 0;
    
    for (int i = 0; i < probabilityAmplitudes.length; i++) {
      cumulative += probabilityAmplitudes[i];
      if (measurement <= cumulative) {
        // Wave function collapse (بوہر)
        collapsedState = superpositionStates[i];
        isCollapsed = true;
        
        // Collapse entangled particles too
        _collapseEntangledParticles();
        
        return collapsedState!;
      }
    }
    
    // Default
    collapsedState = 35.0;
    isCollapsed = true;
    return collapsedState!;
  }
  
  // ⚖️ CLASSICAL MODE: Einstein's Philosophy (GPU)
  double solveWithClassicalLogic() {
    // Deterministic calculation (مقررہ حساب)
    double error = (35.0 - classicalState).abs();
    
    if (error > 10) {
      // Big error - large correction
      classicalState += (35.0 - classicalState) * 0.5;
    } else if (error > 5) {
      // Medium error
      classicalState += (35.0 - classicalState) * 0.3;
    } else {
      // Small error - fine tuning
      classicalState += (35.0 - classicalState) * 0.1;
    }
    
    // Clamp to reasonable range
    if (classicalState < 20) classicalState = 20;
    if (classicalState > 50) classicalState = 50;
    
    return classicalState;
  }
  
  // Entangle with another particle (کوانٹم جڑاؤ)
  void entangleWith(HybridParticle other) {
    if (!entangledParticles.contains(other.id)) {
      entangledParticles.add(other.id);
      other.entangledParticles.add(id);
      
      // Sync probability distributions
      for (int i = 0; i < probabilityAmplitudes.length; i++) {
        probabilityAmplitudes[i] = 
            (probabilityAmplitudes[i] + other.probabilityAmplitudes[i]) / 2;
      }
    }
  }
  
  void _collapseEntangledParticles() {
    // When this particle collapses, entangled particles also affected
    // This is quantum entanglement in action
  }
  
  // Apply 35ms Law based on selected mode
  double apply35msLaw(bool useQuantum) {
    useQuantumLogic = useQuantum;
    
    if (useQuantum) {
      return solveWithQuantumLogic();
    } else {
      return solveWithClassicalLogic();
    }
  }
  
  // Get particle status
  String get status {
    if (useQuantumLogic) {
      if (isCollapsed) {
        return "Quantum Collapsed: ${collapsedState!.toStringAsFixed(1)}ms";
      } else {
        return "Quantum Superposition";
      }
    } else {
      return "Classical: ${classicalState.toStringAsFixed(1)}ms";
    }
  }
  
  // Get philosophy description
  String get philosophy {
    return useQuantumLogic 
        ? "⚛️ Bohr: Probability, Superposition, Collapse"
        : "⚖️ Einstein: Deterministic, Local Reality";
  }
}
