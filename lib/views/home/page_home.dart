import 'package:flutter/material.dart';
import 'package:popcorn/common/popcorn_common.dart';
import 'package:popcorn/views/home/widgets/widget_window_title_bar.dart';
import 'package:popcorn/views/home/widgets/widget_button_set_baud_rate.dart';
import 'package:popcorn/views/home/widgets/widget_button_set_port.dart';
import 'package:popcorn/views/home/widgets/widget_switch_serial_port.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color with opacity
      backgroundColor: PopcornCommon.colorScaffoldBackgroundColor(context),

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
                Opacity(
                  opacity: 1,
                  child: RotatedBox(
                    quarterTurns: 0,
                    child: WidgetSwitchSerialPort()
                  )
                ),
          
          
                
                SizedBox(height: 5,),
          
                WidgetButtonSetPort(),
          
                SizedBox(height: 5,),
          
                WidgetButtonSetBaudRate(),

                SizedBox(height: 5,),
          
                shishishishishi(),
          
          
          
              ],
            ),
          ),


          // Consoles 
          Expanded(
            child: Column(
              children: [
                // Window title bar
                WidgetWindowTitleBar(),
              ],
            ),
          )

        ],

      ),
    );
  }
}

class shishishishishi extends StatelessWidget {
  const shishishishishi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        
      },
      icon: Icon(Icons.more_horiz),
    );
  }
}
