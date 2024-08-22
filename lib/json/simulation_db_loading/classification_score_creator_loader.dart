import 'package:sj_manager/json/simulation_db_loading/simulation_db_part_loader.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/classification_score_creator/classification_score_creator.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/classification_score_creator/concrete/individual_default.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/classification_score_creator/concrete/team_default.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class ClassificationScoreCreatorParser
    implements SimulationDbPartParser<ClassificationScoreCreator> {
  const ClassificationScoreCreatorParser({
    required this.idsRepo,
  });

  final ItemsIdsRepo idsRepo;

  @override
  ClassificationScoreCreator load(Json json) {
    final type = json['type'] as String;
    return switch (type) {
      'default_individual' => DefaultIndividualClassificationScoreCreator(),
      'default_team' => DefaultTeamClassificationScoreCreator(),
      'custom_individual' => throw UnsupportedError(
          'Custom individual classification score creators are not supported yet. We\'re still working on it!',
        ),
      'custom_team' => throw UnsupportedError(
          'Custom team classification score creators are not supported yet. We\'re still working on it!',
        ),
      _ => throw UnsupportedError(
          '(Loading) An unsupported type of ClassificationScoreCreator ($type)',
        ),
    };
  }
}