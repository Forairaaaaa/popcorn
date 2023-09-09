import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:popcorn/common/colors.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:popcorn/common/styles.dart';

/// A button with menu to select serial port name
class WidgetButtonSetPort extends StatefulWidget {
  const WidgetButtonSetPort({super.key});

  @override
  State<WidgetButtonSetPort> createState() => _WidgetButtonSetPortState();
}

class _WidgetButtonSetPortState extends State<WidgetButtonSetPort> {
  final buttonKey = GlobalKey();
  Offset buttonPosition = const Offset(0, 0);

  // https://stackoverflow.com/questions/54291245/get-y-position-of-container-on-flutter
  void getPostion() {
    RenderBox box = buttonKey.currentContext?.findRenderObject() as RenderBox;
    buttonPosition = box.localToGlobal(Offset
        .zero); //this is global position/this is y - I think it's what you want
  }

  void buttonOnPressed(ModelSerialPort model) {
    // Update port list
    model.updateAvailablePortList();
    // Get button position
    getPostion();
    Navigator.of(context).push(
        // With hero anim route
        DialogRoute(
      // Pass button's position
      settings: RouteSettings(
        arguments: [buttonPosition.dx, buttonPosition.dy],
      ),
      barrierColor: ccBarrierColor(context),
      context: context,
      builder: (context) {
        return const _PagePopupMenu();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return Tooltip(
          message: model.portName,
          textStyle: csTooltipText(context),
          waitDuration: const Duration(milliseconds: 400),

          // A nice button
          child: IconButton(
            // Key for position getting
            key: buttonKey,

            // Slim it
            style: csButtonControlPanel(),

            // Route to page popup menu
            onPressed: () {
              buttonOnPressed(model);
            },

            // Icon
            icon: Icon(
              Icons.usb_rounded,
              color: ccIcon(context),
            ),
          ),
        );
      },
    );
  }
}

/// A menu page
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
        // Blur the background
        return BackdropFilter(
          filter: csPopupMenuBgBlur,

          // A stack for menu's positioned
          child: Stack(
            children: [
              // Take over full screen
              Container(
                height: double.infinity,
              ),

              // Postion offset to the button
              Positioned(
                left: buttonPosition[0]! + csOffsetPopupMenu.dx,
                top: buttonPosition[1]! + csOffsetPopupMenu.dy,
                width: 400,

                // Tilt card
                child: popupMenu(context, model),
              ),
            ],
          ),
        );
      },
    );
  }

  /// A tilt card
  Tilt popupMenu(BuildContext context, ModelSerialPort model) {
    return Tilt(
      tiltConfig: csTiltConfigPopupMenu(),
      lightConfig: csTiltLightConfigPopupMenu(),
      shadowConfig: csTiltShadowConfig(),

      // A card panel
      child: Card(
        elevation: 0.0,

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
      )
          // Shake items out
          .animate()
          .slideX(duration: 300.ms, curve: Curves.easeOutCubic)
          .fadeIn(),
    );
  }

  /// A nice title
  Padding popupMenuTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(csGap2Window, csGap2Window, 0.0, 0.0),
      child: Row(
        children: [
          Icon(
            Icons.usb_rounded,
            color: ccIcon(context),
          ),
          const SizedBox(
            width: csGap2WindowHalf,
          ),
          Text(
            'serial_port',
            style: csPopupMenuTitleText(context),
          ).tr(gender: 'port_name'),
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

        // Generate chips with [availablePortList] in model
        children: List<Widget>.generate(
          model.availablePortList.length,

          // Build function
          (int index) {
            return ChoiceChip(
              // Looks like shit without this :(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1.0,

              // Baud rate
              label: Text(model.availablePortList[index]),

              // Can only select one
              selected: model.portName == model.availablePortList[index],
              onSelected: (bool selected) {
                // no way to unselect :)
                if (selected) {
                  model.portName = model.availablePortList[index];
                }
              },
            )
                // Item slide in anim
                .animate()
                .slideX(
                  duration: 600.ms,
                  begin: -6,
                  delay: (20 * index).ms,
                  // curve: const Cubic(.35, 1.36, .74, 1.03),
                  curve: Curves.easeOutCubic
                )
                .fadeIn(
                  // duration: 200.ms,
                  delay: (50 * index).ms,
                );
          },
        ),
      ),
    );
  }
}
