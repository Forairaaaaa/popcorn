import 'package:flutter/material.dart';

/// cc represents [common colors]
Color ccIcon(BuildContext context) => Theme.of(context).colorScheme.secondary;

Color ccScaffoldBackgroundColor(BuildContext context) =>
    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5);

Color ccBarrierColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
