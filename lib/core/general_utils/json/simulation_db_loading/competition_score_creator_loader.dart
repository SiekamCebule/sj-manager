import 'package:sj_manager/core/general_utils/json/simulation_db_loading/simulation_db_part_loader.dart';
import 'package:sj_manager/core/general_utils/json/json_types.dart';
import 'package:sj_manager/features/competitions/domain/utils/competition_score_creator/competition_score_creator.dart';
import 'package:sj_manager/features/competitions/domain/utils/competition_score_creator/specific/individual/default_linear_individual_competition_score_creator.dart';
import 'package:sj_manager/features/competitions/domain/utils/competition_score_creator/specific/team/default_linear_team_competition_score_creator.dart';
import 'package:sj_manager/core/general_utils/ids_repository.dart';

class CompetitionScoreCreatorLoader
    implements SimulationDbPartParser<CompetitionScoreCreator> {
  const CompetitionScoreCreatorLoader({
    required this.idsRepository,
  });

  final IdsRepository idsRepository;

  @override
  CompetitionScoreCreator parse(Json json) {
    final type = json['type'] as String;
    return switch (type) {
      'default_linear_individual' => DefaultLinearIndividualCompetitionScoreCreator(),
      'default_linear_team' => DefaultLinearTeamCompetitionScoreCreator(),
      _ => throw UnsupportedError(
          '(Loading) An unsupported CompetitionScoreCreator type ($type)',
        ),
    };
  }
}
