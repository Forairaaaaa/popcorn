part of 'serial_port_bloc.dart';

/// State data
sealed class SerialPortState {
  SerialPortState({
    required this.isConnected,
    required this.portName,
    required this.baudRate,
    required this.labelStatus,
    required this.availableBaudRateList,
    required this.availablePorts,
  });
  bool isConnected;
  String portName;
  int baudRate;
  String labelStatus;
  List<int> availableBaudRateList;
  List<String> availablePorts;
}

/// Default state
final class SerialPortInitial extends SerialPortState {
  SerialPortInitial({
    super.isConnected = false,
    super.portName = '',
    super.baudRate = 115200,
    super.labelStatus = '',
    super.availableBaudRateList = const [
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
    ],
    super.availablePorts = const [],
  });
}
