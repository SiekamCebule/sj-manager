import 'package:flutter/material.dart';
import 'package:sj_manager/utils/close_app.dart';
import 'package:sj_manager/utils/fonts.dart';

class LoadingItemsFailedDialog extends StatelessWidget {
  const LoadingItemsFailedDialog({
    super.key,
    required this.titleText,
    required this.filePath,
    required this.error,
    required this.stackTrace,
  });

  final String titleText;
  final String filePath;
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: SingleChildScrollView(
        child: RichText(
          text: TextSpan(
            style: dialogLightFont(context),
            children: [
              TextSpan(text: 'Jeśli edytowałeś plik ', style: dialogLightFont(context)),
              TextSpan(text: filePath, style: dialogBoldFont(context)),
              TextSpan(
                  text: ', sprawdź jego poprawność.\n\n',
                  style: dialogLightFont(context)),
              TextSpan(
                text: '${error.toString()}\n${stackTrace.toString()}',
                style: dialogLightItalicFont(context),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await closeApp();
          },
          child: const Text('Zamknij aplikację'),
        ),
      ],
    );
  }
}
