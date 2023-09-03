import 'package:flutter/material.dart';
import 'pages/home/popcorn_home_page.dart';

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
      initialRoute: '/home',
      routes: {
        '/home' :(context) => const PopcornHomePage(),
      },
    );
  }
}
