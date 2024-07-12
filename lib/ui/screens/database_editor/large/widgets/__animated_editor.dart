part of '../../database_editor_screen.dart';

class _AnimatedEditor extends StatelessWidget {
  const _AnimatedEditor({
    this.editorKey,
  });

  final GlobalKey<_AppropiateItemEditorState>? editorKey;

  @override
  Widget build(BuildContext context) {
    final itemsType = context.watch<DatabaseItemsTypeCubit>().state;

    final copiedLocalDbCubit = context.watch<CopiedLocalDbCubit>();
    final copiedLocalDbRepos = copiedLocalDbCubit.state!;
    final editableItemsRepoByType = copiedLocalDbRepos.byType(itemsType);

    final filtersRepo = context.watch<DbFiltersRepo>();
    final selectedIndexesRepo = context.watch<SelectedIndexesRepo>();
    final dbIsChangedCubit = context.watch<ChangeStatusCubit>();
    final filteredItemsCubit = context.watch<LocalDbFilteredItemsCubit>();

    return StreamBuilder(
        stream: MergeStream([
          selectedIndexesRepo.selectedIndexes,
          editableItemsRepoByType.items,
          filtersRepo.byType(itemsType),
        ]),
        builder: (context, snapshot) {
          final editorShouldBeVisible = selectedIndexesRepo.state.length == 1;
          return Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: editorShouldBeVisible,
            child: AnimatedOpacity(
              duration: Durations.short3,
              curve: Curves.easeIn,
              opacity: editorShouldBeVisible ? 1 : 0,
              child: _AppropiateItemEditor(
                key: editorKey,
                itemType: itemsType,
                onChange: (changedItem) async {
                  if (selectedIndexesRepo.state.length == 1 && changedItem != null) {
                    if (!filtersRepo.hasValidFilter) {
                      final index = selectedIndexesRepo.state.single;
                      editableItemsRepoByType.replace(
                          oldIndex: index, newItem: changedItem);
                      dbIsChangedCubit.markAsChanged();
                    } else {
                      final indexInFiltered = selectedIndexesRepo.state.single;
                      final indexInOriginal = filteredItemsCubit.findOriginalIndex(
                          indexInFiltered, itemsType);
                      editableItemsRepoByType.replace(
                          oldIndex: indexInOriginal, newItem: changedItem);
                      dbIsChangedCubit.markAsChanged();
                    }
                  }
                },
              ),
            ),
          );
        });
  }
}
