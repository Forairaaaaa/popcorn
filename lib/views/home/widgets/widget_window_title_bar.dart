import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';
import 'package:popcorn/models/model_widget_configs.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Window title bar, with status label, window control buttons 
class WidgetWindowTitleBar extends StatelessWidget {
  const WidgetWindowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: SizedBox(
        height: ModelWidgetConfigs.windowTitleBarHeight,
        child: Row(
          children: [
            // Place to drag window
            Expanded(
              child: MoveWindow(
                  child: Padding(
                // Gap to the control panel
                padding:
                    const EdgeInsets.only(left: ModelWidgetConfigs.gap2ControlPanel),
                // Alignment left
                child: Container(
                  alignment: Alignment.bottomLeft,
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

    // Row of three buttons
    return Row(
      children: [
        // Button minimize
        SizedBox(
          width: 47,
          height: 32,
          child: TextButton(
            style: ModelWidgetConfigs.windowControlButtonStyle,
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
            style: ModelWidgetConfigs.windowControlButtonStyle,
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
            style: ModelWidgetConfigs.windowControlButtonStyle,
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
        // Set text and play anim
        setState(() {
          animController?.reset();
          animController?.forward();
        });
      },

      child: Text(
        // "🟢 COM23",
        // "🟡 /dev/tty114514",
        statusLabel,
        style: ModelWidgetConfigs.windowTitleBarStatusLabelTextStyle(context),
      ).animate(
        onInit: (controller) {
          // Store controller
          animController = controller;
        },
      ).fade(duration: 400.ms),
    );
  }
}
