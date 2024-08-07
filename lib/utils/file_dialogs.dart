import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sj_manager/models/db/local_db_repo.dart';
import 'package:sj_manager/ui/screens/database_editor/large/dialogs/selected_db_is_not_valid_dialog.dart';
import 'package:sj_manager/utils/file_system.dart';

Future<LocalDbRepo?> pickDatabaseByDialog(BuildContext context) async {
  final path = await FilePicker.platform.getDirectoryPath();
  if (!context.mounted || path == null) return null;
  final dir = Directory(path);
  if (!directoryIsValidForDatabase(context, dir)) {
    await showDialog(
      context: context,
      builder: (context) => const SelectedDbIsNotValidDialog(),
    );
    return null;
  } else {
    return await LocalDbRepo.fromDirectory(dir, context: context);
  }
}
