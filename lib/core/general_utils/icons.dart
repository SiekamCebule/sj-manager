import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sj_manager/core/core_classes/sex.dart';

IconData sexIconData(Sex sex) {
  return switch (sex) {
    Sex.male => Symbols.male,
    Sex.female => Symbols.female,
  };
}
