import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'shared/models/pathway_event_date.dart';
import 'pathway_event_details/pathway_event_details_page.dart';
import 'pathway_event_list/pathway_event_list_page.dart';
import 'user_settings/user_settings_page.dart';

class T21PathwayApp extends ConsumerStatefulWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  _T21PathwayAppState createState() => _T21PathwayAppState();
}

class _T21PathwayAppState extends ConsumerState<T21PathwayApp> {
  PathwayEventDate? _selectedPathwayEventDate;
  bool _showUserSettings = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'T21 Combined Care Pathway',
        debugShowCheckedModeBanner: false,
        home: Navigator(
            pages: [
              PathwayEventListPage(
                  _onPathwayEventDateSelected, _onShowUserSettingsSelected),
              if (_selectedPathwayEventDate != null)
                PathwayEventDetailsPage(_selectedPathwayEventDate!),
              if (_showUserSettings) UserSettingsPage()
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }

              setState(() {
                _selectedPathwayEventDate = null;
                _showUserSettings = false;
              });

              return true;
            }));
  }

  void _onPathwayEventDateSelected(PathwayEventDate pathwayEventDate) {
    setState(() {
      _selectedPathwayEventDate = pathwayEventDate;
    });
  }

  void _onShowUserSettingsSelected(bool showUserDetails) {
    setState(() {
      _showUserSettings = showUserDetails;
    });
  }
}
