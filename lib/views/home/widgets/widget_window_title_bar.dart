import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

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
                child: nameTitle(context),
              ),
            ),

            // Window control buttons
            const WindowButtons(),
          ],
        ),
      ),
    );
  }

  Padding nameTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          "🍿Popcorn",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ]),
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
