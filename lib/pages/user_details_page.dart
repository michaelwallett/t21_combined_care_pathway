import 'package:flutter/material.dart';
import '../screens/user_details_screen.dart';

class UserDetailsPage extends Page {
  UserDetailsPage() : super(key: ValueKey('$UserDetailsPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const UserDetailsScreen();
      },
    );
  }
}
