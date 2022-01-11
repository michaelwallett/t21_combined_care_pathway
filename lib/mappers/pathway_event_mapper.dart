import 'dart:convert';
import '../models/pathway_event.dart';

class PathwayEventMapper {
  Future<List<PathwayEvent>> fromJson(
      Future<String> pathwayEventJsonFuture) async {
    var pathwayEventJson = await pathwayEventJsonFuture;

    List<dynamic> pathwayEventsMap = json.decode(pathwayEventJson);

    return pathwayEventsMap.map((pathwayEventMap) {
      return PathwayEvent.fromJson(pathwayEventMap);
    }).toList();
  }
}
