import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port_pyserial.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port_libserial.dart';

part 'serial_port_event.dart';
part 'serial_port_state.dart';

class SerialPortBloc extends Bloc<SerialPortEvent, SerialPortState> {
  SerialPortBloc() : super(const SerialPortState()) {
    /// Events
    on<SerialPortInit>(_onInit);
    on<SerialPortOpen>(_onOpen);
    on<SerialPortClose>(_onClose);
    on<SerialPortUpdateAvailablePorts>(_onUpdateAvailablePorts);
    on<SerialPortPortNameChanged>(_onPortNameChanged);
    on<SerialPortBaudRateChanged>(_onBaudRateChanged);
    on<SerialPortReceviedMessage>(_onMesssageReceived);
    on<SerialPortClearReceived>(_onClearRecieved);
    on<SerialPortResetErrorFlag>(_onResetErrorFlag);
    on<SerialPortSendMessage>(_onSendMessage);

    add(SerialPortInit());
  }

  /// Model serial port
  ModelSerialPort? _modelSerialPort;

  /// [On init]
  void _onInit(SerialPortInit event, Emitter<SerialPortState> emit) {
    /// Injection
    // _modelSerialPort = ModelSerialPort();
    _modelSerialPort = ModelSerialPortPySerial();
    // _modelSerialPort = ModelSerialPortLibserial();
    debugPrint(
        '[ModelSerialPort] injection type: ${_modelSerialPort!.backendType}');

    /// Little default state setting
    emit(state.copyWith(
      portName: 'not_selected'.tr(),
    ));
  }

  /// [On open port]
  void _onOpen(SerialPortOpen event, Emitter<SerialPortState> emit) async {
    /// If not opened
    if (!state.isOpened) {
      /// Try open port
      if (await _modelSerialPort!.open(state)) {
        // Update state
        emit(state.copyWith(
          isOpened: true,
        ));

        /// Listen receive stream and attach callback
        _modelSerialPort!.receiveStream.listen((message) {
          add(SerialPortReceviedMessage(message));
        }).onError((e) {
          print(e);
          // Update state
          add(const SerialPortClose());
        });

        return;
      }
    }

    /// Set error flag
    emit(state.copyWith(
      errorFlag: SerialPortErrorFlag.openFailed,
      lastError: _modelSerialPort!.lastError,
    ));
  }

  /// [On close port]
  void _onClose(SerialPortClose event, Emitter<SerialPortState> emit) async {
    /// If not cloesed
    if (state.isOpened) {
      // Try close port
      if (await _modelSerialPort!.close()) {
        // Update state
        emit(state.copyWith(
          isOpened: false,
        ));
        return;
      }
    }

    // /// Set error flag
    // emit(state.copyWith(
    //   // errorFlag: SerialPortErrorFlag.closeFailed,
    //   lastError: _modelSerialPort!.lastError,
    // ));
  }

  /// [On update available ports]
  void _onUpdateAvailablePorts(SerialPortUpdateAvailablePorts event,
      Emitter<SerialPortState> emit) async {
    // Get availbale ports
    var ports = await _modelSerialPort!.getAvailabelPorts();
    // Get descriptions too
    var descs = await _modelSerialPort!.getAvailabelPortDescription();

    // In case this two shit don't match
    if (descs.length != ports.length) {
      descs = ports;
    }

    // Update state
    emit(
        state.copyWith(availablePorts: ports, availablePortDescription: descs));
  }

  /// [On port name changed]
  void _onPortNameChanged(
      SerialPortPortNameChanged event, Emitter<SerialPortState> emit) {
    // Update current  port name
    emit(state.copyWith(
      portName: event.portName,
    ));
  }

  /// [On baudrate changed]
  void _onBaudRateChanged(
      SerialPortBaudRateChanged event, Emitter<SerialPortState> emit) {
    // Update current baudrate
    emit(state.copyWith(
      baudRate: event.baudrate,
    ));
  }

  /// [On messaged received]
  void _onMesssageReceived(
      SerialPortReceviedMessage event, Emitter<SerialPortState> emit) {
    emit(state.copyWith(
      receivedMessage: state.receivedMessage + event.message,
    ));
  }

  /// [Clear recevied messages]
  void _onClearRecieved(
      SerialPortClearReceived event, Emitter<SerialPortState> emit) {
    emit(state.copyWith(
      receivedMessage: '',
    ));
  }

  /// [Reeset error flag]
  void _onResetErrorFlag(
      SerialPortResetErrorFlag event, Emitter<SerialPortState> emit) {
    emit(state.copyWith(errorFlag: SerialPortErrorFlag.none));
  }

  /// [Send message]
  void _onSendMessage(
      SerialPortSendMessage event, Emitter<SerialPortState> emit) {
    // Only write when port is opend 
    if (state.isOpened) {
      _modelSerialPort!.write(event.message);
    }
  }
}
