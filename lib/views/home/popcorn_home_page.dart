import 'package:flutter/material.dart';

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
      // if (states.contains(MaterialState.selected)) {
      //   return const Icon(Icons.link_rounded);
      // }
      // return const Icon(Icons.link_off_rounded);
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );


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


    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            

            // Control pannel 
            Padding(
              padding: const EdgeInsets.fromLTRB(gap2Window, gap2Window, gap2WindowHalf, gap2Window),
              child: Column(
                
                children: [
            
                  const CircleAvatar(
                    radius: 32,
                  ),



                  const SizedBox(height: gap2Window,),
            



                  Switch(
                    thumbIcon: thumbIconSwitchStart,
                    value: valueSwitchStart,
                    onChanged: (bool value) {
                      setState(() {
                        valueSwitchStart = value;
                      });
                    },
                  ),
                  




                  const SizedBox(height: gap2Window,),

                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {
                      
                    },
                    child: Icon(
                      Icons.usb,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),





                  const SizedBox(height: gap2Window,),

                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {
                      
                    },
                    child: Icon(
                      Icons.speed_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),



                  const SizedBox(height: gap2Window,),
                  

                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {
                      
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),







                  const Expanded(child: SizedBox()),


                  

                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {
                      
                    },
                    child: Icon(
                      Icons.tune_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),


                  const SizedBox(height: gap2Window,),
                  

                  ElevatedButton(
                    style: buttonStyleControlPanel,
                    onPressed: () {
                      
                    },
                    child: Icon(
                      Icons.drive_file_rename_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),





                  const SizedBox(height: gap2Window,),


                  


                ],
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
                        child: SelectableText(
                          testShit
                          ,
                          style: TextStyle(
                            fontFamily: 'CourierPrime',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  ),



                  // Window send 
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.fromLTRB(gap2WindowHalf, 0, gap2Window, gap2Window),
                            child: Padding(
                              padding: const EdgeInsets.all(gapText2Console),
                              child: TextFormField(
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                                expands: true,
                                maxLines: null,
                                minLines: null,
                              )
                            ),
                          ),
                        ),


                      

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, gap2Window, gap2Window),
                          child: SizedBox(
                            width: 36,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                              ),
                              onPressed: () {
                                
                              },
                              child: Icon(
                                Icons.rocket_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )



                      ],
                    )
                  ),





                ],
              ),
            ),



          ],
        )
      )
    );
  }
}
