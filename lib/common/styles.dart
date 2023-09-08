import 'package:flutter/material.dart';

/// cs represents [common styles]
const double csGap2Window = 18.0;
const double csGap2WindowHalf = 9.0;

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
