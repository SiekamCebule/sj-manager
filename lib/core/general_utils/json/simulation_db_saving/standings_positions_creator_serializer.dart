import 'package:sj_manager/features/competitions/domain/utils/standings_position_creators/standings_positions_creator.dart';
import 'package:sj_manager/features/competitions/domain/utils/standings_position_creators/standings_positions_with_ex_aequos_creator.dart';
import 'package:sj_manager/features/competitions/domain/utils/standings_position_creators/standings_positions_with_no_ex_aequo_creator.dart';
import 'package:sj_manager/features/competitions/domain/utils/standings_position_creators/standings_positions_with_shuffle_on_equal_positions_creator.dart';

class StandingsPositionsCreatorSerializer {
  String serialize(StandingsPositionsCreator creator) {
    if (creator is StandingsPositionsWithExAequosCreator) {
      return 'with_ex_aequos';
    } else if (creator is StandingsPositionsWithNoExAequoCreator) {
      return 'with_no_ex_aequo';
    } else if (creator is StandingsPositionsWithShuffleOnEqualPositionsCreator) {
      return 'with_shuffle_on_equal_positions';
    } else {
      throw ArgumentError('Invalid StandingsPositionsCreator');
    }
  }
}
