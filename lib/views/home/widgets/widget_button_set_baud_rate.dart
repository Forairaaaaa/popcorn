import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

          // A nice button
          child: ElevatedButton(
            // Slim it
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(6))),

            // Route to page popup menu
            onPressed: () {
              Navigator.of(context).push(
                  // With hero anim route
                  DialogRoute(
                context: context,
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

class _PagePopupMenuState extends State<_PagePopupMenu>
    with TickerProviderStateMixin {
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
            Container(height: double.infinity,),

            // Postion of the menu
            Positioned(
              // Popup along side with the triger
              // TODO
              left: 100,
              top: 100,
              width: 400,

              // Wrap this to aviod widget overflow
              child: SingleChildScrollView(
                // A card panel
                child: Card(
                  // Cloumn layout
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // A nice Title :)
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            gap2Window, gap2Window, 0.0, 0.0),
                        child: const Text(
                          'serial_port',
                          style: TextStyle(fontSize: 18.0),
                        ).tr(gender: 'baud_rate'),
                      ),

                      // A nice divider :)
                      const Divider(),

                      // A wrap for chips
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            gap2Window, gap2WindowHalf, gap2Window, gap2Window),
                        child: Wrap(
                          // Space between chips
                          spacing: gap2WindowHalf,
                          runSpacing: gap2WindowHalf,

                          // Generate chips with [availableBaudRateList] in model
                          children: List<Widget>.generate(
                            model.availableBaudRateList.length,

                            // Build function
                            (int index) {
                              return ChoiceChip(
                                // Looks like shit without this :(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 0.0,

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
                )
                ,
              ),
            ),
          ],
        );
      },
    );
  }
}
