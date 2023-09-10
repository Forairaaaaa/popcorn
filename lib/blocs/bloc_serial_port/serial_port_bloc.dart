import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'serial_port_event.dart';
part 'serial_port_state.dart';

class SerialPortBloc extends Bloc<SerialPortEvent, SerialPortState> {
  SerialPortBloc() : super(SerialPortInitial()) {

    /// Open port 
    on<SerialPortOpen>((event, emit) {
      if (!state.isConnected) {
        state.isConnected = true;
        emit(state);
      }
    },);

    /// Close port 
    on<SerialPortClose>((event, emit) {
      if (state.isConnected) {
        state.isConnected = false;
        emit(state);
      }
    },);

    /// Update availabel serial ports 
    on<SerialPortUpdateAvailablePorts>((event, emit) {
      
    },);

    /// Set port name 
    on<SerialPortSetPortName>((event, emit) {
      
    },);

    /// Set baudrate 
    on<SerialPortSetBaudRate>((event, emit) {
      
    },);


  }

}
