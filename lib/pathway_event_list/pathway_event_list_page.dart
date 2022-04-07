import 'package:flutter/material.dart';
import '../shared/models/pathway_event_date.dart';
import 'pathway_event_list_screen.dart';

class PathwayEventListPage extends Page {
  final ValueChanged<PathwayEventDate> _onPathwayEventDateSelected;
  final ValueChanged<bool> _onShowUserSettingsSelected;

  PathwayEventListPage(
      this._onPathwayEventDateSelected, this._onShowUserSettingsSelected)
      : super(key: ValueKey('$PathwayEventListPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return PathwayEventListScreen(
            onPathwayEventDateSelected: _onPathwayEventDateSelected,
            onShowUserSettingsSelected: _onShowUserSettingsSelected);
      },
    );
  }
}
