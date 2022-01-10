import 'package:t21_combined_care_pathway/age_interval.dart';

class PathwayEvent {
  String title = '';
  List<AgeInterval> initialSchedule = [];

  PathwayEvent(this.title, this.initialSchedule);

  PathwayEvent.fromJson(Map<String, dynamic> map) {
    title = map['title'];
    initialSchedule = (map['initialSchedule'] as List)
        .map((schedule) => AgeInterval.fromJson(schedule))
        .toList();
  }
}
