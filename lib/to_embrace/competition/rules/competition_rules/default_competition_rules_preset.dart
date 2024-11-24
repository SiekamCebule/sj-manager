import 'package:equatable/equatable.dart';
import 'package:sj_manager/to_embrace/competition/rules/competition_rules/default_competition_rules.dart';
import 'package:sj_manager/to_embrace/competition/rules/competition_rules/default_competition_rules_provider.dart';
import 'package:sj_manager/features/database_editor/domain/entities/jumper/jumper_db_record.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/team/team.dart';

class DefaultCompetitionRulesPreset<T>
    with EquatableMixin
    implements DefaultCompetitionRulesProvider<T> {
  const DefaultCompetitionRulesPreset({
    required this.name,
    required this.rules,
  });

  const DefaultCompetitionRulesPreset.empty()
      : this(name: '', rules: const DefaultCompetitionRules.empty());

  final String name;
  final DefaultCompetitionRules<T> rules;
  Type get entityType {
    if (rules is DefaultCompetitionRules<JumperDbRecord>) {
      return JumperDbRecord;
    } else if (rules is DefaultCompetitionRules<Team>) {
      return Team;
    } else {
      throw TypeError();
    }
  }

  @override
  DefaultCompetitionRules<T> get competitionRules => rules;

  @override
  List<Object?> get props => [
        name,
        rules,
      ];
}