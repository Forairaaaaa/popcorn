import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

/// Model [pySerial]
/// Use pySerial for serial backend
final class ModelPySerial {
  /// [Paths]
  static const String pathGetAvailabelPorts =
      'py_scripts/serial_port/get_available_ports.py';

  /// [Get port list]
  static Future<List<String>> getAvailabelPorts() async {
    // start process
    var process = await Process.start('python', [pathGetAvailabelPorts]);
    var exitCode = await process.exitCode;

    // Check exit code
    if (exitCode == 0) {
      String output = '';

      // Read std out
      await process.stdout.transform(utf8.decoder).forEach((element) {
        debugPrint(element);
        output = element;
      });

      // Split to list and return
      return output.split(',');
    }

    return [];
  }
}
