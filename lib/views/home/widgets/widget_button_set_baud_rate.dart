import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:popcorn/common/hero_dialog_route.dart';
import 'package:provider/provider.dart';

/// A button with menu to select serial port name
class WidgetButtonSetBaudRate extends StatefulWidget {
  const WidgetButtonSetBaudRate({super.key});

  @override
  State<WidgetButtonSetBaudRate> createState() =>
      _WidgetButtonSetBaudRateState();
}

class _WidgetButtonSetBaudRateState extends State<WidgetButtonSetBaudRate> {
  @override
  Widget build(BuildContext context) {
    // Use menu anchor
    // https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return Tooltip(
          message: '${model.baudRate}',
          textStyle: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          waitDuration: const Duration(milliseconds: 400),

          // Hero tag for anim
          child: Hero(
            tag: 'HERO_POPUP_MENU',

            // A nice button
            child: ElevatedButton(
              // Slim it
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(6, 6, 6, 6))),

              // Route to page popup menu
              onPressed: () {
                // Push new menu page
                Navigator.of(context).push(
                    // With hero anim route
                    HeroDialogRoute(
                  builder: (context) {
                    return const _PagePopupMenu();
                  },
                ));
              },

              // Icon
              child: Icon(
                Icons.speed_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A menu page that hero dialog will route to
class _PagePopupMenu extends StatefulWidget {
  const _PagePopupMenu();

  @override
  State<_PagePopupMenu> createState() => _PagePopupMenuState();
}

class _PagePopupMenuState extends State<_PagePopupMenu> {

  final double gap2Window = 18.0;
  final double gap2WindowHalf = 9.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        // A stack so that menu can be positioned
        return Stack(
          children: [
            // Take full screen
            Container(height: double.infinity),

            // Postion of the menu
            Positioned(
              // Popup along side with the triger 
              // TODO
              left: 100,
              top: 100,
              width: 400,

              // A hero tag for anim
              child: Hero(
                tag: 'HERO_POPUP_MENU',
                
                // Wrap with this to aviod widget overflow  
                child: SingleChildScrollView(

                  // A card panel 
                  child: Card(

                    // Cloumn layout 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // A nice Title :)
                        Padding(
                          padding: EdgeInsets.fromLTRB(gap2Window, gap2Window, 0.0, 0.0),
                          child: const Text(
                            'serial_port',
                            style: TextStyle(fontSize: 18.0),
                          ).tr(gender: 'baud_rate'),
                        ),
                
                        // A nice divider :)
                        const Divider(),
                
                        // A wrap for chips
                        Padding(
                          padding: EdgeInsets.fromLTRB(gap2Window, gap2WindowHalf, gap2Window, gap2Window),
                          child: Wrap(
                            // Space between chips 
                            spacing: gap2WindowHalf,
                            runSpacing: gap2WindowHalf,
                                        
                            // Generate chips with [availableBaudRateList] in model 
                            children: List<Widget>.generate(
                              model.availableBaudRateList.length,
                              
                              // This shit buncing around when menu popup 
                              // TODO
                              (int index) {
                                return ChoiceChip(
                                  // Looks like shit without this :(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 1.0,
                                        
                                  // Baud rate
                                  label: Text(
                                      '${model.availableBaudRateList[index]}'),
                                        
                                  // Can only select one
                                  selected: model.baudRate ==
                                      model.availableBaudRateList[index],
                                  onSelected: (bool selected) {
                                    // no way to unselect :)
                                    if (selected) {
                                      model.baudRate =
                                          model.availableBaudRateList[index];
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


// A widget that displays its children in multiple horizontal or vertical runs.

// A Wrap lays out each child and attempts to place the child adjacent to the previous child in the main axis, given by direction, leaving spacing space in between. If there is not enough space to fit the child, Wrap creates a new run adjacent to the existing children in the cross axis.

// After all the children have been allocated to runs, the children within the runs are positioned according to the alignment in the main axis and according to the crossAxisAlignment in the cross axis.

// The runs themselves are then positioned in the cross axis according to the runSpacing and runAlignment.