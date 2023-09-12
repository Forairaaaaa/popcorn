import 'dart:convert';
import 'dart:io';
import 'model_serial_port.dart';

/// [ModelSerialPort] with pySerial backend
final class ModelSerialPortPySerial extends ModelSerialPort {
  /// [Paths]
  final String pathGetAvailabelPorts =
      'py_scripts/pyserial/get_available_ports.py';

  @override
  String get backendType => 'pySerial';

  /// [Get port list]
  @override
  Future<List<String>> getAvailabelPorts() async {
    // start process
    var process = await Process.start('python', [pathGetAvailabelPorts]);
    var exitCode = await process.exitCode;

    // Check exit code
    if (exitCode == 0) {
      String output = '';

      // Read std out
      await process.stdout.transform(utf8.decoder).forEach((element) {
        // debugPrint(element);
        output = element;
      });

      // Split to list and return
      return output.split(',');
    }

    return [];
  }
}
