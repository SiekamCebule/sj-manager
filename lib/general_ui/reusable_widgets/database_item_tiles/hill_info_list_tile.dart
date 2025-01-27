import 'package:flutter/material.dart';
import 'package:sj_manager/core/core_classes/hill/hill.dart';
import 'package:sj_manager/general_ui/responsiveness/ui_constants.dart';
import 'package:sj_manager/general_ui/reusable_widgets/countries/country_flag.dart';
import 'package:sj_manager/core/general_utils/doubles.dart';

class HillInfoListTile extends StatelessWidget {
  const HillInfoListTile({
    super.key,
    required this.reorderable,
    this.onTapWithCtrl,
    this.indexInList,
    required this.hill,
    required this.onTap,
    required this.selected,
  }) : assert(reorderable == false || (reorderable == true && indexInList != null));

  final bool reorderable;
  final int? indexInList;
  final VoidCallback? onTapWithCtrl;
  final VoidCallback? onTap;
  final Hill hill;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: CountryFlag(
        country: hill.country,
        width: UiGlobalConstants.smallCountryFlagWidth,
      ),
      title: Text('${hill.locality} HS${minimizeDecimalPlaces(hill.hs)}'),
      onTap: onTap,
      selected: selected,
      selectedTileColor: Theme.of(context).colorScheme.surfaceContainer,
      splashColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
    return reorderable
        ? ReorderableDragStartListener(
            index: indexInList!,
            child: tile,
          )
        : tile;
  }
}
