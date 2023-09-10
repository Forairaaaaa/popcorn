import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/common/popcorn_common.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {

    
        return Text(
          // "🟢COM23",
          // "🟡/dev/tty114514",
          model.labelStatus,
          style: TextStyle(
            fontFamily: 'Noto Sans Mono',
            color: Theme.of(context).colorScheme.outline,
            fontWeight: FontWeight.w600,
          ),
        ).animate(
          autoPlay: true
        ).fadeIn();
      },
    );
  }
}
