import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bme_i2c/blocs/i2c/i2c_cubit.dart';

class I2CScreen extends StatelessWidget {
  final I2CCubit i2cCubit;

  const I2CScreen({Key? key, required this.i2cCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => i2cCubit..startPolling(),
      child: Scaffold(
        appBar: AppBar(title: const Text('I2C Sensor Data')),
        body: BlocBuilder<I2CCubit, I2CState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Temperature: ${state.temperature.toStringAsFixed(2)} °C'),
                Text('Humidity: ${state.humidity.toStringAsFixed(2)} %'),
                Text('Pressure: ${state.pressure.toStringAsFixed(2)} hPa'),
              ],
            );
          },
        ),
      ),
    );
  }
}
