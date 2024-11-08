import 'package:sj_manager/algorithms/reports/training_progress_report/monthly_jumper_training_progress_report_creator.dart';
import 'package:sj_manager/commands/simulation_database/simulation_database_commander.dart';
import 'package:sj_manager/models/simulation/database/simulation_database_and_models/simulation_database.dart';
import 'package:sj_manager/models/simulation/flow/reports/jumper_reports.dart';
import 'package:sj_manager/models/user_db/jumper/jumper.dart';
import 'package:sj_manager/utils/datetime.dart';

class CreateMonthlyTrainingProgressReportsCommand {
  const CreateMonthlyTrainingProgressReportsCommand({
    required this.database,
    required this.endedMonth,
    required this.yearDuringEndedMonth,
  });
  final SimulationDatabase database;
  final int endedMonth;
  final int yearDuringEndedMonth;

  SimulationDatabase execute() {
    var database = this.database;
    final reports = <Jumper, TrainingReport?>{};
    for (var jumper in database.jumpers.last) {
      if (!database.managerData.personalCoachTeam!.jumperIds
          .contains(database.idsRepo.idOf(jumper))) {
        continue;
      } // TODO
      final attributeHistrory =
          database.jumperStats[jumper]!.progressableAttributeHistory;
      List<double> getDeltas(TrainingProgressCategory category) {
        final deltas = attributeHistrory[category]!.toDeltasList();
        final lastDeltas = deltas.reversed
            .take(daysInMonth(yearDuringEndedMonth, endedMonth))
            .toList()
            .reversed
            .toList();
        return lastDeltas.map((number) => number.toDouble()).toList();
      }

      final report = MonthlyJumperTrainingProgressReportCreator(deltas: {
        TrainingProgressCategory.takeoff: getDeltas(TrainingProgressCategory.takeoff),
        TrainingProgressCategory.flight: getDeltas(TrainingProgressCategory.flight),
        TrainingProgressCategory.landing: getDeltas(TrainingProgressCategory.landing),
        TrainingProgressCategory.consistency:
            getDeltas(TrainingProgressCategory.consistency),
        TrainingProgressCategory.form: getDeltas(TrainingProgressCategory.form),
      }).create();
      reports[jumper] = report;
    }

    reports.forEach((jumper, report) {
      database = SimulationDatabaseCommander(database: database)
          .setMonthlyReport(jumper: jumper, report: report);
    });
    return database;
  }
}
