import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

/// Store common style, color, config or value settings...
final class ModelWidgetConfigs {
  ///
  /// Value settings
  ///
  static const double gap2Window = 12.0;
  static const double gap2WindowHalf = 6.0;
  static const double gap2ControlPanel = 24.0;
  static const Offset offsetPopupMenu = Offset(64.0, 0.0);

  ///
  /// Colors
  ///
  static Color colorIcon(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color colorScaffoldBackgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5);

  static Color colorBarrierColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);

  ///
  /// Styles
  ///
  static ButtonStyle styleButtonControlPanel =
      ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(6)));

  static TextStyle styleTooltipText(BuildContext context) {
    return TextStyle(
      fontSize: 18.0,
      color: Theme.of(context).colorScheme.onSecondary,
    );
  }

  static TextStyle stylePopupMenuTitleText(BuildContext context) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static const TiltConfig tiltConfigPopupMenu = TiltConfig(
    angle: 3.0,
    enableReverse: true,
    enableRevert: false,
    enableSensorRevert: false,
  );

  static const LightConfig tiltLightConfigPopupMenu =
      LightConfig(disable: true);

  static const ShadowConfig tiltShadowConfig = ShadowConfig(
    disable: true,
    enableReverse: true,
    maxIntensity: 0.4,
    offsetFactor: 0.05,
  );

  static ImageFilter stylePopupMenuBgBlur = ImageFilter.blur(
    sigmaX: 15,
    sigmaY: 15,
  );

  /// Icons
  static const IconData iconButtonSetPort = Icons.usb_rounded;
  static const IconData iconButtonSetBaudRate = Icons.speed_rounded;
}
