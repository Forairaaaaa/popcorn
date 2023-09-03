import 'package:flutter/material.dart';

class PopcornHomePage extends StatefulWidget {
  const PopcornHomePage({super.key});
  
  @override
  State<PopcornHomePage> createState() => _PopcornHomePageState();
}

class _PopcornHomePageState extends State<PopcornHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("???"),
        ),
      )
    );
  }
}
