import 'package:sj_manager/json/simulation_db_saving/simulation_db_part_serializer.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/judges_creator/concrete/default.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/judges_creator/judges_creator.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class JudgesCreatorSerializer implements SimulationDbPartSerializer<JudgesCreator> {
  const JudgesCreatorSerializer({
    required this.idsRepo,
  });

  final ItemsIdsRepo idsRepo;

  @override
  Json serialize(JudgesCreator creator) {
    if (creator is DefaultJudgesCreator) {
      return _parseDefault(creator);
    } else {
      throw UnsupportedError(
        '(Parsing) An unsupported JudgesCreator type (${creator.runtimeType})',
      );
    }
  }

  Json _parseDefault(DefaultJudgesCreator creator) {
    return {
      'type': 'default',
    };
  }
}