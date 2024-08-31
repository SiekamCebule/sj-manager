import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/concrete/default.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/ko_groups_creator.dart';
import 'package:sj_manager/utils/iterable.dart';

class DefaultPotsKoGroupsCreator<E>
    extends DefaultSizedKoGroupsCreator<E, KoGroupsPotsCreatingContext<E>> {
  @override
  void constructGroupsAndRemainingEntities() {
    final potsCount = entitiesInGroup;
    remainingEntities = context.remainingEntities;

    for (var potIndex = 0; potIndex < potsCount; potIndex++) {
      final pot = context.pots[potIndex];
      if (pot.length > entitiesInGroup) {
        throw ArgumentError(
          'A pot length (pot: $pot, length: ${pot.length}) cannot be less than entitiesInGroup ($entitiesInGroup) passed in the context',
        );
      }
      for (var entity in pot) {
        final randomGroup = groupsWithSize(potIndex).randomElement();
        randomGroup.entities.add(entity);
      }
    }
  }

  @override
  int get entitiesInGroup => context.entitiesInGroup;

  @override
  KoGroupsCreatorRemainingEntitiesAction get remainingEntitiesAction =>
      context.remainingEntitiesAction;

  @override
  List<Object?> get props => [runtimeType];
}

// Jak ustalić remainingEntities?
