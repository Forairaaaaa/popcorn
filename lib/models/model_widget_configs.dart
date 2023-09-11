import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

/// Store common style, color, config or value settings...
final class ModelWidgetConfigs {
  ///
  /// [Value settings]
  ///
  static const double gap2Window = 12.0;
  static const double gap2WindowHalf = 6.0;
  static const double gap2ControlPanel = 12.0;
  static const Offset popupMenuPositionOffset = Offset(64.0, 0.0);
  static const double windowTitleBarHeight = 32.0;
  static const double gapReceiveText2card = 6.0;

  ///
  /// [Colors]
  ///
  /// [icon]
  static Color iconColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  /// [scaffold backgroud]
  static Color scaffoldBackgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5);

  /// [popup menu's barrier]
  static Color popupMenuBarrierColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
  
  /// [receive window card color]
  static Color receiveWindowCardColor(BuildContext context) =>
      (Theme.of(context).cardTheme.color ?? Colors.transparent).withOpacity(0.1);

  ///
  /// [Styles]
  ///
  /// [buttons of control panel]
  static ButtonStyle controlPanelButtonStyle =
      ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(6)));

  /// [popup menu tooltip text]
  static TextStyle popupMenuTooltipTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 18.0,
      color: Theme.of(context).colorScheme.onSecondary,
    );
  }

  /// [popup menu title text]
  static TextStyle popupMenuTitleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  /// [popup menu tilt config]
  static const TiltConfig popupMenuTiltConfig = TiltConfig(
    angle: 3.0,
    enableReverse: true,
    enableRevert: false,
    enableSensorRevert: false,
  );

  /// [popup menu tilt light config]
  static const LightConfig popupMenuTiltLightConfig =
      LightConfig(disable: true);

  /// [popup menu tilt shadow config]
  static const ShadowConfig popupMenuTiltShadowConfig = ShadowConfig(
    disable: true,
    enableReverse: true,
    maxIntensity: 0.4,
    offsetFactor: 0.05,
  );

  /// [popup menu backgroud blur filter]
  static ImageFilter popupMenuBgBlurFilter = ImageFilter.blur(
    sigmaX: 15,
    sigmaY: 15,
  );

  /// [window control buttons]
  static const ButtonStyle windowControlButtonStyle = ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(10, 10)),
      padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      )));

  /// [window title bar status label text]
  static TextStyle windowTitleBarStatusLabelTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Noto Sans Mono',
      color: Theme.of(context).colorScheme.outline,
      fontWeight: FontWeight.w600,
    );
  }

  /// [receive window text]
  static TextStyle receiveWindowTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Noto Sans Mono',
      fontSize: 14,
      color: Theme.of(context).colorScheme.inverseSurface,
    );
  }

  ///
  /// [Icons]
  ///
  /// [button set port]
  static const IconData buttonSetPortIcon = Icons.usb_rounded;

  /// [button set baud rate]
  static const IconData buttonSetBaudRateIcon = Icons.speed_rounded;
}
