import 'dart:math';

/// 🔑 یہ آپ کا "دماغ = کی بورڈ" ماڈل ہے
/// صرف کنیکشنز رکھتا ہے، ڈیٹا نہیں
class BrainKeyboardParticle {
  final int id;
  
  // کی بورڈ کی طرح: کنیکشن ویٹس
  final Map<String, double> synapticWeights = {};
  
  // ڈیٹا سینٹر نہیں: کوئی بڑا میموری بینک نہیں
  // List<double> memoryBank = []; ❌ نہیں!
  
  double currentState = 0.0;
  final double targetState = 1.0;
  
  BrainKeyboardParticle(this.id) {
    // ابتدائی کنیکشنز بنائیں
    _initializeSynapticConnections();
  }
  
  void _initializeSynapticConnections() {
    // 10 کلیدی کنیکشنز (کی بورڈ کی طرح)
    for (int i = 0; i < 10; i++) {
      synapticWeights['key_$i'] = Random().nextDouble();
    }
  }
  
  /// 🔬 نیا: کی بورڈ طریقہ - صرف کنیکشنز استعمال کرے
  void applyKeyboardLogic() {
    // 1. موجودہ کنیکشن ویٹس کو اپ ڈیٹ کریں
    _updateSynapticWeights();
    
    // 2. نئے کنیکشنز بنائیں (سیکھنا)
    _formNewConnections();
    
    // 3. پرانے کنیکشنز کمزور کریں (بھولنا)
    _weakenOldConnections();
    
    // 4. کنیکشن نیٹ ورک سے فیصلہ کریں
    currentState = _decideFromConnections();
  }
  
  double _decideFromConnections() {
    // تمام کنیکشنز کا مجموعی اثر
    double totalEffect = 0.0;
    
    synapticWeights.forEach((key, weight) {
      // ہر کنیکشن کا حصہ ڈالیں
      totalEffect += weight * (Random().nextDouble() - 0.5);
    });
    
    // کنیکشن کی اوسط طاقت
    final averageWeight = synapticWeights.values.reduce((a, b) => a + b) 
                         / synapticWeights.length;
    
    return targetState + (totalEffect * averageWeight);
  }
  
  void _updateSynapticWeights() {
    // کنیکشنز کو تجربے کے مطابق ایڈجسٹ کریں
    synapticWeights.updateAll((key, weight) {
      return weight + (Random().nextDouble() * 0.1 - 0.05);
    });
  }
  
  void _formNewConnections() {
    // 10% امکان نیا کنیکشن بنانے کا
    if (Random().nextDouble() < 0.1) {
      final newKey = 'new_key_${synapticWeights.length}';
      synapticWeights[newKey] = Random().nextDouble() * 0.5;
    }
  }
  
  void _weakenOldConnections() {
    // 5% امکان پرانا کنیکشن کمزور کرنے کا (بھولنا)
    synapticWeights.updateAll((key, weight) {
      if (Random().nextDouble() < 0.05) {
        return weight * 0.9; // 10% کمزور
      }
      return weight;
    });
  }
  
  /// کارکردگی میٹرکس
  Map<String, dynamic> get metrics {
    return {
      'id': id,
      'connection_count': synapticWeights.length,
      'average_weight': synapticWeights.values.reduce((a, b) => a + b) 
                        / synapticWeights.length,
      'memory_usage_kb': synapticWeights.length * 0.008, // تخمینہ
      'state': currentState,
    };
  }
}
