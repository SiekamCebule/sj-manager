import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sj_manager/bloc/database_editing/local_db_filtered_items_state.dart';
import 'package:sj_manager/enums/db_editable_item_type.dart';
import 'package:sj_manager/filters/filter.dart';
import 'package:sj_manager/models/db/local_db_repo.dart';
import 'package:sj_manager/repositories/database_editing/db_filters_repository.dart';

class LocalDbFilteredItemsCubit extends Cubit<LocalDbFilteredItemsState> {
  LocalDbFilteredItemsCubit({
    required this.filtersRepo,
    required this.itemsRepo,
  }) : super(_initial) {
    _setUp();
  }

  final DbFiltersRepo filtersRepo;
  final LocalDbRepo itemsRepo;

  late final StreamSubscription _maleJumperChangesSubscription;
  late final StreamSubscription _femaleJumperChangesSubscription;
  late final StreamSubscription _hillChangesSubscription;

  void _setUp() {
    final maleStream = Rx.combineLatest2(itemsRepo.maleJumpers.items,
        filtersRepo.maleJumpersFilters, (items, filters) => (items, filters));
    _maleJumperChangesSubscription = maleStream.listen((event) {
      final jumpers = event.$1.toList();
      final filters = event.$2;
      emit(state.copyWith(maleJumpers: Filter.filterAll(jumpers, filters).cast()));
    });

    final femaleStream = Rx.combineLatest2(itemsRepo.femaleJumpers.items,
        filtersRepo.femaleJumpersFilters, (items, filters) => (items, filters));
    _femaleJumperChangesSubscription = femaleStream.listen((event) {
      final jumpers = event.$1.toList();
      final filters = event.$2;
      emit(state.copyWith(femaleJumpers: Filter.filterAll(jumpers, filters).cast()));
    });

    final hillsStream = Rx.combineLatest2(itemsRepo.hills.items, filtersRepo.hillsFilters,
        (items, filters) => (items, filters));
    _hillChangesSubscription = hillsStream.listen((event) {
      final hills = event.$1.toList();
      final filters = event.$2;
      emit(state.copyWith(hills: Filter.filterAll(hills, filters)));
    });
  }

  int findOriginalIndex(int indexFromFilteredList, DbEditableItemType type) {
    final filteredList = state.byType(type);
    final originalList = itemsRepo.editableByType(type).last;
    final filteredItem = filteredList[indexFromFilteredList];
    return originalList.indexOf(filteredItem);
  }

  void dispose() {
    _maleJumperChangesSubscription.cancel();
    _femaleJumperChangesSubscription.cancel();
    _hillChangesSubscription.cancel();
  }

  static const LocalDbFilteredItemsState _initial =
      LocalDbFilteredItemsState(maleJumpers: [], femaleJumpers: [], hills: []);
}
