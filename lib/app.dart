import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'juego memoria',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
