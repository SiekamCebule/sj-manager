import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/standings_positions_map_creator/standings_positions_creator.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/standings_positions_map_creator/standings_positions_with_ex_aequos_creator.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/standings_positions_map_creator/standings_positions_with_no_ex_aequo_creator.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/standings_positions_map_creator/standings_positions_with_shuffle_on_equal_positions_creator.dart';

class StandingsPositionsCreatorParser {
  StandingsPositionsCreator parse(String type) {
    return switch (type) {
      'with_ex_aequos' => StandingsPositionsWithExAequosCreator(),
      'with_no_ex_aequo' => StandingsPositionsWithNoExAequoCreator(),
      'with_shuffle_on_equal_positions' =>
        StandingsPositionsWithShuffleOnEqualPositionsCreator(),
      _ => throw ArgumentError('Invalid StandingsPositionCreator type: $type'),
    };
  }
}