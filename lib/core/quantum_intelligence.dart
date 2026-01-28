import 'dart:math';

class QuantumIntelligenceParticle {
  final int id;
  double currentTime;
  final double targetTime = 35.0;
  int attempts = 0;
  
  // NPU: Group/cluster intelligence
  // GPU: Individual brute force
  
  QuantumIntelligenceParticle(this.id) 
    : currentTime = 20 + Random().nextDouble() * 40;
  
  // GPU MODE: Individual Brute Force (ہر پارٹیکل الگ سوچے)
  bool solveIndividual() {
    attempts++;
    
    // Brute force approach - random attempts
    double randomStep = (Random().nextDouble() - 0.5) * 10;
    currentTime += randomStep;
    
    // Clamp to reasonable range
    if (currentTime < 20) currentTime = 20;
    if (currentTime > 50) currentTime = 50;
    
    return (currentTime - targetTime).abs() < 0.5;
  }
  
  // NPU MODE: Group Intelligence (گروپ میں سوچے)
  static bool solveGroup(List<QuantumIntelligenceParticle> particles) {
    if (particles.isEmpty) return false;
    
    // Step 1: Particles کو groups میں divide کریں
    Map<int, List<QuantumIntelligenceParticle>> groups = {};
    for (var particle in particles) {
      int groupId = (particle.id % 10); // 10 groups
      groups.putIfAbsent(groupId, () => []).add(particle);
      particle.attempts++;
    }
    
    // Step 2: ہر group کا average نکالیں
    Map<int, double> groupAverages = {};
    groups.forEach((groupId, groupParticles) {
      double sum = groupParticles.fold(0, (prev, p) => prev + p.currentTime);
      groupAverages[groupId] = sum / groupParticles.length;
    });
    
    // Step 3: ہر پارٹیکل کو اپنے group کے average کی طرف move کریں
    bool allStable = true;
    
    for (var particle in particles) {
      int groupId = particle.id % 10;
      double groupAvg = groupAverages[groupId] ?? targetTime;
      
      // Intelligent move: group average کی طرف
      double intelligentStep = (groupAvg - particle.currentTime) * 0.3;
      particle.currentTime += intelligentStep;
      
      // Target کی طرف بھی move
      double targetStep = (targetTime - particle.currentTime) * 0.2;
      particle.currentTime += targetStep;
      
      // Check stability
      if ((particle.currentTime - targetTime).abs() > 1.0) {
        allStable = false;
      }
    }
    
    return allStable;
  }
  
  // Performance metrics
  double get efficiency {
    if (attempts == 0) return 0;
    return 1.0 / attempts;
  }
  
  String get status {
    double diff = (currentTime - targetTime).abs();
    if (diff < 0.5) return "Perfect";
    if (diff < 2.0) return "Good";
    if (diff < 5.0) return "Average";
    return "Poor";
  }
}
