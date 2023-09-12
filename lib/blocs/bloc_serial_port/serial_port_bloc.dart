import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port.dart';
import 'package:popcorn/models/model_serial_port/model_serial_port_pyserial.dart';

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

    add(SerialPortInit());
  }

  /// Model serial port
  ModelSerialPort? _modelSerialPort;

  void _onInit(SerialPortInit event, Emitter<SerialPortState> emit) {
    /// Injection
    // _modelSerialPort = ModelSerialPort();
    _modelSerialPort = ModelSerialPortPySerial();
    debugPrint('[ModelSerialPort] injection type: ${_modelSerialPort!.backendType}');

    emit(state.copyWith(
      portName: 'not_selected'.tr(),
    ));
  }

  void _onOpen(SerialPortOpen event, Emitter<SerialPortState> emit) async {
    /// If not opened
    if (!state.isOpened) {
      /// Try open port
      if (await _modelSerialPort!.open(state)) {
        // Update state
        emit(state.copyWith(
          isOpened: true,
        ));
      }
    }
  }

  void _onClose(SerialPortClose event, Emitter<SerialPortState> emit) async {
    /// If not cloesed
    if (state.isOpened) {
      // Try close port
      if (await _modelSerialPort!.close()) {
        // Update state
        emit(state.copyWith(
          isOpened: false,
        ));
      }
    }
  }

  void _onUpdateAvailablePorts(SerialPortUpdateAvailablePorts event,
      Emitter<SerialPortState> emit) async {
    // Get availbale ports
    var ports = await _modelSerialPort!.getAvailabelPorts();

    // Update state
    emit(state.copyWith(availablePorts: ports));
  }

  void _onPortNameChanged(
      SerialPortPortNameChanged event, Emitter<SerialPortState> emit) {
    // Update current  port name
    emit(state.copyWith(
      portName: event.portName,
    ));
  }

  void _onBaudRateChanged(
      SerialPortBaudRateChanged event, Emitter<SerialPortState> emit) {
    // Update current baudrate
    emit(state.copyWith(
      baudRate: event.baudrate,
    ));
  }
}
