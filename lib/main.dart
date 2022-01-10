import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';
import 'pathway_event.dart';
import 'pathway_event_mapper.dart';

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
                    PathwayEventListPage(
                        snapshot.data!, _onPathwayEventDateSelected),
                    if (_selectedPathwayEventDate != null)
                      PathwayEventDetailsPage(_selectedPathwayEventDate!)
                  ],
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) {
                      return false;
                    }

                    setState(() {
                      _selectedPathwayEventDate = null;
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
}

class PathwayEventListScreen extends StatelessWidget {
  final List<PathwayEvent> pathwayEvents;
  final ValueChanged<PathwayEventDate> onPathwayEventDateSelected;

  const PathwayEventListScreen(
      {Key? key,
      required this.pathwayEvents,
      required this.onPathwayEventDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateOfBirth = DateTime(2021, 2, 8);
    DateTime dateInFuture = dateOfBirth.add(const Duration(days: (365 * 1)));

    List<PathwayMonth> pathwayMonths = [];
    List<PathwayEventDate> matchedPathwayEventDates = [];

    var currentDate = dateOfBirth;

    do {
      var currentMonth = currentDate.month;
      var pathwayMonthTitle = DateFormat.yMMMM().format(currentDate);

      do {
        var age = AgeCalculator.age(dateOfBirth, today: currentDate);

        matchedPathwayEventDates.addAll(pathwayEvents.where((pathwayEvent) {
          return pathwayEvent.initialSchedule.any((schedule) {
            return age.years == schedule.years &&
                age.months == schedule.months &&
                age.days == 0;
          });
        }).map((pathwayEvent) => PathwayEventDate(pathwayEvent, currentDate)));

        currentDate = currentDate.add(const Duration(days: 1));
      } while (currentMonth == currentDate.month);

      if (matchedPathwayEventDates.isNotEmpty) {
        pathwayMonths
            .add(PathwayMonth(pathwayMonthTitle, matchedPathwayEventDates));

        matchedPathwayEventDates = [];
      }
    } while (currentDate.isBefore(dateInFuture));

    return Scaffold(
        appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
        body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: pathwayMonths.length,
            itemBuilder: (BuildContext context, int index) {
              var pathwayMonth = pathwayMonths[index];

              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(pathwayMonth.title,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Column(
                    children: pathwayMonth.eventDates.map((pathwayEventDate) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                            leading: getEventIcon(pathwayEventDate.event.type),
                            title: Text(pathwayEventDate.event.title),
                            subtitle: Text(DateFormat.yMMMMd()
                                .format(pathwayEventDate.date)),
                            trailing: IconButton(
                                onPressed: () {
                                  onPathwayEventDateSelected(pathwayEventDate);
                                },
                                icon: const Icon(Icons.info_outline)))
                      ],
                    ),
                  );
                }).toList())
              ]);
            }));
  }

  Icon getEventIcon(PathwayEventType eventType) {
    if (eventType == PathwayEventType.birthday) {
      return const Icon(Icons.cake);
    }

    return const Icon(Icons.event);
  }
}

class PathwayEventDetailsScreen extends StatelessWidget {
  final PathwayEventDate pathwayEventDate;

  const PathwayEventDetailsScreen({Key? key, required this.pathwayEventDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
        body: Text(pathwayEventDate.event.title));
  }
}

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

class PathwayMonth {
  final String title;
  final List<PathwayEventDate> eventDates;

  PathwayMonth(this.title, this.eventDates);
}

class PathwayEventDate {
  final PathwayEvent event;
  final DateTime date;

  PathwayEventDate(this.event, this.date);
}
