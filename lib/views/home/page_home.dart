import 'package:flutter/material.dart';
import 'package:popcorn/models/model_widget_configs.dart';
import 'package:popcorn/views/home/widgets/widget_receive_data_card.dart';
import 'package:popcorn/views/home/widgets/widget_user_avatar.dart';
import 'package:popcorn/views/home/widgets/widget_window_title_bar.dart';
import 'package:popcorn/views/home/widgets/widget_set_baud_rate_button.dart';
import 'package:popcorn/views/home/widgets/widget_set_port_button.dart';
import 'package:popcorn/views/home/widgets/widget_port_switch.dart';
import 'package:popcorn/views/home/widgets/widget_send_data_card.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color with opacity
      backgroundColor: ModelWidgetConfigs.scaffoldBackgroundColor(context),

      body: const Row(
        children: [
          // Control panel
          Padding(
            padding: EdgeInsets.fromLTRB(ModelWidgetConfigs.gap2Window, 0, 0,
                ModelWidgetConfigs.gap2ControlPanel - 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Take space
                SizedBox(
                  height: 12,
                ),

                // A nice avatar
                WidgetUserAvatar(),

                // Take space
                SizedBox(
                  height: 14,
                ),

                // Port switch
                WidgetPortSwitch(),

                // Take space
                SizedBox(
                  height: 5,
                ),

                // Set port button
                WidgetSetPortButton(),

                // Take space
                SizedBox(
                  height: 5,
                ),

                // Set baud rate button
                WidgetSetBaudRateButton(),

                // SizedBox(height: 5,),
              ],
            ),
          ),

          // Console cards
          Expanded(
            child: Column(
              children: [
                // Window title bar
                WidgetWindowTitleBar(),

                // Receive data card
                Expanded(child: WidgetReceiveDataCard()),

                // Send data card
                WidgetSendDataCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
