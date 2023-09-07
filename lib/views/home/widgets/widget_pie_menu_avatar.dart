import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:easy_localization/easy_localization.dart';


/// A circle avatar with PieMenu
class WidgetPieMenuAvatar extends StatefulWidget {
  const WidgetPieMenuAvatar({super.key});

  @override
  State<WidgetPieMenuAvatar> createState() => _WidgetPieMenuAvatarState();
}

class _WidgetPieMenuAvatarState extends State<WidgetPieMenuAvatar> {
  @override
  Widget build(BuildContext context) {
    return PieMenu(

      // Theme settings
      theme: PieTheme(
        buttonTheme: PieButtonTheme(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            iconColor: Theme.of(context).colorScheme.onSecondary),

        buttonThemeHovered: PieButtonTheme(
            backgroundColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.onPrimary),

        leftClickShowsMenu: true,
        rightClickShowsMenu: true,
      ),

      // PieMenu actions
      actions: [

        // Change profile image
        PieAction(
          tooltip: Text(
            'set_avatar',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ).tr(),
          onSelect: () {},
          child: const Icon(Icons.face),
        ),

        // Enter setting page
        PieAction(
          tooltip: Text(
            'settings',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ).tr(),
          onSelect: () {},
          child: const Icon(Icons.settings),
        ),

        // Set theme
        PieAction(
          tooltip: Text(
            'theme_color',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ).tr(),
          onSelect: () {},
          child: const Icon(Icons.palette_outlined),
        )

      ],

      // Actual avatar widget
      child: const CircleAvatar(
        radius: 26,
      ),
      
    );
  }
}
