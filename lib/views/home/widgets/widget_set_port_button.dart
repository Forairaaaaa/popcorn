import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


/// A button with menu to select serial port name
class WidgetSetPortButton extends StatefulWidget {
  const WidgetSetPortButton({super.key});

  @override
  State<WidgetSetPortButton> createState() =>
      _WidgetSetPortButtonState();
}

class _WidgetSetPortButtonState extends State<WidgetSetPortButton> {

  // Available serial port name list
  List<String> portNameList = ["COM1", "COM23", "COM114514", "/dev/ttyACM0"];

  // Current selected port name
  String selectedPortName = 'not_selected'.tr();

  // Current selected index
  int? _selectedIndex;


  // Callback when menu about to open
  void _menuOpenCallback() {
    // Update vaild serial port list
    // TODO

    setState(() {
      portNameList.add("👍");
    });
  }

  // Callback when serial port selected
  void _menuItemSelectedCallback(int index) {
    setState(() {
      // Update selected index
      _selectedIndex = index;
      // Update selected port name
      selectedPortName = portNameList[index];
    });
  }


  @override
  Widget build(BuildContext context) {
    // Use menu anchor
    // https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return MenuAnchor(
      // Offset the menu a little bit
      alignmentOffset: const Offset(0.0, 8.0),

      // Menu builder
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        // Tool tip: show current port name
        return Tooltip(
          message: selectedPortName,
          textStyle: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          waitDuration: const Duration(milliseconds: 400),

          // A button to control menu
          child: ElevatedButton(
            // Slim it
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(6, 6, 6, 6))),

            // Open and close menu
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                _menuOpenCallback();
                controller.open();
              }
            },

            // Icon
            child: Icon(
              Icons.usb,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      },

      // Only one child
      menuChildren: [
        // Give some gap
        Padding(
          padding: const EdgeInsets.all(9.0),

          // A wrap to contain chips
          child: Wrap(
            direction: Axis.vertical,
            spacing: 9.0,

            // Chips generate by portNameList
            children: List<Widget>.generate(
              portNameList.length,
              (int index) {
                return ChoiceChip(
                  // Looks like shit without this :(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1.0,

                  // Serial port name 
                  label: Text(portNameList[index]),

                  // Can only select one, and no way to unselect :) 
                  selected: _selectedIndex == index,
                  onSelected: (bool selected) {
                    // No way back :(
                    if (selected) {
                      _menuItemSelectedCallback(index);
                    }
                  },

                );
              },
            ),

          ),

        )
      ],

    );
  }
}
