import 'package:sj_manager/to_embrace/competition/rules/utils/competition_score_creator/competition_score_creator.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/details/competition_score_details.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/typedefs.dart';

class DefaultLinearIndividualCompetitionScoreCreator
    extends CompetitionScoreCreator<CompetitionJumperScore> {
  @override
  CompetitionJumperScore compute(
      covariant IndividualCompetitionScoreCreatingContext context) {
    if (context.currentScore == null) {
      return CompetitionJumperScore(
        entity: context.entity,
        points: context.lastJumpScore.points,
        details: CompetitionJumperScoreDetails(jumpScores: [context.lastJumpScore]),
      );
    } else {
      return CompetitionJumperScore(
          entity: context.entity,
          points: context.currentScore!.points + context.lastJumpScore.points,
          details: CompetitionJumperScoreDetails(
            jumpScores: [
              ...context.currentScore!.details.jumpScores,
              context.lastJumpScore,
            ],
          ));
    }
  }
}