import 'package:battle_bre_gems/providers/changes_provider.dart';
import 'package:battle_bre_gems/providers/edit_gem_provider.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EditGem(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChangesObserver(),
        ),
      ],
      child: MyApp(),
    ),
  );

  doWhenWindowReady(() {
    const initialSize = Size(1024, 640);
    appWindow.minSize = Size(396, 320);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'BattleBreGems';
    appWindow.show();
  });
}

Map routes = {'name': 'lol'};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BattleBreGems',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
