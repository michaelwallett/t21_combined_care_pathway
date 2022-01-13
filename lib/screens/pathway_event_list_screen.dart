import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';
import '../models/pathway_event_type.dart';
import '../models/pathway_event.dart';
import '../models/pathway_event_date.dart';
import '../models/pathway_month.dart';

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
    DateTime dateAtAge18 =
        DateTime(dateOfBirth.year + 18, dateOfBirth.month, dateOfBirth.day);

    List<PathwayMonth> pathwayMonths = [];
    List<PathwayEventDate> matchedPathwayEventDates = [];

    var currentDate = dateOfBirth;

    do {
      var currentMonth = currentDate.month;
      var pathwayMonthTitle = DateFormat.yMMMM().format(currentDate);

      do {
        var age = AgeCalculator.age(dateOfBirth, today: currentDate);

        matchedPathwayEventDates.addAll(pathwayEvents.where((pathwayEvent) {
          return pathwayEvent.ageIntervals.any((schedule) {
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
    } while (currentDate.isBefore(dateAtAge18));

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
