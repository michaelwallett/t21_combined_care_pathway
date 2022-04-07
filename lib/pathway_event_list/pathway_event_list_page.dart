import 'package:flutter/material.dart';
import 'pathway_event_list_screen.dart';

class PathwayEventListPage extends Page {
  PathwayEventListPage() : super(key: ValueKey('$PathwayEventListPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const PathwayEventListScreen();
      },
    );
  }
}
