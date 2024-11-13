import 'dart:async';

import 'package:sj_manager/commands/ui/simulation/jumper_reports/create_monthly_training_progress_reports_command.dart';
import 'package:sj_manager/commands/ui/simulation/jumper_reports/create_weekly_training_progress_reports_command.dart';
import 'package:sj_manager/commands/ui/simulation/set_up_subteams_command.dart';
import 'package:sj_manager/commands/ui/simulation/set_up_trainings_command.dart';
import 'package:sj_manager/commands/ui/simulation/training/simulate_global_training_command.dart';
import 'package:sj_manager/models/database/team/subteam.dart';
import 'package:sj_manager/models/simulation/database/actions/simulation_action_type.dart';
import 'package:sj_manager/models/simulation/database/simulation_database_and_models/simulation_database.dart';
import 'package:sj_manager/utils/datetime.dart';

class ContinueSimulationCommand {
  const ContinueSimulationCommand({
    required this.database,
    required this.chooseSubteamId,
    required this.afterSettingUpSubteams,
    required this.afterSettingUpTrainings,
  });

  final SimulationDatabase database;

  final String Function(Subteam subteam) chooseSubteamId;
  final FutureOr Function()? afterSettingUpSubteams;
  final FutureOr Function()? afterSettingUpTrainings;

  Future<void> execute() async {
    if (isSameDay(
      today: database.currentDate,
      targetDate: database.actionDeadlines[SimulationActionType.settingUpSubteams]!,
    )) {
      SetUpSubteamsCommand(
        database: database,
        chooseSubteamId: chooseSubteamId,
        onFinish: afterSettingUpTrainings,
      ).execute();
    }

    final date = database.currentDate;
    if (database.actionsRepo.isCompleted(SimulationActionType.settingUpTraining)) {
      SimulateGlobalTrainingCommand(
        database: database,
      ).execute();

      if (date.weekday == DateTime.sunday) {
        CreateWeeklyTrainingProgressReportsCommand(
          database: database,
        ).execute();
      }
      if (date.day == daysInMonth(date.year, date.month)) {
        CreateMonthlyTrainingProgressReportsCommand(
          database: database,
          endedMonth: date.month,
          yearDuringEndedMonth: date.year,
        ).execute();
      }
    }

    if (isSameDay(
      today: database.currentDate,
      targetDate: database.actionDeadlines[SimulationActionType.settingUpTraining]!,
    )) {
      SetUpTrainingsCommand(
        database: database,
        onFinish: afterSettingUpTrainings,
      ).execute();
    }
    database.currentDate = database.currentDate.add(const Duration(days: 1));
    database.notify();
  }
}
