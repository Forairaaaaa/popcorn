import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:popcorn/models/model_serial_port.dart';
import 'package:provider/provider.dart';

import 'widgets/widget_pie_menu_avatar.dart';
import 'widgets/widget_serial_port_swtich.dart';
import 'widgets/widget_button_set_port.dart';
import 'widgets/widget_button_set_baud_rate.dart';


class PopcornHomePage extends StatefulWidget {
  const PopcornHomePage({super.key});

  @override
  State<PopcornHomePage> createState() => _PopcornHomePageState();
}

class _PopcornHomePageState extends State<PopcornHomePage> {
  bool valueSwitchStart = false;
  final MaterialStateProperty<Icon?> thumbIconSwitchStart =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Basic layout parameters
    const double gap2Window = 18.0;
    const double gap2WindowHalf = 9.0;
    const double gapText2Console = 12.0;

    const String testShit = """
I (851) spi_flash: flash io: qio
I (856) sleep: Configure to isolate all GPIO pins in sleep state
I (862) sleep: Enable automatic switching of GPIO sleep configuration
I (869) app_start: Starting scheduler on CPU0
I (874) app_start: Starting scheduler on CPU1
I (874) main_task: Started on CPU0
I (884) esp_psram: Reserving pool of 32K of internal memory for DMA/internal allocations
I (892) main_task: Calling app_main()
I (897) hal: init hal
I (899) hal: start holding power
I (903) gpio: GPIO[46]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (913) hal: init display
I (1190) hal: create framebuffer
I (1194) gpio: GPIO[21]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (1194) gpio: GPIO[0]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
[1970-01-01 00:00:14.526] [info] mooncake init :)
[1970-01-01 00:00:14.530] [info] create userdata
[1970-01-01 00:00:14.534] [info] start db setup
[1970-01-01 00:00:14.538] [info] create boot anim
[1970-01-01 00:00:14.543] [info] start boot anim

 _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |   | |     |  _  |  |  |   __|
| | | |  |  |  |  | | | |   --|     |    -|   __|
|_|_|_|_____|_____|_|___|_____|__|__|__|__|_____|

- @author Forairaaaaa
- @version v0.2.0
- @build at 07:44:44 Aug 25 2023

[1970-01-01 00:00:14.572] [info] init done
I (851) spi_flash: flash io: qio
I (856) sleep: Configure to isolate all GPIO pins in sleep state
I (862) sleep: Enable automatic switching of GPIO sleep configuration
I (869) app_start: Starting scheduler on CPU0
I (874) app_start: Starting scheduler on CPU1
I (874) main_task: Started on CPU0
I (884) esp_psram: Reserving pool of 32K of internal memory for DMA/internal allocations
I (892) main_task: Calling app_main()
I (897) hal: init hal
I (899) hal: start holding power
I (903) gpio: GPIO[46]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (913) hal: init display
I (1190) hal: create framebuffer
I (1194) gpio: GPIO[21]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (1194) gpio: GPIO[0]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
[1970-01-01 00:00:14.526] [info] mooncake init :)
[1970-01-01 00:00:14.530] [info] create userdata
[1970-01-01 00:00:14.534] [info] start db setup
[1970-01-01 00:00:14.538] [info] create boot anim
[1970-01-01 00:00:14.543] [info] start boot anim

 _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |   | |     |  _  |  |  |   __|
| | | |  |  |  |  | | | |   --|     |    -|   __|
|_|_|_|_____|_____|_|___|_____|__|__|__|__|_____|

- @author Forairaaaaa
- @version v0.2.0
- @build at 07:44:44 Aug 25 2023

[1970-01-01 00:00:14.572] [info] init done
I (851) spi_flash: flash io: qio
I (856) sleep: Configure to isolate all GPIO pins in sleep state
I (862) sleep: Enable automatic switching of GPIO sleep configuration
I (869) app_start: Starting scheduler on CPU0
I (874) app_start: Starting scheduler on CPU1
I (874) main_task: Started on CPU0
I (884) esp_psram: Reserving pool of 32K of internal memory for DMA/internal allocations
I (892) main_task: Calling app_main()
I (897) hal: init hal
I (899) hal: start holding power
I (903) gpio: GPIO[46]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (913) hal: init display
I (1190) hal: create framebuffer
I (1194) gpio: GPIO[21]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (1194) gpio: GPIO[0]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
[1970-01-01 00:00:14.526] [info] mooncake init :)
[1970-01-01 00:00:14.530] [info] create userdata
[1970-01-01 00:00:14.534] [info] start db setup
[1970-01-01 00:00:14.538] [info] create boot anim
[1970-01-01 00:00:14.543] [info] start boot anim

 _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |   | |     |  _  |  |  |   __|
| | | |  |  |  |  | | | |   --|     |    -|   __|
|_|_|_|_____|_____|_|___|_____|__|__|__|__|_____|

- @author Forairaaaaa
- @version v0.2.0
- @build at 07:44:44 Aug 25 2023

[1970-01-01 00:00:14.572] [info] init done
I (851) spi_flash: flash io: qio
I (856) sleep: Configure to isolate all GPIO pins in sleep state
I (862) sleep: Enable automatic switching of GPIO sleep configuration
I (869) app_start: Starting scheduler on CPU0
I (874) app_start: Starting scheduler on CPU1
I (874) main_task: Started on CPU0
I (884) esp_psram: Reserving pool of 32K of internal memory for DMA/internal allocations
I (892) main_task: Calling app_main()
I (897) hal: init hal
I (899) hal: start holding power
I (903) gpio: GPIO[46]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (913) hal: init display
I (1190) hal: create framebuffer
I (1194) gpio: GPIO[21]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
I (1194) gpio: GPIO[0]| InputEn: 0| OutputEn: 0| OpenDrain: 0| Pullup: 1| Pulldown: 0| Intr:0 
[1970-01-01 00:00:14.526] [info] mooncake init :)
[1970-01-01 00:00:14.530] [info] create userdata
[1970-01-01 00:00:14.534] [info] start db setup
[1970-01-01 00:00:14.538] [info] create boot anim
[1970-01-01 00:00:14.543] [info] start boot anim

 _____ _____ _____ _____ _____ _____ _____ _____
|     |     |     |   | |     |  _  |  |  |   __|
| | | |  |  |  |  | | | |   --|     |    -|   __|
|_|_|_|_____|_____|_|___|_____|__|__|__|__|_____|

- @author Forairaaaaa
- @version v0.2.0
- @build at 07:44:44 Aug 25 2023

[1970-01-01 00:00:14.572] [info] init done
""";

