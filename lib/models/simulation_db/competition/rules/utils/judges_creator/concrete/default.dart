import 'package:sj_manager/models/simulation_db/competition/rules/utils/judges_creator/judges_creator.dart';

class DefaultJudgesCreator extends JudgesCreator {
  late JudgesCreatingContext context;

  @override
  List<double> compute(JudgesCreatingContext context) {
    setUpContext(context);
    final judges = List<double>.generate(context.judgesCount, (_) => 0);
    // TODO: FILL IT
    return judges;
  }

  void setUpContext(JudgesCreatingContext context) {
    this.context = context;
  }
}
