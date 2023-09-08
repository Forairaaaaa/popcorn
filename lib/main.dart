import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'views/home/home_page.dart';
import 'models/model_serial_port.dart';


void main() async {
  // https://pub.dev/packages/easy_localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      // supportedLocales: const [Locale('en'), Locale('zh')],
      supportedLocales: const [Locale('en')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: const Locale('en'),
      child: const MyApp()
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Model serial port 
      create: (context) => ModelSerialPort(),

      child: MaterialApp(
        
        // https://pub.dev/packages/easy_localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
    
        title: 'Popcorn',
    
        // Theme shit 
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
    
        // Pages 
        initialRoute: '/home',
        routes: {
          '/home' :(context) => const PopcornHomePage(),
        },
    
      ),
    );
  }
}

