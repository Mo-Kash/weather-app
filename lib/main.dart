import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/themes/theme_provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child: const MyApp(),
    )
  );
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => Loading(),
        '/home':(context) => Home(),
        '/location':(context) => ChooseLocation(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
