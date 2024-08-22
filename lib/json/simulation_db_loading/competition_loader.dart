import 'package:sj_manager/json/simulation_db_loading/simulation_db_part_loader.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/competition/competition.dart';
import 'package:sj_manager/models/simulation_db/competition/competition_labels.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/competition_rules/default_competition_rules.dart';
import 'package:sj_manager/models/simulation_db/standings/standings.dart';
import 'package:sj_manager/models/user_db/hill/hill.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class CompetitionParser implements SimulationDbPartParser<Competition> {
  const CompetitionParser({
    required this.idsRepo,
    required this.rulesParser,
    required this.standingsParser,
  });

  final ItemsIdsRepo idsRepo;
  final SimulationDbPartParser<DefaultCompetitionRules> rulesParser;
  final SimulationDbPartParser<Standings> standingsParser;

  @override
  Competition load(Json json) {
    final labelsJson = json['labels'] as List<String>?;
    List<Object>? labels;
    if (labelsJson != null) {
      labels = labelsJson.map((json) => _label(json)).toList();
    }
    final standings = standingsParser.load(json);

    return Competition(
      // TODO: Maybe preserve the type?
      hill: idsRepo.get<Hill>(json['hillId']),
      date: DateTime.parse(json['date']),
      rules: rulesParser.load(json['rules']),
      labels: labels ?? const [],
      standings: standings,
    );
  }

  Object _label(String jsonString) {
    return switch (jsonString) {
      'competition' => CompetitionType.competition,
      'qualifications' => CompetitionType.qualifications,
      'trialRound' => CompetitionType.trialRound,
      'training' => CompetitionType.training,
      _ => throw ArgumentError('Invalid competition label ID ($jsonString)'),
    };
  }
}
