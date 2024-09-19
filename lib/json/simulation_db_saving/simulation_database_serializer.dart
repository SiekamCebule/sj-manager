import 'package:sj_manager/json/simulation_db_saving/simulation_db_part_serializer.dart';
import 'package:sj_manager/json/countries.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/simulation_db/simulation_database.dart';
import 'package:sj_manager/models/simulation_db/simulation_season.dart';
import 'package:sj_manager/models/user_db/team/team.dart';
import 'package:sj_manager/repositories/generic/items_ids_repo.dart';

class SimulationDatabaseSerializer
    implements SimulationDbPartSerializer<SimulationDatabase> {
  SimulationDatabaseSerializer({
    required this.idsRepo,
    required this.countrySaver,
    required this.seasonSerializer,
    required this.teamSerializer,
  });

  final ItemsIdsRepo idsRepo;
  final JsonCountrySaver countrySaver;
  final SimulationDbPartSerializer<SimulationSeason> seasonSerializer;
  final SimulationDbPartSerializer<Team> teamSerializer;

  late SimulationDatabase _database;
  late List<Json> _jumpersJson;
  late List<Json> _hillsJson;
  late List<Json> _teamsJson;
  late List<Json> _countriesJson;
  late List<Json> _seasonsJson;

  @override
  Json serialize(SimulationDatabase database) {
    _database = database;
    _serializeCountries();
    _serializeJumpers();
    _serializeHills();
    _serializeTeams();
    _serializeSeasons();
    return {
      'countries': _countriesJson,
      'jumpers': _jumpersJson,
      'hills': _hillsJson,
      'teams': _teamsJson,
      'seaspns': _seasonsJson,
    };
  }

  void _serializeCountries() {
    _countriesJson = _database.countries.last.map((country) {
      return country.toJson();
    }).toList();
  }

  void _serializeJumpers() {
    _jumpersJson = _database.jumpers.last.map((jumper) {
      return jumper.toJson(countrySaver: countrySaver);
    }).toList();
  }

  void _serializeHills() {
    _hillsJson = _database.hills.last.map((hill) {
      return hill.toJson(countrySaver: countrySaver);
    }).toList();
  }

  void _serializeTeams() {
    _teamsJson = _database.teams.last.map((team) {
      return teamSerializer.serialize(team);
    }).toList();
  }

  void _serializeSeasons() {
    _seasonsJson = _database.seasons.last.map((season) {
      return seasonSerializer.serialize(season);
    }).toList();
  }
}
