import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';
import 'pathway_event.dart';
import 'pathway_event_mapper.dart';

void main() {
  runApp(const T21PathwayApp());
}

class T21PathwayApp extends StatelessWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<List<PathwayEvent>>(
            future: getPathwayEvents(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return HomeScreen(pathwayEvents: snapshot.data!);
              } else {
                return const SplashScreen();
              }
            }));
  }

  Future<List<PathwayEvent>> getPathwayEvents(BuildContext context) {
    var pathwayEventsJson =
        DefaultAssetBundle.of(context).loadString('assets/pathway_events.json');

    return PathwayEventMapper().fromJson(pathwayEventsJson);
  }
}

class HomeScreen extends StatelessWidget {
  final List<PathwayEvent> pathwayEvents;

  const HomeScreen({Key? key, required this.pathwayEvents}) : super(key: key);

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

      pathwayMonths
          .add(PathwayMonth(pathwayMonthTitle, matchedPathwayEventDates));

      matchedPathwayEventDates = [];
    } while (currentDate.isBefore(dateInFuture));

    return Scaffold(
        appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: pathwayMonths.length,
            itemBuilder: (BuildContext context, int index) {
              var pathwayMonth = pathwayMonths[index];

              return Column(children: [
                SizedBox(height: 50, child: Text(pathwayMonth.title)),
                Column(
                    children: pathwayMonth.eventDates.map((pathwayEventDate) {
                  return ListTile(
                      leading: const FlutterLogo(),
                      title: Text(pathwayEventDate.event.title),
                      subtitle: Text(pathwayEventDate.date.toIso8601String()),
                      trailing: const Icon(Icons.more_vert));
                }).toList())
              ]);
            }));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Initialization",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator()
        ],
      ),
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
