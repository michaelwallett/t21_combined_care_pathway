import 'package:flutter/material.dart';
import 'pathway_event_date.dart';
import 'pathway_event_details_screen.dart';

class PathwayEventDetailsPage extends Page {
  final PathwayEventDate pathwayEventDate;

  PathwayEventDetailsPage(this.pathwayEventDate)
      : super(key: ValueKey(pathwayEventDate));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PathwayEventDetailsScreen(pathwayEventDate: pathwayEventDate);
      },
    );
  }
}
