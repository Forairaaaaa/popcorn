import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

/// cs represents [common styles]
const double csGap2Window = 18.0;
const double csGap2WindowHalf = 9.0;
const Offset csOffsetPopupMenu = Offset(64.0, -54.0);

ButtonStyle csButtonControlPanel() {
  return ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(6)));
}

TextStyle csTooltipText(BuildContext context) {
  return TextStyle(
    fontSize: 18.0,
    color: Theme.of(context).colorScheme.onSecondary,
  );
}

TextStyle csPopupMenuTitleText(BuildContext context) {
  return TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.secondary,
  );
}

TiltConfig csTiltConfigPopupMenu() {
  return const TiltConfig(
    angle: 2.0,
    enableReverse: true,
    enableRevert: false,
    enableSensorRevert: false,
  );
}

LightConfig csTiltLightConfigPopupMenu() => const LightConfig(disable: true);

ShadowConfig csTiltShadowConfig() {
  return const ShadowConfig(
    disable: true,
    enableReverse: true,
    maxIntensity: 0.4,
    offsetFactor: 0.05,
  );
}

ImageFilter csPopupMenuBgBlur = ImageFilter.blur(sigmaX: 15, sigmaY: 15,);
