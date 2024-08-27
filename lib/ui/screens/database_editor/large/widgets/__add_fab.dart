part of '../../database_editor_screen.dart';

class _AddFab extends StatelessWidget {
  const _AddFab();

  @override
  Widget build(BuildContext context) {
    final itemsType = context.watch<DatabaseItemsCubit>().state.itemsType;
    final selectedIndexesRepo = context.watch<SelectedIndexesRepo>();
    final itemsCubit = context.watch<DatabaseItemsCubit>();
    final itemsState = itemsCubit.state;
    final itemsLength =
        itemsState is DatabaseItemsNonEmpty ? itemsState.filteredItems.length : 0;
    final dbChangeStatusCubit = context.watch<ChangeStatusCubit>();
    final copiedDbCubit = context.watch<LocalDatabaseCopyCubit>();

    final editableItemsForCurrentType = copiedDbCubit.state!.getEditable(itemsType);
    final defaultItems = context.watch<DefaultItemsRepo>();

    return StreamBuilder<Object>(
        stream: MergeStream([
          selectedIndexesRepo.selectedIndexes,
          editableItemsForCurrentType.items,
        ]),
        builder: (context, snapshot) {
          return FloatingActionButton(
            key: const ValueKey('addFab'),
            heroTag: 'addFab',
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            onPressed: () async {
              bool selectedExists = selectedIndexesRepo.state.length == 1;

              final lastIndex = itemsLength;
              late int addIndex;
              if (selectedExists) {
                addIndex = selectedIndexesRepo.state.single + 1;
              } else {
                addIndex = lastIndex;
              }
              editableItemsForCurrentType.add(
                defaultItems.getByTypeArgument(itemsType),
                addIndex,
              );

              if (selectedExists) {
                selectedIndexesRepo.setSelection(addIndex - 1, false);
              }
              selectedIndexesRepo.setSelection(addIndex, true);
              dbChangeStatusCubit.markAsChanged();
            },
            tooltip: translate(context).add,
            child: const Icon(Symbols.add),
          );
        });
  }
}
