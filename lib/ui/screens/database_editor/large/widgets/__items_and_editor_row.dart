part of '../../database_editor_screen.dart';

class _ItemsAndEditorRow extends StatefulWidget {
  const _ItemsAndEditorRow();

  @override
  State<_ItemsAndEditorRow> createState() => _ItemsAndEditorRowState();
}

class _ItemsAndEditorRowState extends State<_ItemsAndEditorRow> {
  final _editorKey = GlobalKey<_AppropriateItemEditorState>();
  late final StreamSubscription _selectionChangesSubscription;

  @override
  void initState() {
    _setUpEditorFillingAfterSelectionChanges();
    super.initState();
  }

  void _setUpEditorFillingAfterSelectionChanges() {
    final selectedIndexesRepo = context.read<SelectedIndexesRepo>();
    _selectionChangesSubscription = selectedIndexesRepo.stream.distinct((prev, curr) {
      return prev == curr;
    }).listen((state) {
      if (selectedIndexesRepo.last.length == 1) {
        final index = selectedIndexesRepo.last.single;
        if (!mounted) return;
        final filtered =
            (context.read<DatabaseItemsCubit>().state as DatabaseItemsNonEmpty)
                .filteredItems;
        final singleSelectedItem = filtered.elementAt(index);
        _fillEditorBySingleSelected(singleSelectedItem);
      }
    });
  }

  @override
  void dispose() {
    _selectionChangesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 10,
          child: _ItemsList(),
        ),
        const Gap(UiDatabaseEditorConstants.horizontalSpaceBetweenListAndEditor / 2),
        const VerticalDivider(),
        const Gap(UiDatabaseEditorConstants.horizontalSpaceBetweenListAndEditor / 2),
        Expanded(
          flex: 16,
          child: Align(
            alignment: Alignment.topCenter,
            child: _AnimatedEditor(
              editorKey: _editorKey,
            ),
          ),
        ),
      ],
    );
  }

  void _fillEditorBySingleSelected(singleSelectedItem) {
    _editorKey.currentState?.fill(singleSelectedItem);
  }
}