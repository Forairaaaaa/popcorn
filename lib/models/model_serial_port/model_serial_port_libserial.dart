import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port_pyserial.dart';
import 'model_serial_port.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

///
/// [ModelSerialPort] with serial port libserial backend
///
final class ModelSerialPortLibserial extends ModelSerialPort {
  @override
  String get backendType => 'libserial';

  @override
  Future<List<String>> getAvailabelPorts() async {
    // Use py to save output encoding shit
    var borrowPySerial = ModelSerialPortPySerial();
    return borrowPySerial.getAvailabelPorts();
  }

  @override
  Future<List<String>> getAvailabelPortDescription() async {
    // Use py to save output encoding shit
    var borrowPySerial = ModelSerialPortPySerial();
    return borrowPySerial.getAvailabelPortDescription();
  }

  // Libserial buffer
  SerialPort? _libSerialPort;

  @override
  Future<bool> open(SerialPortState state) async {
    // Try open
    try {
      // Create
      _libSerialPort = SerialPort(state.portName);

      // Config
      var config = SerialPortConfig();
      config.baudRate = state.baudRate;
      config.bits = 8;
      config.parity = SerialPortParity.none;
      config.stopBits = 1;
      config.setFlowControl(0);
      _libSerialPort!.config = config;
      // config.dispose();  

      // Open I/O
      if (!_libSerialPort!.openReadWrite()) {
        throw (ArgumentError(SerialPort.lastError));
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(_getErrorMessage(SerialPort.lastError?.errorCode));
      return false;
    }

    return true;
  }

  @override
  Future<bool> close() async {
    try {
      // Close port
      if (!_libSerialPort!.close()) {
        throw (ArgumentError(SerialPort.lastError));
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(_getErrorMessage(SerialPort.lastError?.errorCode));
      return false;
    }

    return true;
  }

  @override
  Future<bool> write(String message) async {
    _libSerialPort!.write(Uint8List.fromList(utf8.encode(message)));
    return true;
  }

  /// Avoid system character encoding shit
  String _getErrorMessage(int? errno) {
    String message = 'errno_unknow';

    if (errno == 2) {
      message = 'errno_invalid_port';
    } else if (errno == 5) {
      message = 'errno_is_in_use';
    }

    lastError = 'serial_port'.tr(gender: message);
    return lastError;
  }

  /// Raw stream
  Stream<Uint8List> get rxStreamRaw => SerialPortReader(_libSerialPort!).stream;

  @override
  Stream<String> get receiveStream => rxStreamRaw
      .map((event) => utf8.decode(event, allowMalformed: true))
      .asBroadcastStream();

  
  // final _transformer = StreamTransformer<Uint8List, String>.fromHandlers(
  //   handleData: (data, sink) {
  //     // TODO 
  //     // Convect not good 
  //     var message = utf8.decode(data, allowMalformed: true);
  //     sink.add(message);
  //   },
  // );

  // @override
  // Stream<String> get receiveStream => rxStreamRaw
  //     .transform(_transformer);

}
