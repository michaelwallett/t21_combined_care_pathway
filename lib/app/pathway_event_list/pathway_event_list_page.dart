import 'package:flutter/material.dart';
import '../../pathway_event_list/pathway_event_list_screen.dart';
import '../../shared/models/pathway_event.dart';
import '../../shared/models/pathway_event_date.dart';

class PathwayEventListPage extends Page {
  final List<PathwayEvent> _pathwayEvents;
  final ValueChanged<PathwayEventDate> _onPathwayEventDateSelected;
  final ValueChanged<bool> _onShowUserSettingsSelected;

  PathwayEventListPage(this._pathwayEvents, this._onPathwayEventDateSelected,
      this._onShowUserSettingsSelected)
      : super(key: ValueKey('$PathwayEventListPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PathwayEventListScreen(
            pathwayEvents: _pathwayEvents,
            onPathwayEventDateSelected: _onPathwayEventDateSelected,
            onShowUserSettingsSelected: _onShowUserSettingsSelected);
      },
    );
  }
}
