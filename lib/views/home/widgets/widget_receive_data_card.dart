import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/blocs/bloc_serial_port/serial_port_bloc.dart';
import 'package:popcorn/models/model_widget_configs.dart';

class WidgetReceiveDataCard extends StatefulWidget {
  const WidgetReceiveDataCard({super.key});

  @override
  State<WidgetReceiveDataCard> createState() => _WidgetReceiveDataCardState();
}

class _WidgetReceiveDataCardState extends State<WidgetReceiveDataCard> {
  // Buffer of receiveed message
  String receivedMessage = '';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SerialPortBloc, SerialPortState>(
      // Only update when message received
      listenWhen: (previous, current) {
        return current.receivedMessage != previous.receivedMessage;
      },

      // Update state
      listener: (context, state) {
        // Scroll to the button
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic);

        setState(() {
          receivedMessage = state.receivedMessage;
        });
      },

      // Console window
      child: Padding(
        padding: const EdgeInsets.fromLTRB(ModelWidgetConfigs.gap2WindowHalf, 0,
            ModelWidgetConfigs.gap2WindowHalf, 0),
        child: Card(
            elevation: 0.0,
            color: ModelWidgetConfigs.receiveDataCardColor(context),

            // Take all space
            child: Row(
              children: [
                // Text
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          ModelWidgetConfigs.gapReceiveText2card * 2,
                          ModelWidgetConfigs.gapReceiveText2card,
                          ModelWidgetConfigs.gapReceiveText2card * 2,
                          ModelWidgetConfigs.gapReceiveText2card),
                      child: TextField(
                        style: ModelWidgetConfigs.receiveDataTextStyle(context),
                        readOnly: true,
                        minLines: null,
                        maxLines: null,
                        expands: true,
                        controller:
                            TextEditingController(text: receivedMessage),
                        scrollController: _scrollController,
                      )),
                ),

                TextButton(onPressed:() {
                  context.read<SerialPortBloc>().add(const SerialPortClearReceived());
                }, child: Text('???'))
              ],
            )),
      ),
    );
  }
}

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
