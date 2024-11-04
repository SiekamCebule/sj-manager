import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sj_manager/repositories/generic/value_repo.dart';

class ItemsRepo<T> extends ValueRepo<List<T>> with EquatableMixin {
  ItemsRepo({super.initial});

  @override
  ValueStream<List<T>> get items;

  Type get itemsType => T;

  @override
  List<T> get last => items.valueOrNull ?? [];

  int get lastLength => last.length;

  @override
  List<Object?> get props => [
        items,
      ];
}
