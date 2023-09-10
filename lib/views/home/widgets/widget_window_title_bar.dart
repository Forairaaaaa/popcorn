import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';
import 'package:popcorn/common/popcorn_common.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WidgetWindowTitleBar extends StatelessWidget {
  const WidgetWindowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            // Place to drag window
            Expanded(
              child: MoveWindow(
                  child: Padding(
                // Gap to the control panel
                padding:
                    const EdgeInsets.only(left: PopcornCommon.gap2ControlPanel),
                // Alignment left
                child: Container(
                  alignment: Alignment.centerLeft,
                  // Status label
                  child: const _TitleBarLabel(),
                ),
              )),
            ),

            // Window control buttons
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Button style
    const buttonStyle = ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(10, 10)),
        padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        )));

    // Row of three buttons
    return Row(
      children: [
        // Button minimize
        SizedBox(
          width: 47,
          height: 32,
          child: TextButton(
            style: buttonStyle,
            child: Icon(
              Icons.remove_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            onPressed: () => appWindow.minimize(),
          ),
        ),

        // Button the middle one
        SizedBox(
          width: 47,
          height: 32,
          child: TextButton(
            style: buttonStyle,
            child: Icon(
              Icons.crop_square_rounded,
              size: 15,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            onPressed: () => appWindow.maximizeOrRestore(),
          ),
        ),

        // Button close
        SizedBox(
          width: 47,
          height: 32,
          child: TextButton(
            style: buttonStyle,
            child: Icon(
              Icons.close_rounded,
              size: 19,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            onPressed: () => appWindow.close(),
          ),
        ),
      ],
    );
  }
}

class _TitleBarLabel extends StatefulWidget {
  const _TitleBarLabel();

  @override
  State<_TitleBarLabel> createState() => _TitleBarLabelState();
}

class _TitleBarLabelState extends State<_TitleBarLabel> {
  AnimationController? animController;
  String statusLabel = '';

  void updateStatusLabel(bool isOpened, String portName) {
    statusLabel = isOpened ? '🟢 $portName' : '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SerialPortBloc, SerialPortState>(
      
      // Only rebuild when open state changed 
      listenWhen: (previous, current) {
        return current.isOpened != previous.isOpened;
      },

      // Listen state changed
      listener: (context, state) {
        updateStatusLabel(state.isOpened, state.portName);
        // Reset text and anim
        setState(() {
          animController?.reset();
          animController?.forward();
        });
      },

      child: Text(
        // "🟢 COM23",
        // "🟡 /dev/tty114514",
        statusLabel,
        style: TextStyle(
          fontFamily: 'Noto Sans Mono',
          color: Theme.of(context).colorScheme.outline,
          fontWeight: FontWeight.w600,
        ),
      ).animate(
        onInit: (controller) {
          // Store controller
          animController = controller;
        },
      ).fade(duration: 400.ms),
    );
  }
}
