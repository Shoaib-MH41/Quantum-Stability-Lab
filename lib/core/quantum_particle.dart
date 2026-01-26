import 'dart:math';
import 'package:flutter/material.dart';

class QuantumParticle {
  final int id;
  double currentTime;
  double targetTime = 35.0;
  int stableCount = 0;
  
  QuantumParticle(this.id) : currentTime = Random().nextDouble() * 50 + 10;
  
  bool get isStable => (currentTime >= 30 && currentTime <= 40);
  bool get isFullyStable => stableCount >= 3;
  
  void apply35msLaw() {
    double adjustment = (targetTime - currentTime) * 0.1;
    currentTime += adjustment;
    
    if (isStable) {
      stableCount = min(stableCount + 1, 3);
    } else {
      stableCount = max(stableCount - 1, 0);
    }
  }
}
