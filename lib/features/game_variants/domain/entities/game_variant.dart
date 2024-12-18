import 'package:sj_manager/core/core_classes/game_variant_start_date.dart';
import 'package:sj_manager/features/career_mode/subfeatures/actions/domain/entities/simulation_action_type.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/simulation_season.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/reports/jumper_level_description.dart';
import 'package:sj_manager/core/core_classes/country/country.dart';
import 'package:sj_manager/core/core_classes/hill/hill.dart';
import 'package:sj_manager/features/database_editor/domain/entities/jumper/jumper_db_record.dart';
import 'package:sj_manager/core/core_classes/country_team/country_team_db_record.dart';
import 'package:sj_manager/features/career_mode/subfeatures/subteams/domain/entities/subteam.dart';
import 'package:sj_manager/core/general_utils/multilingual_string.dart';

class GameVariant {
  const GameVariant({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.jumpers,
    required this.hills,
    required this.countries,
    required this.countryTeams,
    required this.season,
    required this.startDates,
    required this.actionDeadlines,
    required this.jumperLevelRequirements,
  });

  final String id;
  final MultilingualString name;
  final MultilingualString shortDescription;
  final MultilingualString longDescription;
  final List<JumperDbRecord> jumpers;
  final List<Hill> hills;
  final List<Country> countries;
  final List<CountryTeamDbRecord> countryTeams;
  final SimulationSeason season;
  final List<GameVariantStartDate> startDates;
  final Map<SimulationActionType, DateTime> actionDeadlines;
  final Map<JumperLevelDescription, double> jumperLevelRequirements;

  GameVariant copyWith({
    String? id,
    MultilingualString? name,
    MultilingualString? shortDescription,
    MultilingualString? longDescription,
    List<JumperDbRecord>? jumpers,
    List<Hill>? hills,
    List<Country>? countries,
    List<CountryTeamDbRecord>? countryTeams,
    List<Subteam>? subteams,
    SimulationSeason? season,
    List<GameVariantStartDate>? startDates,
    Map<SimulationActionType, DateTime>? actionDeadlines,
    Map<JumperLevelDescription, double>? jumperLevelRequirements,
  }) {
    return GameVariant(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      jumpers: jumpers ?? List<JumperDbRecord>.from(this.jumpers),
      hills: hills ?? List<Hill>.from(this.hills),
      countries: countries ?? List<Country>.from(this.countries),
      countryTeams: countryTeams ?? List<CountryTeamDbRecord>.from(this.countryTeams),
      season: season ?? this.season,
      startDates: startDates ?? List<GameVariantStartDate>.from(this.startDates),
      actionDeadlines: actionDeadlines ??
          Map<SimulationActionType, DateTime>.from(this.actionDeadlines),
      jumperLevelRequirements: jumperLevelRequirements ??
          Map<JumperLevelDescription, double>.from(this.jumperLevelRequirements),
    );
  }
}
