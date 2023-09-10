import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:popcorn/common/popcorn_common.dart';

/// A button with menu to select serial baud rate
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
  void getPostion() {
    RenderBox box = buttonKey.currentContext?.findRenderObject() as RenderBox;
    buttonPosition = box.localToGlobal(Offset
        .zero); //this is global position/this is y - I think it's what you want
  }

  void buttonOnPressed(ModelSerialPort model) {
    // Get button position
    getPostion();
    Navigator.of(context).push(
        // With hero anim route
        DialogRoute(
      // Pass button's position
      settings: RouteSettings(
        arguments: [buttonPosition.dx, buttonPosition.dy],
      ),
      barrierColor: PopcornCommon.colorBarrierColor(context),
      context: context,
      builder: (context) {
        return const _PagePopupMenu();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Bind model 
    return Consumer<ModelSerialPort>(
      builder: (context, model, child) {
        return Tooltip(
          message: '${model.baudRate}',
          textStyle: PopcornCommon.styleTooltipText(context),
          waitDuration: const Duration(milliseconds: 400),

          // A nice button
          child: IconButton(
            // Key for position getting
            key: buttonKey,

            // Slim it
            style: PopcornCommon.styleButtonControlPanel,

            // Route to page popup menu
            onPressed: () {
              buttonOnPressed(model);
            },

            // Icon
            icon: Icon(
              Icons.speed_rounded,
              color: PopcornCommon.colorIcon(context),
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
          filter: PopcornCommon.stylePopupMenuBgBlur,

          // A stack for menu's positioned
          child: Stack(
            children: [
              // Take over full screen
              Container(
                height: double.infinity,
              ),

              // Postion offset to the button
              Positioned(
                left: buttonPosition[0]! + PopcornCommon.offsetPopupMenu.dx,
                top: buttonPosition[1]! + PopcornCommon.offsetPopupMenu.dy,
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
      tiltConfig: PopcornCommon.tiltConfigPopupMenu,
      lightConfig: PopcornCommon.tiltLightConfigPopupMenu,
      shadowConfig: PopcornCommon.tiltShadowConfig,

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
          .slideY(duration: 300.ms, curve: Curves.easeOutCubic)
          .fadeIn(),
    );
  }

  /// A nice title
  Padding popupMenuTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(PopcornCommon.gap2Window, PopcornCommon.gap2Window, 0.0, 0.0),
      child: Row(
        children: [
          Icon(
            Icons.speed_rounded,
            color: PopcornCommon.colorIcon(context),
          ),
          const SizedBox(
            width: PopcornCommon.gap2WindowHalf,
          ),
          Text(
            'serial_port',
            style: PopcornCommon.stylePopupMenuTitleText(context),
          ).tr(gender: 'baud_rate'),
        ],
      ),
    );
  }

  /// Lot of chips
  Padding popupMenuBody(ModelSerialPort model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          PopcornCommon.gap2Window, PopcornCommon.gap2WindowHalf, PopcornCommon.gap2Window, PopcornCommon.gap2Window),
      child: Wrap(
        // Space between chips
        spacing: PopcornCommon.gap2WindowHalf,
        runSpacing: PopcornCommon.gap2WindowHalf,

        // Generate chips with [availableBaudRateList] in model
        children: List<Widget>.generate(
          model.availableBaudRateList.length,

          // Build function
          (int index) {
            return ChoiceChip(
              // Looks like shit without this :(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1.0,

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
            )
                // Item slide in anim
                .animate()
                .slideX(
                    duration: 300.ms,
                    begin: -6,
                    delay: (15 * index).ms,
                    // curve: const Cubic(.35, 1.36, .74, 1.03),
                    curve: Curves.easeOutCubic)
                .fadeIn(
                  // duration: 200.ms,
                  delay: (30 * index).ms,
                );
          },
        ),
      ),
    );
  }
}
