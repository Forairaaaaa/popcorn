part of 'serial_port_bloc.dart';

@immutable
sealed class SerialPortEvent {}

/// Events
/// Open port
final class SerialPortOpen extends SerialPortEvent {}

/// Close port
final class SerialPortClose extends SerialPortEvent {}

/// Update availabel serial ports
final class SerialPortUpdateAvailablePorts extends SerialPortEvent {}

/// Set port name
final class SerialPortSetPortName extends SerialPortEvent {}

/// Set baudrate
final class SerialPortSetBaudRate extends SerialPortEvent {}
