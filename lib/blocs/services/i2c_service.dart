import 'dart:async';
import 'package:dart_periphery/dart_periphery.dart';

class I2CService {
  final I2C i2c;
  final int deviceAddress;
  late Timer _pollingTimer;
  Duration pollingInterval;

  I2CService({
    required this.deviceAddress,
    this.pollingInterval = const Duration(seconds: 1),
  }) : i2c = I2C('/dev/i2c-1');

  // Polling data
  void startPolling(Function(Map<String, double>) onData) {
    _pollingTimer = Timer.periodic(pollingInterval, (_) async {
      try {
        final data = await readSensorData();
        onData(data);
      } catch (e) {
        print('Error polling I2C device: $e');
      }
    });
  }

  void stopPolling() {
    _pollingTimer.cancel();
  }

  Future<Map<String, double>> readSensorData() async {
    // Example: Reading temperature, humidity, and pressure
    // Replace the following with actual I2C commands for your device
    final buffer = List.filled(6, 0);
    i2c.read(deviceAddress, buffer);

    final temperature = (buffer[0] << 8 | buffer[1]) / 100.0;
    final humidity = (buffer[2] << 8 | buffer[3]) / 100.0;
    final pressure = (buffer[4] << 8 | buffer[5]) / 10.0;

    return {
      'temperature': temperature,
      'humidity': humidity,
      'pressure': pressure,
    };
  }

  void dispose() {
    stopPolling();
    i2c.dispose();
  }

  void setPollingInterval(Duration interval) {
    pollingInterval = interval;
    if (_pollingTimer.isActive) {
      stopPolling();
      startPolling((_) {});
    }
  }
}
