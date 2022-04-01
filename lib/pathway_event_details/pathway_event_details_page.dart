import 'package:flutter/material.dart';
import '../shared/models/pathway_event_date.dart';
import 'pathway_event_details_screen.dart';

class PathwayEventDetailsPage extends Page {
  final PathwayEventDate _pathwayEventDate;

  PathwayEventDetailsPage(this._pathwayEventDate)
      : super(key: ValueKey(_pathwayEventDate));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PathwayEventDetailsScreen(pathwayEventDate: _pathwayEventDate);
      },
    );
  }
}
