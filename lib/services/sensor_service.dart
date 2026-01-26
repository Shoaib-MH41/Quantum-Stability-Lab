import 'package:sensors_plus/sensors_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SensorService {
  final Battery _battery = Battery();
  
  Stream<AccelerometerEvent> get accelerometer => accelerometerEvents;
  Stream<GyroscopeEvent> get gyroscope => gyroscopeEvents;
  Stream<MagnetometerEvent> get magnetometer => magnetometerEvents;
  
  Future<double> getBatteryLevel() async {
    return (await _battery.batteryLevel).toDouble();
  }
  
  Future<BatteryState> getBatteryState() async {
    return await _battery.batteryState;
  }
  
  Future<ConnectivityResult> getConnectivity() async {
    return await Connectivity().checkConnectivity();
  }
}
