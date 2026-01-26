class QuantumParticle {
  final int id;
  double currentTime;
  int stabilityCount;
  bool isStable;
  
  QuantumParticle(this.id) 
    : currentTime = 20 + (id * 3 % 20).toDouble(),
      stabilityCount = 0,
      isStable = false;
  
  void apply35msLaw() {
    // Quantum fluctuation (Bohr)
    double quantumFluctuation = (DateTime.now().microsecond % 100 - 50) / 10.0;
    currentTime += quantumFluctuation;
    
    // 35ms fixation law (Einstein)
    if (currentTime < 30) {
      currentTime += (35 - currentTime) * 0.3;
    } else if (currentTime > 40) {
      currentTime -= (currentTime - 35) * 0.3;
    }
    
    // Stability check
    isStable = currentTime >= 30 && currentTime <= 40;
    if (isStable) {
      stabilityCount++;
    } else {
      stabilityCount = 0;
    }
  }
  
  bool get isFullyStable => stabilityCount >= 3;
}
