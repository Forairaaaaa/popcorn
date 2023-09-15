import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        setState(() {
          receivedMessage = state.receivedMessage;
        });

        // Scroll to the button
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic);
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

                      // My own scroll bar
                      child: Scrollbar(
                        controller: _scrollController,
                        thickness: 2.0,
                        thumbVisibility: true,

                        // Hide text field's scroll bar and my own
                        child: ScrollConfiguration(
                          behavior: const CustomScrollBehavior(),

                          // Text field
                          child: TextFormField(
                            // Hide under line
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            style: ModelWidgetConfigs.receiveDataTextStyle(
                                context),
                            readOnly: true,

                            // Expand it
                            minLines: null,
                            maxLines: null,
                            expands: true,

                            // Text control
                            controller:
                                TextEditingController(text: receivedMessage),

                            // Scroll control
                            scrollController: _scrollController,
                          ),
                        ),
                      )),
                ),

                TextButton(
                    onPressed: () {
                      context
                          .read<SerialPortBloc>()
                          .add(const SerialPortClearReceived());
                    },
                    child: const Text('???'))
              ],
            )),
      ),
    );
  }
}

/// Hide text field's scroll bar and my own
/// https://stackoverflow.com/questions/59174644/remove-scrollbar-at-right-from-multiline-textfield-flutter
class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    return child;
  }
}
