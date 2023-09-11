import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:popcorn/common/popcorn_common.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';

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
    buttonPosition = box.localToGlobal(Offset.zero);
  }

  AnimationController? animController;

  void buttonOnPressed(BuildContext context, SerialPortState state) {
    // Return if opened already
    if (state.isOpened) {
      // Shake the button
      animController?.reset();
      animController?.forward();
      return;
    }

    // Send update port list event
    context.read<SerialPortBloc>().add(const SerialPortUpdateAvailablePorts());

    // Get button position
    getPostion();

    // Open menu page
    Navigator.of(context).push(
        // Route a menu page
        DialogRoute(
      // Pass button's position
      settings: RouteSettings(
        arguments: [buttonPosition.dx, buttonPosition.dy],
      ),
      barrierColor: ModelWidgetConfigs.popupMenuBarrierColor(context),
      context: context,
      builder: (context) {
        return const _PagePopupMenu();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Bind bloc
    return BlocBuilder<SerialPortBloc, SerialPortState>(
      builder: (context, state) {
        return Tooltip(
          message: state.portName,
          textStyle: ModelWidgetConfigs.popupMenuTooltipTextStyle(context),
          waitDuration: const Duration(milliseconds: 400),

          // A nice button
          child: IconButton(
            // Key for position getting
            key: buttonKey,

            // Slim it
            style: ModelWidgetConfigs.buttonControlPanelStyle,

            // Route to page popup menu
            onPressed: () {
              buttonOnPressed(context, state);
            },

            // Icon
            icon: Icon(
              ModelWidgetConfigs.buttonSetPortIcon,
              color: ModelWidgetConfigs.iconColor(context),
            ),
          ),
        )
            .animate(
              autoPlay: false,
              // Copy controller
              onInit: (controller) {
                animController = controller;
              },
            )
            .shake();
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

    return BlocBuilder<SerialPortBloc, SerialPortState>(
      builder: (context, state) {
        // Blur the background
        return BackdropFilter(
          filter: ModelWidgetConfigs.popupMenuBgBlurFilter,

          // A stack for menu's positioned
          child: Stack(
            children: [
              // Take over full screen
              Container(
                height: double.infinity,
              ),

              // Postion offset to the button
              Positioned(
                left: buttonPosition[0]! + ModelWidgetConfigs.popupMenuPositionOffset.dx,
                top: buttonPosition[1]! + ModelWidgetConfigs.popupMenuPositionOffset.dy,
                width: 400,

                // Tilt card
                child: popupMenu(context, state),
              ),
            ],
          ),
        );
      },
    );
  }

  /// A tilt card
  Tilt popupMenu(BuildContext context, SerialPortState state) {
    return Tilt(
      tiltConfig: ModelWidgetConfigs.popupMenuTiltConfig,
      lightConfig: ModelWidgetConfigs.popupMenuTiltLightConfig,
      shadowConfig: ModelWidgetConfigs.popupMenuTiltShadowConfig,

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
            popupMenuBody(context, state)
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
      padding: const EdgeInsets.fromLTRB(
          ModelWidgetConfigs.gap2Window, ModelWidgetConfigs.gap2Window, 0.0, 0.0),
      child: Row(
        children: [
          Icon(
            ModelWidgetConfigs.buttonSetPortIcon,
            color: ModelWidgetConfigs.iconColor(context),
          ),
          const SizedBox(
            width: ModelWidgetConfigs.gap2WindowHalf,
          ),
          Text(
            'serial_port',
            style: ModelWidgetConfigs.popupMenuTitleTextStyle(context),
          ).tr(gender: 'port_name'),
        ],
      ),
    );
  }

  /// Lot of chips
  Padding popupMenuBody(BuildContext context, SerialPortState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          ModelWidgetConfigs.gap2Window,
          ModelWidgetConfigs.gap2WindowHalf,
          ModelWidgetConfigs.gap2Window,
          ModelWidgetConfigs.gap2Window),
      child: Wrap(
        // Space between chips
        spacing: ModelWidgetConfigs.gap2WindowHalf,
        runSpacing: ModelWidgetConfigs.gap2WindowHalf,

        // Generate chips with [availablePortList] in model
        children: List<Widget>.generate(
          state.availablePorts.length,

          // Build function
          (int index) {
            return ChoiceChip(
              // Looks like shit without this :(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1.0,

              // Baud rate
              label: Text(state.availablePorts[index]),

              // Can only select one
              selected: state.portName == state.availablePorts[index],
              onSelected: (bool selected) {
                // no way to unselect :)
                if (selected) {
                  context.read<SerialPortBloc>().add(
                      SerialPortPortNameChanged(state.availablePorts[index]));
                }
              },
            )
                // Item slide in anim
                .animate()
                .fadeIn(
                  // duration: 200.ms,
                  delay: (40 * index).ms,
                );
          },
        ),
      ),
    );
  }
}
