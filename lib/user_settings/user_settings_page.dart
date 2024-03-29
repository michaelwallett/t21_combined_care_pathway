import 'package:flutter/material.dart';
import '../shared/widgets/user_settings_form.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [UserSettingsForm()])));
  }
}
