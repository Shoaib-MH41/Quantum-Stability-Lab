class QuantumParticle {
  final int id;
  double currentTime;
  int stabilityCount;
  bool isStable;
  
  QuantumParticle(this.id) {
    currentTime = 20 + (id * 3 % 20).toDouble();
    stabilityCount = 0;
    isStable = false;
  }
  
  // 35ms قانون کا اطلاق
  void apply35msLaw() {
    // اتفاق (بوہر) - random quantum behavior
    double quantumFluctuation = (DateTime.now().microsecond % 100 - 50) / 10.0;
    currentTime += quantumFluctuation;
    
    // قانون (آئنسٹائن) - 35ms کی طرف لے جانا
    if (currentTime < 30) {
      currentTime += (35 - currentTime) * 0.3;
    } else if (currentTime > 40) {
      currentTime -= (currentTime - 35) * 0.3;
    }
    
    // استحکام چیک کریں
    isStable = currentTime >= 30 && currentTime <= 40;
    if (isStable) {
      stabilityCount++;
    } else {
      stabilityCount = 0;
    }
  }
  
  // مکمل stable ہونے کے لیے
  bool get isFullyStable => stabilityCount >= 3;
}
