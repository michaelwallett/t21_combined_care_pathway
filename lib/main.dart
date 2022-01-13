import 'package:flutter/material.dart';
import 'models/pathway_event.dart';
import 'models/pathway_event_date.dart';
import 'pages/pathway_event_details_page.dart';
import 'pages/pathway_event_list_page.dart';
import 'mappers/pathway_event_mapper.dart';
import 'pages/user_details_page.dart';

void main() {
  runApp(const T21PathwayApp());
}

class T21PathwayApp extends StatefulWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  State<T21PathwayApp> createState() => _T21PathwayAppState();
}

class _T21PathwayAppState extends State<T21PathwayApp> {
  PathwayEventDate? _selectedPathwayEventDate;
  bool _showUserDetails = false;
  late Future<List<PathwayEvent>> _futurePathwayEvents;

  @override
  void initState() {
    super.initState();

    _futurePathwayEvents = _getPathwayEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'T21 Combined Care Pathway',
        home: FutureBuilder<List<PathwayEvent>>(
            future: _futurePathwayEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Navigator(
                  pages: [
                    PathwayEventListPage(snapshot.data!,
                        _onPathwayEventDateSelected, _onShowUserDetailSelected),
                    if (_selectedPathwayEventDate != null)
                      PathwayEventDetailsPage(_selectedPathwayEventDate!),
                    if (_showUserDetails) UserDetailsPage()
                  ],
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) {
                      return false;
                    }

                    setState(() {
                      _selectedPathwayEventDate = null;
                      _showUserDetails = false;
                    });

                    return true;
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Future<List<PathwayEvent>> _getPathwayEvents(BuildContext context) {
    var pathwayEventsJson =
        DefaultAssetBundle.of(context).loadString('assets/pathway_events.json');

    return PathwayEventMapper().fromJson(pathwayEventsJson);
  }

  void _onPathwayEventDateSelected(PathwayEventDate pathwayEventDate) {
    setState(() {
      _selectedPathwayEventDate = pathwayEventDate;
    });
  }

  void _onShowUserDetailSelected(bool showUserDetails) {
    setState(() {
      _showUserDetails = showUserDetails;
    });
  }
}
