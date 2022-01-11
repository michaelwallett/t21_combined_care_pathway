import 'link.dart';
import 'age_interval.dart';
import 'pathway_event_type.dart';

class PathwayEvent {
  String title = '';
  String generalInfo = '';
  String medicalInfo = '';
  PathwayEventType type = PathwayEventType.event;
  List<AgeInterval> initialSchedule = [];
  List<Link> infoLinks = [];

  PathwayEvent(
      this.title, this.generalInfo, this.medicalInfo, this.initialSchedule);

  PathwayEvent.fromJson(Map<String, dynamic> map) {
    title = map['title'];
    generalInfo = map['generalInfo'] ?? '';
    medicalInfo = map['medicalInfo'] ?? '';

    type = PathwayEventType.values.firstWhere((value) =>
        value.toString() ==
        '$PathwayEventType.' + (map['eventType'] ?? 'event'));

    infoLinks = ((map['infoLinks'] ?? []) as List)
        .map((schedule) => Link.fromJson(schedule))
        .toList();

    initialSchedule = (map['initialSchedule'] as List)
        .map((schedule) => AgeInterval.fromJson(schedule))
        .toList();
  }
}
