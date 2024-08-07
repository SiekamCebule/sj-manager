import 'package:equatable/equatable.dart';
import 'package:sj_manager/models/db/event_series/competition/rules/competition_round_rules/competition_round_rules.dart';

abstract class CompetitionRules<T> with EquatableMixin {
  const CompetitionRules({
    required this.rounds,
  });

  final List<CompetitionRoundRules<T>> rounds;

  int get roundsCount => rounds.length;

  @override
  List<Object?> get props => [rounds];
}
