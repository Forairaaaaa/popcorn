import 'package:flutter/material.dart';
import 'package:popcorn/models/model_widget_configs.dart';
import 'package:popcorn/views/home/widgets/widget_receive_window.dart';
import 'package:popcorn/views/home/widgets/widget_window_title_bar.dart';
import 'package:popcorn/views/home/widgets/widget_set_baud_rate_button.dart';
import 'package:popcorn/views/home/widgets/widget_set_port_button.dart';
import 'package:popcorn/views/home/widgets/widget_port_switch.dart';

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
            padding: EdgeInsets.fromLTRB(12, 0, 0, 10),
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
          
                SizedBox(height: 12,),
          
                CircleAvatar(
                  radius: 32,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/avatar2.jpg'),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
          
                SizedBox(height: 14,),
          
          
                // Switch of port 
                WidgetPortSwitch(),
          
          
                
                SizedBox(height: 5,),
          
                WidgetSetPortButton(),
          
                SizedBox(height: 5,),
          
                WidgetSetBaudRateButton(),

                // SizedBox(height: 5,),
          
          
          
              ],
            ),
          ),


          // Consoles windows
          Expanded(
            child: Column(
              children: [
                // Window title bar
                WidgetWindowTitleBar(),

                // window serrial receive 
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: ModelWidgetConfigs.gap2WindowHalf),
                    child: WidgetWindowReceive(),
                  )
                ),

              ],
            ),
          )

          

        ],

      ),
    );
  }
}



