import 'dart:async';

import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';


/// Abstract class of model serial port
/// Aim to injection with differet serial port backend
class ModelSerialPort {

  /// Backend type 
  String get backendType => 'none';

  /// Get available ports
  Future<List<String>> getAvailabelPorts() async {
    return ['COM1', 'COM2333', 'COM114514', '/dev/ttyACM0'];
  }

  /// Get available ports's descriptions 
  Future<List<String>> getAvailabelPortDescription() async {
    return ['11111', '哈哈', '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '爬'];
  }

  /// Open port
  Future<bool> open(SerialPortState state) async {
    _isOpened = true;

    /// Stream some garbage out 
    Timer.periodic(const Duration(seconds: 1), (timer) {
      rxStreamController.sink.add('${DateTime.now()} 啊？\r\n');
      if (!_isOpened) {
        timer.cancel();
      }
    });

    return true;
  }

  /// Close port
  Future<bool> close() async {
    _isOpened = false;
    return true;
  }

  /// Write message via port
  Future<bool> write(String message) async {
    return true;
  }

  /// A simple state buffer
  bool _isOpened = false;
  final rxStreamController = StreamController<String>();

  /// Receive stream
  Stream<String> get receiveStream => rxStreamController.stream;

  /// The last error 
  String lastError = '';
}
