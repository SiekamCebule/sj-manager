import 'package:rxdart/rxdart.dart';
import 'package:sj_manager/extensions/set_toggle.dart';

class SelectedIndexesRepo {
  SelectedIndexesRepo();

  final _subject = BehaviorSubject<Set<int>>.seeded({});

  void setSelection(int index, bool selection) {
    final newSelectedIndexes = Set.of(state);
    if (selection == true) {
      newSelectedIndexes.add(index);
    } else {
      newSelectedIndexes.remove(index);
    }
    _subject.add(newSelectedIndexes);
  }

  void selectOnlyAt(int index) {
    _subject.add({index});
  }

  void toggleSelection(int index) {
    final newSelectedIndexes = Set.of(state);
    newSelectedIndexes.toggle(index);
    _subject.add(newSelectedIndexes);
  }

  void toggleSelectionAtOnly(int index) {
    var newSelectedIndexes = <int>{};
    if (state.contains(index)) {
      newSelectedIndexes = {};
    } else {
      newSelectedIndexes = {index};
    }
    _subject.add(newSelectedIndexes);
  }

  void moveSelection({required int from, required int to}) {
    final newSelectedIndexes = Set.of(state);
    if (newSelectedIndexes.contains(from)) {
      if (!newSelectedIndexes.contains(to)) {
        newSelectedIndexes.remove(from);
      }
      newSelectedIndexes.add(to);
    }
    _subject.add(newSelectedIndexes);
  }

  void clearSelection() {
    _subject.add({});
  }

  void close() {
    _subject.close();
  }

  Set<int> get state => _subject.stream.value;
  ValueStream<Set<int>> get selectedIndexes => _subject.stream;
}
