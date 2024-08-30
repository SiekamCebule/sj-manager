import 'package:sj_manager/json/simulation_db_loading/simulation_db_part_loader.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/standings/score/concrete/classification_score.dart';
import 'package:sj_manager/models/simulation_db/standings/score/concrete/simple_points_score.dart';
import 'package:sj_manager/models/simulation_db/standings/score/concrete/competition_scores.dart';
import 'package:sj_manager/models/simulation_db/standings/score/score.dart';
import 'package:sj_manager/models/simulation_db/standings/score/concrete/jump_score.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class ScoreParser implements SimulationDbPartParser<Score> {
  const ScoreParser({
    required this.idsRepo,
  });

  final ItemsIdsRepo idsRepo;

  @override
  Score parse(Json json) {
    return _loadAppropriate(json);
  }

  Score _loadAppropriate(Json json) {
    final type = json['type'] as String;
    return switch (type) {
      'default_jump_score' => _loadDefaultJumpScore(json),
      'jump_score' => _loadSimpleJumpScore(json),
      'jumper_competition_score' => _loadCompetitionJumperScore(json),
      'team_competition_score' => _loadCompetitionTeamScore(json),
      'simple_points_score' => _loadSimplePointsScore(json),
      'classification_score' => _loadClassificationScore(json),
      _ => throw UnsupportedError('Unsupported score type: $type'),
    };
  }

  DefaultJumpScore _loadDefaultJumpScore(Json json) {
    final entity = idsRepo.get(json['entityId']);
    final jumpRecord = idsRepo.get(json['jumpRecordId']);
    return DefaultJumpScore(
      entity: entity,
      distancePoints: json['distancePoints'],
      judgesPoints: json['judgesPoints'],
      gatePoints: json['gatePoints'],
      windPoints: json['windPoints'],
      jumpRecord: jumpRecord,
    );
  }

  SimpleJumpScore _loadSimpleJumpScore(Json json) {
    final entity = idsRepo.get(json['entityId']);
    final jumpRecord = idsRepo.get(json['jumpRecordId']);
    return SimpleJumpScore(
      entity: entity,
      jumpRecord: jumpRecord,
      points: json['points'],
    );
  }

  CompetitionJumperScore _loadCompetitionJumperScore(Json json) {
    final entity = idsRepo.get(json['entityId']);
    final jumpScoresJson = json['jumpScores'] as List<Json>;
    final jumpScores = jumpScoresJson.map((json) {
      return _loadAppropriate(json);
    }).toList();
    return CompetitionJumperScore(
      entity: entity,
      points: json['points'],
      jumpScores: jumpScores.cast(),
    );
  }

  CompetitionTeamScore _loadCompetitionTeamScore(Json json) {
    final entity = idsRepo.get(json['entityId']);
    final jumperScoresJson = json['entityScores'] as List<Json>;
    final jumperScores = jumperScoresJson.map((json) {
      return _loadCompetitionJumperScore(json);
    }).toList();
    return CompetitionTeamScore(
      entity: entity,
      points: json['points'],
      jumperScores: jumperScores,
    );
  }

  SimplePointsScore _loadSimplePointsScore(Json json) {
    final entity = idsRepo.get(json['entityId']);
    return SimplePointsScore(
      json['points'],
      entity: entity,
    );
  }

  ClassificationScore _loadClassificationScore(Json json) {
    final competitionScoresJson = json['competitionScores'] as List<Json>;
    final competitionScores = competitionScoresJson.map((json) {
      return _loadAppropriate(json);
    }).toList();
    return ClassificationScore(
      entity: idsRepo.get(json['entityId']),
      points: json['points'],
      competitionScores: competitionScores.cast<CompetitionScore>(),
    );
  }
}
