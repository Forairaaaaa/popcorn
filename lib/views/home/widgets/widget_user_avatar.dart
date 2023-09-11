import 'package:flutter/material.dart';
import 'package:popcorn/models/model_widget_configs.dart';

class WidgetUserAvatar extends StatelessWidget {
  const WidgetUserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: ModelWidgetConfigs.avatarRaduis,
      child: ClipOval(
        child: Image(
          image: AssetImage('assets/images/avatar2.jpg'),
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
