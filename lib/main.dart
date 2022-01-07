import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';

void main() {
  runApp(const T21PathwayApp());
}

class T21PathwayApp extends StatelessWidget {
  const T21PathwayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateOfBirth = DateTime(2021, 2, 8);
    DateTime dateInFuture = dateOfBirth.add(const Duration(days: (365 * 1)));

    List<PathwayMonth> pathwayMonths = [];
    List<PathwayEvent> pathwayEvents = [];

    var currentDate = dateOfBirth;

    do {
      var currentMonth = currentDate.month;
      var pathwayMonthTitle = DateFormat.yMMMM().format(currentDate);

      do {
        var age = AgeCalculator.age(dateOfBirth, today: currentDate);

        print('$age');

        pathwayEvents
            .add(PathwayEvent(currentDate, currentDate.toIso8601String()));

        currentDate = currentDate.add(const Duration(days: 1));
      } while (currentMonth == currentDate.month);

      pathwayMonths.add(PathwayMonth(pathwayMonthTitle, pathwayEvents));

      pathwayEvents = [];
    } while (currentDate.isBefore(dateInFuture));

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('T21 Combined Care Pathway')),
            body: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: pathwayMonths.length,
                itemBuilder: (BuildContext context, int index) {
                  var pathwayMonth = pathwayMonths[index];

                  return Column(children: [
                    SizedBox(height: 60, child: Text(pathwayMonth.title)),
                    Column(
                        children: pathwayMonth.events.map((pathwayEvent) {
                      return ListTile(
                          leading: const FlutterLogo(),
                          title: Text(pathwayEvent.title),
                          trailing: const Icon(Icons.more_vert));
                    }).toList())
                  ]);
                })));
  }
}

class PathwayMonth {
  final String title;
  final List<PathwayEvent> events;

  PathwayMonth(this.title, this.events);
}

class PathwayEvent {
  final DateTime date;
  final String title;

  PathwayEvent(this.date, this.title);
}
