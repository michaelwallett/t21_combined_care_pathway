import 'package:t21_combined_care_pathway/age_interval.dart';

class PathwayEvent {
  String title = '';
  PathwayEventType type = PathwayEventType.event;
  List<AgeInterval> initialSchedule = [];

  PathwayEvent(this.title, this.initialSchedule);

  PathwayEvent.fromJson(Map<String, dynamic> map) {
    title = map['title'];

    type = PathwayEventType.values.firstWhere((value) =>
        value.toString() ==
        '$PathwayEventType.' + (map['eventType'] ?? 'event'));

    initialSchedule = (map['initialSchedule'] as List)
        .map((schedule) => AgeInterval.fromJson(schedule))
        .toList();
  }
}

enum PathwayEventType { birthday, event }
