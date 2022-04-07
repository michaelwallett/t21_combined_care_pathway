import 'package:flutter/material.dart';
import '../shared/widgets/user_settings_form.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('T21 Pathway')),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "This pathway will enable you to navigate your way through the relevant health, and integrated services to ensure no one who has Down Syndrome gets 'left behind'."),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter your childs details to get started.')),
              ),
              UserSettingsForm()
            ])));
  }
}
