import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


/// A switch to open and close serial port
class WidgetSerialPortSwitch extends StatefulWidget {
  const WidgetSerialPortSwitch({super.key});

  @override
  State<WidgetSerialPortSwitch> createState() => _WidgetSerialPortSwitchState();
}

class _WidgetSerialPortSwitchState extends State<WidgetSerialPortSwitch> {
  bool valueSerialSwitch = false;

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

  // Switch changed callback
  void _onSerialSwitchChanged(bool value) {
    // Try open serial port
    if (value) {
      // TODO
    }
    // Try close serial port
    else {
      // TODO
    }

    // Update state
    setState(() {
      valueSerialSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      // Tool tip settings
      message: 'serial_port'
          .tr(gender: valueSerialSwitch ? "connected" : "disconnect"),
      textStyle: TextStyle(
        fontSize: 18.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      waitDuration: const Duration(milliseconds: 400),

      child: Switch(
        thumbIcon: thumbIconSerialSwitch,
        value: valueSerialSwitch,
        onChanged: _onSerialSwitchChanged,
      ),
    );
  }
}
