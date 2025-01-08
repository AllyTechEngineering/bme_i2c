import 'package:bme_i2c/blocs/screens/i2c_screen.dart';
import 'package:flutter/material.dart';
import 'blocs/i2c/i2c_cubit.dart';
import 'blocs/services/i2c_service.dart';

void main() {
  final i2cService = I2CService(deviceAddress: 0x76);
  final i2cCubit = I2CCubit(i2cService);

  runApp(MyApp(i2cCubit: i2cCubit));
}

class MyApp extends StatelessWidget {
  final I2CCubit i2cCubit;

  const MyApp({Key? key, required this.i2cCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: I2CScreen(i2cCubit: i2cCubit),
    );
  }
}
