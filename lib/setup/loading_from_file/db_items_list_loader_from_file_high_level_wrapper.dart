import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sj_manager/exceptions/loading_database_failed_exception.dart';
import 'package:sj_manager/models/user_db/db_items_file_system_paths.dart';
import 'package:sj_manager/models/user_db/items_repos_registry.dart';
import 'package:sj_manager/repositories/generic/db_items_json_configuration.dart';
import 'package:sj_manager/setup/loading_from_file/db_items_list_loader_from_file.dart';
import 'package:sj_manager/ui/dialogs/loading_items/db_file_not_found_warning.dart';
import 'package:sj_manager/ui/dialogs/loading_items/loading_items_failed_dialog.dart';
import 'package:sj_manager/utils/file_system.dart';
import 'package:sj_manager/utils/show_dialog.dart';

class DbItemsListLoaderFromFileHighLevelWrapper<T extends Object> {
  const DbItemsListLoaderFromFileHighLevelWrapper({
    required this.fileNotFoundDialogTitle,
    required this.loadingFailedDialogTitle,
    this.processItems,
    this.customOnFinish,
  });

  final String fileNotFoundDialogTitle;
  final String loadingFailedDialogTitle;
  final List<T> Function(List<T> source)? processItems;
  final void Function(List<T> source)? customOnFinish;

  DbItemsListLoaderFromFile<T> toLowLevel(BuildContext context) {
    return DbItemsListLoaderFromFile<T>(
      filePath:
          databaseFile(context.read(), context.read<DbItemsFilePathsRegistry>().get<T>())
              .path,
      fromJson: context.read<DbItemsJsonConfiguration<T>>().fromJson,
      onError: (error, stackTrace) {
        final path = databaseFile(
                context.read(), context.read<DbItemsFilePathsRegistry>().get<T>())
            .path;
        if (error is PathNotFoundException) {
          createFileWithEmptyJsonList(path);
          showSjmDialog(
            context: context,
            child: DbFileNotFoundWarning(
              title: fileNotFoundDialogTitle,
              newFilePath: basename(path),
              targetDirectory: databaseDirectory(context.read(), '').absolute.path,
            ),
          );
        } else {
          showSjmDialog(
            context: context,
            child: LoadingItemsFailedDialog(
              titleText: loadingFailedDialogTitle,
              filePath: path,
              error: error,
            ),
          );
          throw LoadingDatabaseFailedException(lowLevelError: error);
        }
      },
      onFinish: (loaded) {
        var items = List.of(loaded);
        if (processItems != null) {
          items = processItems!(items);
        }
        if (customOnFinish != null) {
          customOnFinish!(items);
        } else {
          context.read<ItemsReposRegistry>().get<T>().set(items);
        }
      },
    );
  }
}
