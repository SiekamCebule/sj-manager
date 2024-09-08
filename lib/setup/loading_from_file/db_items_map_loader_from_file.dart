import 'dart:io';

import 'package:sj_manager/json/db_items_json.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/setup/db_items_list_loader.dart';

class DbItemsMapLoaderFromFile<T extends Object> extends DbItemsListLoader {
  DbItemsMapLoaderFromFile({
    required this.filePath,
    required this.fromJson,
    required this.onError,
    required this.onFinish,
  });

  final String filePath;
  final FromJson<T> fromJson;
  final Function(Object error, StackTrace stackTrace) onError;
  final Function(LoadedItemsMap<T> loaded) onFinish;

  @override
  Future<void> load() async {
    try {
      var loaded =
          await loadItemsMapFromJsonFile<T>(file: File(filePath), fromJson: fromJson);
      onFinish(loaded);
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }
}