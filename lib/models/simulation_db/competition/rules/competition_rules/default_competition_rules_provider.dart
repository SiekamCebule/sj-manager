import 'package:sj_manager/models/simulation_db/competition/rules/competition_rules/default_competition_rules.dart';

abstract interface class DefaultCompetitionRulesProvider<T> {
  const DefaultCompetitionRulesProvider();
  DefaultCompetitionRules<T> get competitionRules;
}