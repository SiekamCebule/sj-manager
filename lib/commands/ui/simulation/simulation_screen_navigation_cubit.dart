import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sj_manager/models/simulation/flow/simulation_mode.dart';

class SimulationScreenNavigationCubit extends Cubit<SimulationScreenNavigationState> {
  SimulationScreenNavigationCubit()
      : super(const SimulationScreenNavigationState(
            screen: SimulationScreenNavigationTarget.home));

  void change({required SimulationScreenNavigationTarget screen}) {
    emit(state.copyWith(screen: screen));
  }
}

class SimulationScreenNavigationState {
  const SimulationScreenNavigationState({
    required this.screen,
  });

  final SimulationScreenNavigationTarget screen;

  SimulationScreenNavigationState copyWith({
    SimulationScreenNavigationTarget? screen,
  }) {
    return SimulationScreenNavigationState(
      screen: screen ?? this.screen,
    );
  }
}

enum SimulationScreenNavigationTarget {
  home,
  team,
  classifications,
  archive,
  calendar,
  stats,
  teams,
  settings,
  exit,
}

final navigationTargetsBySimulationMode = {
  SimulationMode.classicCoach: [
    SimulationScreenNavigationTarget.home,
    SimulationScreenNavigationTarget.team,
    SimulationScreenNavigationTarget.classifications,
    SimulationScreenNavigationTarget.archive,
    SimulationScreenNavigationTarget.calendar,
    SimulationScreenNavigationTarget.stats,
    SimulationScreenNavigationTarget.teams,
    SimulationScreenNavigationTarget.settings,
    SimulationScreenNavigationTarget.exit,
  ],
  SimulationMode.personalCoach: [
    SimulationScreenNavigationTarget.home,
    SimulationScreenNavigationTarget.team,
    SimulationScreenNavigationTarget.classifications,
    SimulationScreenNavigationTarget.archive,
    SimulationScreenNavigationTarget.calendar,
    SimulationScreenNavigationTarget.stats,
    SimulationScreenNavigationTarget.teams,
    SimulationScreenNavigationTarget.settings,
    SimulationScreenNavigationTarget.exit,
  ],
  SimulationMode.observer: [
    SimulationScreenNavigationTarget.home,
    SimulationScreenNavigationTarget.classifications,
    SimulationScreenNavigationTarget.archive,
    SimulationScreenNavigationTarget.calendar,
    SimulationScreenNavigationTarget.stats,
    SimulationScreenNavigationTarget.teams,
    SimulationScreenNavigationTarget.settings,
    SimulationScreenNavigationTarget.exit,
  ],
};