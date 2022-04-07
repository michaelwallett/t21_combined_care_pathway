import 'dart:convert';
import '../models/pathway_event.dart';

class PathwayEventMapper {
  List<PathwayEvent> fromJson(String pathwayEventsJson) {
    List<dynamic> pathwayEventsMap = json.decode(pathwayEventsJson);

    return pathwayEventsMap.map((pathwayEventMap) {
      return PathwayEvent.fromJson(pathwayEventMap);
    }).toList();
  }
}
