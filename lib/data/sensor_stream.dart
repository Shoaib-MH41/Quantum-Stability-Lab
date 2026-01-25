import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class SensorStream {
  // سینسر ڈیٹا کی structure
  class SensorData {
    DateTime timestamp;
    double npuTime;
    double light;
    double magnetic;
    
    SensorData({
      required this.timestamp,
      required this.npuTime,
      required this.light,
      required this.magnetic,
    });
  }
  
  // ڈیٹا کو سننے والا
  final StreamController<SensorData> _controller = 
      StreamController<SensorData>.broadcast();
  
  Stream<SensorData> get stream => _controller.stream;
  
  // سینسرز سے ڈیٹا لینا شروع کریں
  void startListening() {
    // روشنی سینسر
    lightSensorEvents.listen((event) {
      // مقناطیسی سینسر
      magnetometerEvents.listen((magEvent) {
        // NPU وقت (ابھی mock ڈیٹا)
        double mockNpuTime = 20 + (DateTime.now().millisecond % 40).toDouble();
        
        var data = SensorData(
          timestamp: DateTime.now(),
          npuTime: mockNpuTime,
          light: event.light,
          magnetic: magEvent.x.abs() + magEvent.y.abs() + magEvent.z.abs(),
        );
        
        _controller.add(data);
      });
    });
  }
  
  void stopListening() {
    _controller.close();
  }
}
