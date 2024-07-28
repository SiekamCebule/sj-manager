import 'package:sj_manager/models/db/event_series/standings/standings_positions_map_creator/standings_positions_creator.dart';
import 'package:sj_manager/models/db/event_series/standings/standings_record.dart';

class StandingsPositionsWithNoExAequoCreator<T extends StandingsRecord>
    implements StandingsPositionsCreator<T> {
  @override
  Map<int, List<T>> create(List<T> records) {
    _sortRecords(records);
    return _generatePositionsMap(records);
  }

  void _sortRecords(List<T> records) {
    records.sort((a, b) => a.score > b.score ? -1 : 1);
  }

  Map<int, List<T>> _generatePositionsMap(List<T> records) {
    Map<int, List<T>> positionsMap = {};
    int currentPosition = 1;

    for (T record in records) {
      positionsMap[currentPosition] = [record];
      currentPosition++;
    }

    return positionsMap;
  }
}
