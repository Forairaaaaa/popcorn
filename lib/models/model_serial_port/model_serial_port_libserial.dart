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
      _libSerialPort!.config = config;
      config.dispose();

      // Open I/O 
      if (!_libSerialPort!.openReadWrite()) {
        throw(ArgumentError(SerialPort.lastError));
      }

    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }

  @override
  Future<bool> close() async {
    try {
      // Close port 
      if (!_libSerialPort!.close()) {
        throw(ArgumentError(SerialPort.lastError));
      }
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }
}
