import 'package:flutter/material.dart';
import '../models/pathway_event.dart';
import '../models/pathway_event_date.dart';
import '../screens/pathway_event_list_screen.dart';

class PathwayEventListPage extends Page {
  final List<PathwayEvent> pathwayEvents;
  final ValueChanged<PathwayEventDate> onPathwayEventDateSelected;

  PathwayEventListPage(this.pathwayEvents, this.onPathwayEventDateSelected)
      : super(key: ValueKey('$PathwayEventListPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PathwayEventListScreen(
            pathwayEvents: pathwayEvents,
            onPathwayEventDateSelected: onPathwayEventDateSelected);
      },
    );
  }
}
