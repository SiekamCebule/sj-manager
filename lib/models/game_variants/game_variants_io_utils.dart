import 'dart:io';

import 'package:sj_manager/json/db_items_json.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/user_db/db_items_file_system_paths.dart';
import 'package:sj_manager/utils/file_system.dart';
import 'package:path/path.dart' as path;

Future<List<T>> loadGameVariantItems<T>({
  required PlarformSpecificPathsCache pathsCache,
  required DbItemsFilePathsRegistry pathsRegistry,
  required FromJson<T> fromJson,
  required String gameVariantId,
}) async {
  return await loadItemsListFromJsonFile<T>(
    file: getFileForGameVariantItems<T>(
      pathsCache: pathsCache,
      pathsRegistry: pathsRegistry,
      gameVariantId: gameVariantId,
    ),
    fromJson: fromJson,
  );
}

Directory gameVariantDirectory({
  required PlarformSpecificPathsCache pathsCache,
  required String gameVariantId,
  String? directoryName,
}) {
  return userDataDirectory(
    pathsCache,
    path.join('game_variants', gameVariantId, directoryName),
  );
}

File getFileForGameVariantItems<T>({
  required PlarformSpecificPathsCache pathsCache,
  required DbItemsFilePathsRegistry pathsRegistry,
  required String gameVariantId,
}) {
  final fileName = pathsRegistry.get<T>();
  return fileInDirectory(
    gameVariantDirectory(pathsCache: pathsCache, gameVariantId: gameVariantId),
    fileName,
  );
}

Future<void> saveGameVariantItems<T>({
  required List<T> items,
  required PlarformSpecificPathsCache pathsCache,
  required DbItemsFilePathsRegistry pathsRegistry,
  required ToJson<T> toJson,
  required String gameVariantId,
}) async {
  await saveItemsListToJsonFile<T>(
    file: getFileForGameVariantItems<T>(
      pathsCache: pathsCache,
      pathsRegistry: pathsRegistry,
      gameVariantId: gameVariantId,
    ),
    items: items,
    toJson: toJson,
  );
}
