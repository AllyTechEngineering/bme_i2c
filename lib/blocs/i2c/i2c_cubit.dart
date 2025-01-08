import 'package:bme_i2c/blocs/services/i2c_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'i2c_state.dart';


class I2CCubit extends Cubit<I2CState> {
  final I2CService i2cService;

  I2CCubit(this.i2cService)
      : super(const I2CState(temperature: 0.0, humidity: 0.0, pressure: 0.0));

  void startPolling() {
    i2cService.startPolling((data) {
      emit(state.copyWith(
        temperature: data['temperature'],
        humidity: data['humidity'],
        pressure: data['pressure'],
      ));
    });
  }

  void stopPolling() {
    i2cService.stopPolling();
  }

  void setPollingInterval(Duration interval) {
    i2cService.setPollingInterval(interval);
  }

  @override
  Future<void> close() {
    i2cService.dispose();
    return super.close();
  }
}
