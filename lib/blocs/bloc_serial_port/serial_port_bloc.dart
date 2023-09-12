import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/models/model_pyserial.dart';

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

  void _onInit(SerialPortInit event, Emitter<SerialPortState> emit) {
    debugPrint("?????");

    emit(state.copyWith(
      portName: 'not_selected'.tr(),
    ));
  }

  void _onOpen(SerialPortOpen event, Emitter<SerialPortState> emit) {
    if (!state.isOpened) {
      // TODO
      // Try open port
      emit(state.copyWith(
        isOpened: true,
      ));
    }
  }

  void _onClose(SerialPortClose event, Emitter<SerialPortState> emit) {
    if (state.isOpened) {
      // TODO
      // Try close port
      emit(state.copyWith(
        isOpened: false,
      ));
    }
  }

  void _onUpdateAvailablePorts(SerialPortUpdateAvailablePorts event,
      Emitter<SerialPortState> emit) async {

    // Get availbale ports
    var ports = await ModelPySerial.getAvailabelPorts();

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
