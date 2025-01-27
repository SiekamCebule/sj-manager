import 'package:sj_manager/features/career_mode/subfeatures/jumper_reports/domain/repository/jumper_reports_repository.dart';
import 'package:sj_manager/features/career_mode/subfeatures/jumpers/domain/repository/simulation_jumpers_repository.dart';
import 'package:sj_manager/features/career_mode/subfeatures/jumper_reports/domain/usecases/monthly_training/create_monthly_training_single_report_use_case.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/reports/jumper_reports.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart';

class SetUpMonthlyTrainingReportsUseCase {
  const SetUpMonthlyTrainingReportsUseCase({
    required this.jumpersRepository,
    required this.reportsRepository,
    required this.createSingleReport,
  });

  final SimulationJumpersRepository jumpersRepository;
  final JumperReportsRepository reportsRepository;
  final CreateMonthlyTrainingSingleReportUseCase createSingleReport;

  Future<void> call() async {
    final reports = <SimulationJumper, TrainingReport?>{};
    final jumpers = await jumpersRepository.getAll();
    for (var jumper in jumpers) {
      final report = await createSingleReport(jumper);
      reports[jumper] = report;
      await reportsRepository.setMonthlyTrainingReport(jumper: jumper, report: report);
    }
  }
}
