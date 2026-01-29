import 'dart:math';

/// 🏢 یہ "دماغ = ڈیٹا سینٹر" ماڈل ہے
/// سب کچھ میموری میں رکھتا ہے
class BrainDatacenterParticle {
  final int id;
  
  // ڈیٹا سینٹر: بڑا میموری بینک
  final List<double> memoryBank = [];
  final int maxMemory = 1000; // 1000 ڈیٹا پوائنٹس
  
  double currentState = 0.0;
  final double targetState = 1.0;
  
  BrainDatacenterParticle(this.id) {
    // میموری بینک بھریں
    for (int i = 0; i < maxMemory; i++) {
      memoryBank.add(Random().nextDouble());
    }
  }
  
  /// 🏢 ڈیٹا سینٹر طریقہ: سب کچھ یاد رکھے
  void applyDatacenterLogic() {
    // 1. ڈیٹا جمع کریں
    _collectMoreData();
    
    // 2. ڈیٹا پر پروسیسنگ کریں
    _processAllData();
    
    // 3. نتائج میموری میں محفوظ کریں
    _storeResults();
    
    // 4. تمام ڈیٹا کا تجزیہ کریں
    currentState = _analyzeAllData();
  }
  
  void _collectMoreData() {
    // مزید ڈیٹا جمع کریں
    memoryBank.add(Random().nextDouble());
    
    // میموری کو حد میں رکھیں
    if (memoryBank.length > maxMemory) {
      memoryBank.removeAt(0);
    }
  }
  
  void _processAllData() {
    // تمام ڈیٹا پر بھاری پروسیسنگ
    for (int i = 0; i < memoryBank.length; i++) {
      // مصنوعی بوجھ (GPU کی طرح)
      memoryBank[i] = sin(memoryBank[i]) * cos(memoryBank[i]);
    }
  }
  
  void _storeResults() {
    // نتائج کو میموری کے آخر میں شامل کریں
    final result = memoryBank.reduce((a, b) => a + b) / memoryBank.length;
    memoryBank.add(result);
  }
  
  double _analyzeAllData() {
    // تمام ڈیٹا کا تجزیہ
    double sum = 0;
    for (var data in memoryBank) {
      sum += data;
    }
    
    final average = sum / memoryBank.length;
    return targetState + (average - 0.5);
  }
  
  /// کارکردگی میٹرکس
  Map<String, dynamic> get metrics {
    return {
      'id': id,
      'memory_usage_kb': memoryBank.length * 0.008,
      'data_points': memoryBank.length,
      'processing_load': memoryBank.length * 0.001,
      'state': currentState,
    };
  }
}
