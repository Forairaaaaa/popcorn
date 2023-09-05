import 'dart:convert';

import 'package:flutter/material.dart';

import 'presenters/serial_port/serial_port_presenter.dart';






void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popcorn',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      // initialRoute: '/home',
      // routes: {
      //   '/home' :(context) => const PopcornHomePage(),
      // },
      home: const ShitPage(),
    );
  }
}




class ShitPage extends StatefulWidget {
  const ShitPage({super.key});

  @override
  State<ShitPage> createState() => _ShitPageState();
}

class _ShitPageState extends State<ShitPage> {


  String textshit = '';

  @override
  void initState() {


    for (var shit in SerialPortPresenter().availablePorts) {
      print(shit);
    }

    SerialPortPresenter().open(SerialPortPresenter().availablePorts.last);

    // SerialPortPresenter().rxStreamRaw.listen((event) {
    //   setState(() {
    //     textshit += ascii.decode(event);
    //   });
    // });

    SerialPortPresenter().rxStream.listen((event) {
      setState(() {
        textshit += event;
      });
    });





    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: SelectableText(
          textshit
          ,
          style: TextStyle(
            fontFamily: 'CourierPrime',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}