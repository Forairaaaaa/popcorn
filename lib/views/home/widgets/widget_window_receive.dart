import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:popcorn/common/popcorn_common.dart';

class WidgetWindowReceive extends StatefulWidget {
  const WidgetWindowReceive({super.key});

  @override
  State<WidgetWindowReceive> createState() => _WidgetWindowReceiveState();
}

class _WidgetWindowReceiveState extends State<WidgetWindowReceive> {
  @override
  Widget build(BuildContext context) {
    // Bind model 
    return Consumer<ModelSerialPort>(
      builder: (context, value, child) {
        return Container(
          alignment: const Alignment(-1, -1),
          child: SelectableText(
            "🎉dasda asda asdasdasd sdaa sdasdasdads",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Noto Sans Mono',
              fontSize: 16,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        );
      },
    );
  }
}