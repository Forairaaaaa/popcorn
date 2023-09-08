import 'package:flutter/material.dart';

/// Model to provide serial port's shit
class ModelSerialPort extends ChangeNotifier {
  
  /// Port name
  String _portName = '???';

  /// Get port name
  String get portName => _portName;

  /// Set port name
  set portName(String portName) {
    _portName = portName;
    notifyListeners();
  }

  /// Baud rate
  int _baudRate = 115200;

  /// Get baud rate 
  int get baudRate => _baudRate;

  /// Set baud rate 
  set baudRate(int baudRate) {
    _baudRate = baudRate;
    notifyListeners();
  }

  /// Connect state
  bool __isConnected = false;

  /// Connect state update with notify
  set _isConnected(bool value) {
    __isConnected = value;
    notifyListeners();
  }

  /// Is port conected
  bool get isConnected => __isConnected;

  /// Available baudrate list
  List<int> availableBaudRateList = [
    300,
    600,
    1200,
    2400,
    4800,
    9600,
    14400,
    19200,
    38400,
    56000,
    57600,
    115200,
    128000,
    256000,
    460800,
    512000,
    750000,
    921600,
    1500000,
  ];

  /// Get available serial port list
  List<String> get availablePortList {
    // TODO
    return [
      "COM1",
      "COM23",
      "COM23",
      "COM23",
      "COM23",
      "COM23",
      "COM23",
      "COM114514",
      "/dev/ttyACM0"
    ];
  }

  /// Open the port
  void open() {
    if (!isConnected) {
      // TODO
      _isConnected = true;
    }
  }

  /// Close the port
  void close() {
    if (isConnected) {
      // TODO
      _isConnected = false;
    }
  }

  /// Write data to the port
  void write(String data) {
    // TODO
  }

  String _rxBuffer = '';

  /// Received data buffer
  String get rxBuffer => _rxBuffer;
}
