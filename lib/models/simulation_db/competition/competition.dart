import 'package:equatable/equatable.dart';

import 'package:sj_manager/models/simulation_db/competition/rules/competition_rules/default_competition_rules.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/competition_rules/default_competition_rules_provider.dart';
import 'package:sj_manager/models/simulation_db/standings/standings.dart';
import 'package:sj_manager/models/user_db/hill/hill.dart';

class Competition<E> with EquatableMixin {
  const Competition({
    required this.hill,
    required this.date,
    required this.rules,
    this.standings,
    this.labels = const [],
  });

  final Hill hill;
  final DateTime date;
  final DefaultCompetitionRulesProvider<E> rules;
  final Standings<E>? standings;
  final List<Object> labels;

  Competition<E> copyWith({
    Hill? hill,
    DateTime? date,
    DefaultCompetitionRules<E>? rules,
    Standings<E>? standings,
    List<Object>? labels,
  }) {
    return Competition<E>(
      hill: hill ?? this.hill,
      date: date ?? this.date,
      rules: rules ?? this.rules,
      standings: standings ?? this.standings,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [
        hill,
        date,
        rules,
        standings,
        labels,
      ];
}
