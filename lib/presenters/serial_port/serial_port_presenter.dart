
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:convert';
import 'dart:typed_data';

/// Singletons pattern
/// (https://flutterbyexample.com/lesson/singletons)
class SerialPortPresenter {
  static final SerialPortPresenter _instance = SerialPortPresenter._internal();

  factory SerialPortPresenter() {
    return _instance;
  }

  // initialization logic 
  SerialPortPresenter._internal() {
    // Set up default config 
    _serialPortConfig.baudRate = 115200;
    _serialPortConfig.bits = 8;
    _serialPortConfig.parity = SerialPortParity.none;
    _serialPortConfig.stopBits = 1;
  }


  /// Internal members 
  static SerialPort? _serialPort;
  static final SerialPortConfig _serialPortConfig = SerialPortConfig();
  static bool _isSerialPortOpened = false;


  /// Is serial port opened already 
  bool get isOpened => _isSerialPortOpened;

  /// Get available serial ports 
  List<String> get availablePorts => SerialPort.availablePorts;
  
  /// Open serial port
  void open(String portName) {
    if (!_isSerialPortOpened) {
      // Reset flag 
      _isSerialPortOpened = true;
      // Open and set config 
      _serialPort = SerialPort(portName);
      _serialPort?.openReadWrite();
      _serialPort?.config = _serialPortConfig;
    }
  }

  /// Close serial port 
  void close() {
    if (_isSerialPortOpened) {
      // Reset flag 
      _isSerialPortOpened = false;
      // Close port
      _serialPort?.dispose();
    }
  }

  /// Get serial port's description 
  String? getPortDescription() {
    if (_isSerialPortOpened) {
      return _serialPort?.description;
    }
    return null;
  }

  /// Write message to serial port 
  void write(String msg) {
    if (_isSerialPortOpened) {
      // Encoder to ascii 
      _serialPort?.write(ascii.encode(msg));
    }
  }

  /// Rx raw data stream 
  Stream<Uint8List> get rxStreamRaw => SerialPortReader(_serialPort!).stream;

  /// Rx stream, decoded to string 
  Stream<String> get rxStream => rxStreamRaw.map((event) => ascii.decode(event)).asBroadcastStream();
}

