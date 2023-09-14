import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';
import 'model_serial_port.dart';

///
/// [ModelSerialPort] with pySerial backend
///
final class ModelSerialPortPySerial extends ModelSerialPort {
  /// [Paths]
  final String pathGetAvailabelPorts =
      'py_scripts/pyserial/get_available_ports.py';
  final String pathStartSerialPort =
      'py_scripts/pyserial/start_serial_port.py';

  @override
  String get backendType => 'pySerial';

  static const _utf8Decoder = Utf8Decoder(allowMalformed: true);

  @override
  Future<List<String>> getAvailabelPorts() async {
    // start process
    var process = await Process.start('python', [pathGetAvailabelPorts]);
    var exitCode = await process.exitCode;

    // Check exit code
    if (exitCode == 0) {
      String output = '';

      // Read std out
      await process.stdout.transform(_utf8Decoder).forEach((element) {
        // debugPrint(element);
        output = element;
      });

      // Split to list and return
      return output.split(',');
    }

    return [];
  }

  @override
  Future<List<String>> getAvailabelPortDescription() async {
    // start process
    var process = await Process.start('python', [pathGetAvailabelPorts, '-d'],
        runInShell: true);
    var exitCode = await process.exitCode;

    // Check exit code
    if (exitCode == 0) {
      String output = '';

      // Read std out
      await process.stdout.transform(_utf8Decoder).forEach((element) {
        // debugPrint(element);
        output = element;
      });

      // Split to list and return
      return output.split(',');
    }

    return [];
  }

  // Process buffer of py serial tcp redirection 
  Process? _pySerialProcess;


  @override
  Future<bool> open(SerialPortState state) async {
    try {
      // start process
      _pySerialProcess = await Process.start('python', [
        pathStartSerialPort, 
        '-p', state.portName, 
        '-b', state.baudRate.toString()
      ]);
      
      // Debug output 
      _pySerialProcess!.stdout.transform(_utf8Decoder).forEach((element) {
        debugPrint(element);
      });
      _pySerialProcess!.stderr.transform(_utf8Decoder).forEach((element) {
        debugPrint(element);
      });


    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }

  @override
  Future<bool> close() async {

    _pySerialProcess!.kill();

    var exitCode = await _pySerialProcess!.exitCode;
    debugPrint('$exitCode');
    
    return true;
  }
}
