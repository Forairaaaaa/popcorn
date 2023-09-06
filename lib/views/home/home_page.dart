import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:easy_localization/easy_localization.dart';




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




  // Controllers
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

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
""";


    // Button style of control panel 
    var buttonStyleControlPanel = ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(6, 6, 6, 6)));


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
                  padding: const EdgeInsets.fromLTRB(gap2Window, gap2Window, gap2WindowHalf, gap2Window),
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

                      const WidgetDopeAvatar(),
                  



                  
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
                  
                  

                  
                      const SizedBox(height: gap2Window,),
                  
                      // ElevatedButton(
                      //   style: buttonStyleControlPanel,
                      //   onPressed: () {
                          
                      //   },
                      //   child: Icon(
                      //     Icons.usb,
                      //     color: buttonIconColor,
                      //   ),
                      // ),
                      const WidgetSetPortNameButton(),
                  
                  
                  
                  
                      const SizedBox(height: gap2Window,),
                  
                      ElevatedButton(
                        style: buttonStyleControlPanel,
                        onPressed: () {
                          
                        },
                        child: Icon(
                          Icons.speed_rounded,
                          color: buttonIconColor,
                        ),
                      ),
                  
                  
                  
                      const SizedBox(height: gap2Window,),
                      
                  
                      ElevatedButton(
                        style: buttonStyleControlPanel,
                        onPressed: () {
                          
                        },
                        child: Icon(
                          Icons.more_horiz,
                          color: buttonIconColor,
                        ),
                      ),



                      const SizedBox(height: gap2Window,),

                      PieMenu(
                        theme: PieTheme(
                          buttonTheme: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.secondary, iconColor: Theme.of(context).colorScheme.onSecondary),
                          buttonThemeHovered: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.primary, iconColor: Theme.of(context).colorScheme.onPrimary),

                          // delayDuration: Duration.zero,

                          rightClickShowsMenu: true,
                          
                        ),
                        actions: [
                          PieAction(
                            tooltip: Text('like', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                            onSelect: () {
                            },
                            child: const Icon(Icons.save_rounded), // Can be any widget
                          ),
                          PieAction(
                            tooltip: Text('啊？', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                            onSelect: () {
                            },
                            child: const Icon(Icons.delete), // Can be any widget
                          )
                        ],

                        child: TextButton(
                          child: Icon(
                            Icons.textsms_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed:() {
                            
                          },
                        )
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
                        margin: const EdgeInsets.fromLTRB(gap2WindowHalf, gap2Window, gap2Window, gap2Window),
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


                          child: WebSmoothScroll(
                            controller: _scrollController,
                            
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _scrollController,
                              child: SelectableText(
                                testShit
                                ,
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),






                        ),
                      )
                    ),
    
    
    


                    // Window send 
                    Card(
                      margin: const EdgeInsets.fromLTRB(gap2WindowHalf, 0, gap2Window, gap2Window),
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
                                buttonTheme: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.secondary, iconColor: Theme.of(context).colorScheme.onSecondary),
                                buttonThemeHovered: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.primary, iconColor: Theme.of(context).colorScheme.onPrimary),

                              
                                
                              ),
                              actions: [
                                PieAction(
                                  tooltip: Text('like', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                  onSelect: () {
                                  },
                                  child: const Icon(Icons.file_open_rounded), // Can be any widget
                                ),
                                PieAction(
                                  tooltip: Text('啊？', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                                  onSelect: () {
                                  },
                                  child: const Icon(Icons.delete), // Can be any widget
                                )
                              ],

                              child: IconButton(
                                icon: Icon(
                                  Icons.reply_rounded,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed:() {
                                  
                                },
                              ),
                            )
                    
                          ),
                    
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
          )
        )
      ),
    );
  }
}





/// A circle avatar with PieMenu
class WidgetDopeAvatar extends StatefulWidget {
  const WidgetDopeAvatar({super.key});

  @override
  State<WidgetDopeAvatar> createState() => _WidgetDopeAvatarState();
}

class _WidgetDopeAvatarState extends State<WidgetDopeAvatar> {
  @override
  Widget build(BuildContext context) {
    return PieMenu(

      // Theme settings 
      theme: PieTheme(
        buttonTheme: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.secondary, iconColor: Theme.of(context).colorScheme.onSecondary),
        buttonThemeHovered: PieButtonTheme(backgroundColor: Theme.of(context).colorScheme.primary, iconColor: Theme.of(context).colorScheme.onPrimary),

        leftClickShowsMenu: true,
        rightClickShowsMenu: true,
      ),

      // PieMenu actions 
      actions: [

        // Change profile image 
        PieAction(
          tooltip: Text('set_avatar', style: TextStyle(color: Theme.of(context).colorScheme.primary),).tr(),
          onSelect: () {
          },
          child: const Icon(Icons.face),
        ),

        // Enter setting page 
        PieAction(
          tooltip: Text('settings', style: TextStyle(color: Theme.of(context).colorScheme.primary),).tr(),
          onSelect: () {
          },
          child: const Icon(Icons.settings),
        ),

        // Set theme
        PieAction(
          tooltip: Text('theme_color', style: TextStyle(color: Theme.of(context).colorScheme.primary),).tr(),
          onSelect: () {
          },
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



/// A switch to open and close serial port 
class WidgetSerialPortSwitch extends StatefulWidget {
  const WidgetSerialPortSwitch({super.key});

  @override
  State<WidgetSerialPortSwitch> createState() => _WidgetSerialPortSwitchState();
}

class _WidgetSerialPortSwitchState extends State<WidgetSerialPortSwitch> {

  bool valueSerialSwitch= false;

  // State property icon 
  final MaterialStateProperty<Icon?> thumbIconSerialSwitch =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  // Switch changed callback 
  void _onSerialSwitchChanged(bool value) {
    // Try open serial port 
    if (value) {
      // TODO
    }
    // Try close serial port 
    else {
      // TODO
    }

    // Update state 
    setState(() {
      valueSerialSwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(

      // Tool tip settings 
      message: 'serial_port'.tr(gender: valueSerialSwitch ? "connected" : "disconnect"),
      textStyle: TextStyle(
        fontSize: 18.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      waitDuration: const Duration(seconds: 1),

      child: Switch(
        thumbIcon: thumbIconSerialSwitch,
        value: valueSerialSwitch,
        onChanged: _onSerialSwitchChanged,
      ),

    );
  }
}



/// A button to select serial port name 
/// https://www.youtube.com/watch?v=Bxs8Zy2O4wk&t=12s
class WidgetSetPortNameButton extends StatefulWidget {
  const WidgetSetPortNameButton({super.key});

  @override
  State<WidgetSetPortNameButton> createState() => _WidgetSetPortNameButtonState();
}

class _WidgetSetPortNameButtonState extends State<WidgetSetPortNameButton> {

  // Current selected port name 
  String selectedPortName = '😊';

  // Available serial port list 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(6, 6, 6, 6))),
      onPressed: () {
        
      },
      child: Icon(
        Icons.usb,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}