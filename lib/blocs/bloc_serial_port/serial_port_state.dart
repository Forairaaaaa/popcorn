/// Reference:
/// https://github.com/felangel/bloc/blob/master/examples/flutter_login/lib/login/bloc/login_state.dart
part of 'serial_port_bloc.dart';

enum SerialPortErrorFlag {
  none,
  openFailed,
  closeFailed,
}

/// Serial states (port config)
final class SerialPortState extends Equatable {
  const SerialPortState({
    this.isOpened = false,
    this.portName = '',
    this.baudRate = 115200,
    this.availableBaudRateList = const [
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
    this.availablePorts = const [],
    this.availablePortDescription = const [],
    this.receivedMessage = '',
    this.errorFlag = SerialPortErrorFlag.none,
    this.lastError = '',
  });

  /// Is port opened already
  final bool isOpened;

  /// Current port name
  final String portName;

  /// Current baud rate
  final int baudRate;

  /// Available baud rate list
  final List<int> availableBaudRateList;

  /// Available serial ports
  final List<String> availablePorts;

  /// Available serial ports' descriptions
  final List<String> availablePortDescription;

  /// Recived data from serial port
  final String receivedMessage;

  /// A error flag for widget's error anim
  final SerialPortErrorFlag errorFlag;

  final String lastError;

  /// Easy copy
  SerialPortState copyWith({
    bool? isOpened,
    String? portName,
    int? baudRate,
    List<int>? availableBaudRateList,
    List<String>? availablePorts,
    List<String>? availablePortDescription,
    String? receivedMessage,
    SerialPortErrorFlag? errorFlag,
    String? lastError,
  }) {
    return SerialPortState(
      isOpened: isOpened ?? this.isOpened,
      portName: portName ?? this.portName,
      baudRate: baudRate ?? this.baudRate,
      availableBaudRateList:
          availableBaudRateList ?? this.availableBaudRateList,
      availablePorts: availablePorts ?? this.availablePorts,
      availablePortDescription:
          availablePortDescription ?? this.availablePortDescription,
      receivedMessage: receivedMessage ?? this.receivedMessage,
      errorFlag: errorFlag ?? this.errorFlag,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  List<Object?> get props => [
        isOpened,
        portName,
        baudRate,
        availableBaudRateList,
        availablePorts,
        availablePortDescription,
        receivedMessage,
        errorFlag,
        lastError
      ];
}
