import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/models/model_widget_configs.dart';

class WidgetSendDataCard extends StatelessWidget {
  const WidgetSendDataCard({super.key});

  void _sendDataButtonOnPreseed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            ModelWidgetConfigs.gap2WindowHalf,
            0,
            ModelWidgetConfigs.gap2WindowHalf,
            ModelWidgetConfigs.gap2WindowHalf),
        child: Card(
            elevation: 0.0,
            color: ModelWidgetConfigs.sendDataCardColor(context),

            // Gap
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  ModelWidgetConfigs.gapReceiveText2card,
                  0,
                  ModelWidgetConfigs.gapReceiveText2card,
                  ModelWidgetConfigs.gapReceiveText2card),
              child: Row(
                children: [
                  // Input field
                  Expanded(
                      child: TextField(
                    style: ModelWidgetConfigs.receiveDataTextStyle(context),

                    // Max line
                    maxLines: 10,
                    minLines: 1,
                  )),

                  // Send data button
                  Tooltip(
                    message: 'serial_port'.tr(gender: 'send'),
                    textStyle:
                        ModelWidgetConfigs.popupMenuTooltipTextStyle(context),
                    waitDuration: const Duration(milliseconds: 400),
                    child: IconButton(
                      icon: ModelWidgetConfigs.sendDataButtonIcon(context),
                      onPressed: _sendDataButtonOnPreseed,
                    ),
                  ),
                ],
              ),
            )));
  }
}
