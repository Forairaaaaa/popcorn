import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:popcorn/common/hero_dialog_route.dart';
import 'package:provider/provider.dart';


/// A button with menu to select serial port name
class WidgetSetBaudRateButton extends StatefulWidget {
  const WidgetSetBaudRateButton({super.key});

  @override
  State<WidgetSetBaudRateButton> createState() =>
      _WidgetSetBaudRateButtonState();
}

class _WidgetSetBaudRateButtonState extends State<WidgetSetBaudRateButton> {
  @override
  Widget build(BuildContext context) {
    // Use menu anchor
    // https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return MenuAnchor(
        // Offset the menu a little bit
        alignmentOffset: const Offset(9.0, 9.0),
    
        // Menu builder
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
              // Tool tip: show current port name
              return Tooltip(
                message: '${model.baudRate}',
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
                      controller.open();
                    }
                  },
        
                  // Icon
                  child: Icon(
                    Icons.speed_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            },
        
            // Only one child
            menuChildren: [
              
              // A nice Title :)
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: const Text('serial_port',
                  style: TextStyle(fontSize: 18.0),
                ).tr(gender: 'baud_rate'),
              ),
        
              // A nice divider :)
              const Divider(height: 5.0,),
        
              // Give some gap
              Padding(
                padding: const EdgeInsets.all(9.0),
        
                // A wrap to contain chips
                child: SizedBox(
                  width: 300,
                  child: Wrap(
                    // direction: Axis.vertical,
                    spacing: 9.0,
                    runSpacing: 9.0,
                
                    // Chips generate by portNameList
                    children: List<Widget>.generate(
                      model.availableBaudRateList.length,
                      (int index) {
                        return ChoiceChip(
                          // Looks like shit without this :(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 1.0,
                
                          // Serial port name 
                          label: Text('${model.availableBaudRateList[index]}'),
                
                          // Can only select one, and no way to unselect :) 
                          selected: model.baudRate == model.availableBaudRateList[index],
                          onSelected: (bool selected) {
                            // No way back :(
                            if (selected) {
                              model.baudRate = model.availableBaudRateList[index];
                            }
                          },
                
                        );
                      },
                    ),
                
                  ),
                ),
        
              )
            ],
        
          );
      },
    );
  }
}
