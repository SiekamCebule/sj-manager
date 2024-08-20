import 'package:flutter/material.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/competition_rules/default_competition_rules_preset.dart';
import 'package:sj_manager/models/simulation_db/event_series/event_series_calendar_preset.dart';
import 'package:sj_manager/models/simulation_db/event_series/event_series_setup.dart';
import 'package:sj_manager/models/user_db/country/country.dart';
import 'package:sj_manager/models/user_db/hill/hill.dart';
import 'package:sj_manager/models/user_db/jumper/jumper.dart';
import 'package:sj_manager/models/user_db/team/team.dart';
import 'package:sj_manager/setup/db_items_list_loader.dart';
import 'package:sj_manager/setup/loading_from_file/db_items_list_loader_from_file_high_level_wrapper.dart';

List<DbItemsListLoader> defaultDbItemsListLoaders(BuildContext context) => [
      DbItemsListLoaderFromFileHighLevelWrapper<Country>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku z krajami',
        loadingFailedDialogTitle: 'Nie udało się wczytać krajów',
        processItems: (source) {
          return source
              .map((country) => country.copyWith(code: country.code.toLowerCase()))
              .toList();
        },
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<Team>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku z zespołami',
        loadingFailedDialogTitle: 'Nie udało się wczytać zespołów',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<MaleJumper>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku ze skoczkami',
        loadingFailedDialogTitle: 'Nie udało się wczytać skoczków',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<FemaleJumper>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku ze skoczkiniami',
        loadingFailedDialogTitle: 'Nie udało się wczytać skoczkiń',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<Hill>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku ze skoczniami',
        loadingFailedDialogTitle: 'Nie udało się wczytać skoczni',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<EventSeriesSetup>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku z cyklami zawodów',
        loadingFailedDialogTitle: 'Nie udało się wczytać cyklów zawodów',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<EventSeriesCalendarPreset>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku z kalendarzami',
        loadingFailedDialogTitle: 'Nie udało się wczytać kalendarzy',
      ).toLowLevel(context),
      const DbItemsListLoaderFromFileHighLevelWrapper<DefaultCompetitionRulesPreset>(
        fileNotFoundDialogTitle: 'Nie znaleziono pliku z presetami konkursów',
        loadingFailedDialogTitle: 'Nie udało się wczytać cyklów presetów konkursów',
      ).toLowLevel(context),
    ];