import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';

/// A switch to open and close serial port
/// Binding [SerialPortBloc]
class WidgetPortSwitch extends StatefulWidget {
  const WidgetPortSwitch({super.key});

  @override
  State<WidgetPortSwitch> createState() => _WidgetPortSwitchState();
}

class _WidgetPortSwitchState extends State<WidgetPortSwitch> {
  // State property icon
  final MaterialStateProperty<Icon?> thumbIconSerialSwitch =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  bool _isOpened = false;
  AnimationController? _animController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SerialPortBloc, SerialPortState>(
      /// Rebuild when flag or open state changed
      listenWhen: (previous, current) {
        return (previous.errorFlag != current.errorFlag) ||
            (previous.isOpened != current.isOpened);
      },

      listener: (context, state) {
        setState(() {
          // Update open state 
          _isOpened = state.isOpened;

          // If get error flag 
          if (state.errorFlag == SerialPortErrorFlag.openFailed ||
              state.errorFlag == SerialPortErrorFlag.closeFailed) {
            // Shake the switch
            _animController?.reset();
            _animController?.forward();
            context.read<SerialPortBloc>().add(const SerialPortResetErrorFlag());
          }
        });
      },

      child: Tooltip(
        // Tool tip settings
        message: 'serial_port'.tr(gender: _isOpened ? "opened" : "closed"),
        textStyle: TextStyle(
          fontSize: 18.0,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        waitDuration: const Duration(milliseconds: 400),

        // A switch with thumb icon :)
        child: Switch(
          thumbIcon: thumbIconSerialSwitch,
          value: _isOpened,
          // Fire event
          onChanged: (value) {
            if (value) {
              context.read<SerialPortBloc>().add(const SerialPortOpen());
            } else {
              context.read<SerialPortBloc>().add(const SerialPortClose());
            }
          },
        ),
      )
          .animate(
            autoPlay: false,
            // Copy controller
            onInit: (controller) {
              _animController = controller;
            },
          )
          .shake(),
    );
  }
}
