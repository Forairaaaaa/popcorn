import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';

/// A switch to open and close serial port,
/// Depends on [ModelSerialPort]
class WidgetSwitchSerialPort extends StatefulWidget {
  const WidgetSwitchSerialPort({super.key});

  @override
  State<WidgetSwitchSerialPort> createState() => _WidgetSwitchSerialPortState();
}

class _WidgetSwitchSerialPortState extends State<WidgetSwitchSerialPort> {
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
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return Tooltip(
          // Tool tip settings
          message: 'serial_port'
              .tr(gender: model.isConnected ? "connected" : "disconnect"),
          textStyle: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          waitDuration: const Duration(milliseconds: 400),

          // A switch with thumb icon :)
          child: Switch(
            thumbIcon: thumbIconSerialSwitch,
            value: model.isConnected,
            onChanged: (value) {
              if (value) {
                model.open();
              } else {
                model.close();
              }
            },
          ),
        );
      },
    );
  }
}
