import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/score.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/standings_positions_map_creator/standings_positions_creator.dart';

class StandingsPositionsWithNoExAequoCreator<S extends Score>
    extends StandingsPositionsCreator<S> {
  @override
  void generatePositionsMap() {
    int currentPosition = 1;
    for (final score in scores) {
      positionsMap[currentPosition] = [score];
      currentPosition++;
    }
  }
}