import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:popcorn/views/home/page_home.dart';
import 'package:provider/provider.dart';
import 'models/model_serial_port.dart';

void main() async {
  // Localization
  // https://pub.dev/packages/easy_localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Acrylic background
  // https://pub.dev/packages/flutter_acrylic
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(
    // effect: WindowEffect.mica,
    effect: WindowEffect.acrylic,
    // dark: false
  );
  Window.hideWindowControls();

  // App
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('zh')],
        path: 'assets/translations',
        startLocale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );

  // Window set up
  // https://pub.dev/packages/bitsdojo_window
  doWhenWindowReady(() {
    appWindow.minSize = const Size(240, 240);
    appWindow.size = const Size(1280, 800);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

        // Light theme 
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: Colors.deepPurple.shade500,
          ),
          useMaterial3: true,
        ),

        // Dark theme 
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.deepPurple.shade500,
          ),
          useMaterial3: true,
        ),
        // darkTheme: ThemeData.dark(useMaterial3: true),

        // Default dark 
        // themeMode: ThemeMode.light,
        themeMode: ThemeMode.dark,

        // Hide debug banner
        debugShowCheckedModeBanner: false,

        // Pages routes
        initialRoute: '/home',
        routes: {
          '/home': (context) => const PageHome(),
        },
      ),
    );
  }
}
