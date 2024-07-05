import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sj_manager/l10n/helpers.dart';
import 'package:sj_manager/ui/theme/app_schemes.dart';

class AppColorSchemeDropdownListTile extends StatelessWidget {
  const AppColorSchemeDropdownListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: ListTile(
            title: Text(
              translate(context).colorScheme,
            ),
            leading: const Icon(Symbols.palette),
          ),
        ),
        const DropdownMenu(
          dropdownMenuEntries: [
            DropdownMenuEntry(value: AppColorScheme.blue, label: 'Niebieski'),
            DropdownMenuEntry(value: AppColorScheme.yellow, label: 'Żółty'),
            DropdownMenuEntry(value: AppColorScheme.red, label: 'Czerwony'),
          ],
        ),
      ],
    );
  }
}
