import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SerialPortBloc, SerialPortState>(
      builder: (context, state) {
        return Tooltip(
          // Tool tip settings
          message:
              'serial_port'.tr(gender: state.isOpened ? "opened" : "closed"),
          textStyle: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          waitDuration: const Duration(milliseconds: 400),

          // A switch with thumb icon :)
          child: Switch(
            thumbIcon: thumbIconSerialSwitch,
            value: state.isOpened,
            // Fire event
            onChanged: (value) {
              if (value) {
                context.read<SerialPortBloc>().add(const SerialPortOpen());
              } else {
                context.read<SerialPortBloc>().add(const SerialPortClose());
              }
            },
          ),
        );
      },
    );
  }
}
