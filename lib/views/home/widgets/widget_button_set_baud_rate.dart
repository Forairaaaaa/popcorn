import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/common/colors.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:popcorn/common/styles.dart';

/// A button with menu to select serial port name
class WidgetButtonSetBaudRate extends StatefulWidget {
  const WidgetButtonSetBaudRate({super.key});

  @override
  State<WidgetButtonSetBaudRate> createState() =>
      _WidgetButtonSetBaudRateState();
}

class _WidgetButtonSetBaudRateState extends State<WidgetButtonSetBaudRate> {
  final buttonKey = GlobalKey();
  Offset buttonPosition = const Offset(0, 0);

  // https://stackoverflow.com/questions/54291245/get-y-position-of-container-on-flutter
  void _getPostion() {
    RenderBox box = buttonKey.currentContext?.findRenderObject() as RenderBox;
    buttonPosition = box.localToGlobal(Offset
        .zero); //this is global position/this is y - I think it's what you want
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return Tooltip(
          message: '${model.baudRate}',
          textStyle: csTooltipText(context),
          waitDuration: const Duration(milliseconds: 400),

          // A nice button
          child: ElevatedButton(
            // Key for position getting
            key: buttonKey,

            // Slim it
            style: csButtonControlPanel(),

            // Route to page popup menu
            onPressed: () {
              _getPostion();
              Navigator.of(context).push(
                  // With hero anim route
                  DialogRoute(
                // Pass button's position
                settings: RouteSettings(
                  arguments: [buttonPosition.dx, buttonPosition.dy],
                ),
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return const _PagePopupMenu();
                },
              ));
            },

            // Icon
            child: Icon(
              Icons.speed_rounded,
              color: ccIcon(context),
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
  @override
  Widget build(BuildContext context) {
    final buttonPosition =
        ModalRoute.of(context)!.settings.arguments as List<double?>;

    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        // A stack so that menu can be positioned
        return Stack(
          children: [
            // Take full screen
            Container(
              height: double.infinity,
            ),

            // Postion of the menu
            Positioned(
              // Popup along side with the triger
              left: buttonPosition[0]!,
              top: buttonPosition[1]!,
              width: 400,

              // Tilt card
              child: popupMenu(context, model),
            ),
          ],
        );
      },
    );
  }

  /// A tilt card
  Tilt popupMenu(BuildContext context, ModelSerialPort model) {
    return Tilt(
      tiltConfig: const TiltConfig(
        angle: 2.0,
        enableRevert: false,
        enableSensorRevert: false,
      ),
      lightConfig: const LightConfig(disable: true),
      shadowConfig: const ShadowConfig(disable: true),

      // A card panel
      child: Card(
        // Cloumn layout
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A nice Title :)
            popupMenuTitle(context),

            // A nice divider :)
            const Divider(),

            // Chips
            popupMenuBody(model)
          ],
        ),
      ),
    );
  }

  /// A nice title
  Padding popupMenuTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(csGap2Window, csGap2Window, 0.0, 0.0),
      child: Row(
        children: [
          Icon(
            Icons.speed_rounded,
            color: ccIcon(context),
          ),
          const SizedBox(width: csGap2WindowHalf,),
          Text(
            'serial_port',
            style: csPopupMenuTitleText(context),
          ).tr(gender: 'baud_rate'),
        ],
      ),
    );
  }

  /// Lot of chips
  Padding popupMenuBody(ModelSerialPort model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          csGap2Window, csGap2WindowHalf, csGap2Window, csGap2Window),
      child: Wrap(
        // Space between chips
        spacing: csGap2WindowHalf,
        runSpacing: csGap2WindowHalf,

        // Generate chips with [availableBaudRateList] in model
        children: List<Widget>.generate(
          model.availableBaudRateList.length,

          // Build function
          (int index) {
            return ChoiceChip(
              // Looks like shit without this :(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2.0,

              // Baud rate
              label: Text('${model.availableBaudRateList[index]}'),

              // Can only select one
              selected: model.baudRate == model.availableBaudRateList[index],
              onSelected: (bool selected) {
                // no way to unselect :)
                if (selected) {
                  model.baudRate = model.availableBaudRateList[index];
                }
              },
            );
          },
        ),
      ),
    );
  }
}