    // Button style of control panel
    var buttonStyleControlPanel = ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(6, 6, 6, 6)));

    Color buttonIconColor = Theme.of(context).colorScheme.secondary;

    return PieCanvas(
      child: Scaffold(
          body: SafeArea(
              child: Row(
        children: [
          // Control pannel
          SizedBox(
            width: 82,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  gap2Window, gap2Window, gap2WindowHalf, gap2Window),
              child: ListView(
                children: [
                  // PieMenu(
                  //   theme: PieTheme(
                  //     buttonTheme: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.secondary, iconColor: Theme.of(context).colorScheme.onSecondary),
                  //     buttonThemeHovered: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.primary, iconColor: Theme.of(context).colorScheme.onPrimary),
    
                  //     leftClickShowsMenu: true,
                  //     rightClickShowsMenu: true,
    
                  //   ),
                  //   actions: [
                  //     PieAction(
                  //       tooltip: Text('like', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  //       onSelect: () {
                  //       },
                  //       child: const Icon(Icons.face), // Can be any widget
                  //     ),
                  //     PieAction(
                  //       tooltip: Text('啊？', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  //       onSelect: () {
                  //       },
                  //       child: const Icon(Icons.settings), // Can be any widget
                  //     )
                  //   ],
    
                  //   child: const CircleAvatar(
                  //     radius: 26,
                  //   ),
                  // ),
    
                  const WidgetPieMenuAvatar(),
    
                  // Little gap
                  const SizedBox(height: gap2Window),
    
                  // Switch(
                  //   thumbIcon: thumbIconSwitchStart,
                  //   value: valueSwitchStart,
                  //   onChanged: (bool value) {
                  //     setState(() {
                  //       valueSwitchStart = value;
                  //     });
                  //   },
                  // ),
                  const WidgetSerialPortSwitch(),
    
                  const SizedBox(
                    height: gap2Window,
                  ),
    
                  // ElevatedButton(
                  //   style: buttonStyleControlPanel,
                  //   onPressed: () {
    
                  //   },
                  //   child: Icon(
                  //     Icons.usb,
                  //     color: buttonIconColor,
                  //   ),
                  // ),
                  const WidgetButtonSetPort(),
    
                  const SizedBox(
                    height: gap2Window,
                  ),
    
    
    
                  // ElevatedButton(
                  //   style: buttonStyleControlPanel,
                  //   onPressed: () {},
                  //   child: Icon(
                  //     Icons.speed_rounded,
                  //     color: buttonIconColor,
                  //   ),
                  // ),
                  const WidgetButtonSetBaudRate(),



                  
    
    
                  const SizedBox(
                    height: gap2Window,
                  ),
    
                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {},
                    child: Icon(
                      Icons.more_horiz,
                      color: buttonIconColor,
                    ),
                  ),
    
                


                
                ],
              ),
            ),
          ),
    
          // Console windows pannel
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Window receive
                Expanded(
                    child: Card(
                  margin: const EdgeInsets.fromLTRB(
                      gap2WindowHalf, gap2Window, gap2Window, gap2Window),
                  child: Padding(
                    padding: const EdgeInsets.all(gapText2Console),
    
                    // child: SelectableText(
                    //   testShit
                    //   ,
                    //   style: TextStyle(
                    //     fontFamily: 'CourierPrime',
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //     color: Theme.of(context).primaryColor,
                    //   ),
                    // ),
    
                    child: SelectableText(
                      testShit,
                      style: TextStyle(
                        fontFamily: 'CourierPrime',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                    ),
                  ),
                )),
    
                // Window send
                Card(
                  margin: const EdgeInsets.fromLTRB(
                      gap2WindowHalf, 0, gap2Window, gap2Window),
                  child: Padding(
                    padding: const EdgeInsets.all(gapText2Console),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'CourierPrime',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
    
                      decoration: InputDecoration(
                          // border: const OutlineInputBorder(),
    
                          suffixIcon: PieMenu(
                        theme: PieTheme(
                          buttonTheme: PieButtonTheme(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              iconColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          buttonThemeHovered: PieButtonTheme(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              iconColor:
                                  Theme.of(context).colorScheme.onPrimary),
                        ),
                        actions: [
                          PieAction(
                            tooltip: Text(
                              'like',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            onSelect: () {},
                            child: const Icon(
                                Icons.file_open_rounded), // Can be any widget
                          ),
                          PieAction(
                            tooltip: Text(
                              '啊？',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            onSelect: () {},
                            child:
                                const Icon(Icons.delete), // Can be any widget
                          )
                        ],
                        child: IconButton(
                          icon: Icon(
                            Icons.reply_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () {},
                        ),
                      )),
    
                      // expands: true,
                      maxLines: 10,
                      minLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
