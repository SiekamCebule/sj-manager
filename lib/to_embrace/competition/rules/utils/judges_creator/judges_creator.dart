import 'package:equatable/equatable.dart';
import 'package:osje_sim/osje_sim.dart';
import 'package:sj_manager/to_embrace/competition/competition.dart';
import 'package:sj_manager/to_embrace/competition/rules/user_algorithms/unary_algorithm.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/event_series/event_series.dart';
import 'package:sj_manager/core/core_classes/hill/hill.dart';

abstract class JudgesCreatingContext {
  const JudgesCreatingContext({
    required this.eventSeries,
    required this.competition,
    required this.currentRound,
    required this.hill,
    required this.windMeasurement,
    required this.jumpSimulationRecord,
    required this.judgesCount,
  });

  // TODO: final SimulationData simulationData;
  // TODO: final Season season;
  final EventSeries eventSeries;
  final Competition competition;
  final int currentRound;
  final Hill hill;
  final WindMeasurement windMeasurement;
  final JumpSimulationRecord jumpSimulationRecord;
  final int judgesCount;
}

abstract class JudgesCreator
    with EquatableMixin
    implements UnaryAlgorithm<JudgesCreatingContext, List<double>> {
  const JudgesCreator();

  @override
  List<Object?> get props => [
        runtimeType,
      ];
}