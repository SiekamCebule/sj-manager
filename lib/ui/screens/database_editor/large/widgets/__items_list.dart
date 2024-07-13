part of '../../database_editor_screen.dart';

class _ItemsList extends StatefulWidget {
  const _ItemsList();

  @override
  State<_ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<_ItemsList> {
  @override
  Widget build(BuildContext context) {
    final itemsType = context.watch<DatabaseItemsTypeCubit>().state;
    final copiedLocalDbCubit = context.watch<CopiedLocalDbCubit>();
    final copiedLocalDbRepos = copiedLocalDbCubit.state!;

    final editableItemsRepoByType = copiedLocalDbRepos.byType(itemsType);
    final filtersRepo = context.watch<DbFiltersRepo>();
    final selectedIndexesRepo = context.watch<SelectedIndexesRepo>();

    final filteredItemsByType =
        context.watch<LocalDbFilteredItemsCubit>().state.byType(itemsType);
    final dbIsChangedCubit = context.watch<ChangeStatusCubit>();

    return StreamBuilder(
        stream: StreamGroup.merge([
          selectedIndexesRepo.selectedIndexes,
          copiedLocalDbRepos.femaleJumpersRepo.items,
          copiedLocalDbRepos.maleJumpersRepo.items,
          copiedLocalDbRepos.hillsRepo.items,
        ]),
        builder: (context, snapshot) {
          final listShouldBeReorderable = !filtersRepo.hasValidFilter;
          return DatabaseItemsList(
            reorderable: listShouldBeReorderable,
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              editableItemsRepoByType.move(from: oldIndex, to: newIndex);
              selectedIndexesRepo.moveSelection(from: oldIndex, to: newIndex);
              dbIsChangedCubit.markAsChanged();
            },
            length: filteredItemsByType.length,
            itemBuilder: (context, index) {
              return AppropiateDbItemListTile(
                key: ValueKey(index),
                reorderable: listShouldBeReorderable,
                itemType: itemsType,
                item: filteredItemsByType.elementAt(index),
                indexInList: index,
                onItemTap: () async {
                  bool ctrlIsPressed = HardwareKeyboard.instance.isControlPressed;
                  if (ctrlIsPressed) {
                    selectedIndexesRepo.toggleSelection(index);
                  } else {
                    selectedIndexesRepo.toggleSelectionAtOnly(index);
                  }
                },
                selected: selectedIndexesRepo.state.contains(index),
              );
            },
          );
        });
  }
}
