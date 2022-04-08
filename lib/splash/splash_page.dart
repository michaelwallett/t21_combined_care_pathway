import 'package:flutter/material.dart';
import 'splash_screen.dart';

class SplashPage extends Page {
  SplashPage() : super(key: ValueKey('$SplashPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return const SplashScreen();
        });
  }
}
