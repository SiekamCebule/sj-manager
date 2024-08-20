import 'package:sj_manager/json/simulation_db_saving/simulation_db_part_serializer.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/event_series/event_series_calendar.dart';
import 'package:sj_manager/models/simulation_db/event_series/event_series_calendar_preset.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class EventSeriesCalendarPresetSerializer
    implements SimulationDbPartSerializer<EventSeriesCalendarPreset> {
  const EventSeriesCalendarPresetSerializer({
    required this.idsRepo,
    required this.calendarSerializer,
  });

  final ItemsIdsRepo idsRepo;
  final SimulationDbPartSerializer<EventSeriesCalendar> calendarSerializer;

  @override
  Json serialize(EventSeriesCalendarPreset preset) {
    return {
      'name': preset.name,
      'calendar': calendarSerializer.serialize(preset.calendar),
    };
  }
}
