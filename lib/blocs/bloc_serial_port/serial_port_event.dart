part of 'serial_port_bloc.dart';

sealed class SerialPortEvent extends Equatable {
  const SerialPortEvent();

  @override
  List<Object?> get props => [];
}

///
/// [Events]
/// 
/// [Init] 
final class SerialPortInit extends SerialPortEvent {}

/// [Open port]
final class SerialPortOpen extends SerialPortEvent {
  const SerialPortOpen();
}

/// [Close port]
final class SerialPortClose extends SerialPortEvent {
  const SerialPortClose();
}

/// [Update availabel serial ports]
final class SerialPortUpdateAvailablePorts extends SerialPortEvent {
  const SerialPortUpdateAvailablePorts();
}

/// [Set port name]
final class SerialPortPortNameChanged extends SerialPortEvent {
  const SerialPortPortNameChanged(this.portName);
  final String portName;

  @override
  List<Object?> get props => [portName];
}

/// [Set baudrate]
final class SerialPortBaudRateChanged extends SerialPortEvent {
  const SerialPortBaudRateChanged(this.baudrate);
  final int baudrate;

  @override
  List<Object?> get props => [baudrate];
}

/// [Get serial message]
final class SerialPortReceviedMessage extends SerialPortEvent {
  const SerialPortReceviedMessage(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

/// [Clear received buffer]
final class SerialPortClearReceived extends SerialPortEvent {
  const SerialPortClearReceived();
}

/// [Reset error flag]
final class SerialPortResetErrorFlag extends SerialPortEvent {
  const SerialPortResetErrorFlag();
}

/// [Send message]
final class SerialPortSendMessage extends SerialPortEvent {
  const SerialPortSendMessage(this.message);
  final String message;
  
  @override
  List<Object?> get props => [message];
}
