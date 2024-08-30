import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sj_manager/bloc/database_editing/state/database_editor_countries_state.dart';
import 'package:sj_manager/models/user_db/country/country.dart';
import 'package:sj_manager/models/user_db/sex.dart';
import 'package:sj_manager/models/user_db/team/country_team.dart';
import 'package:sj_manager/repositories/countries/countries_repo.dart';
import 'package:sj_manager/repositories/countries/country_facts/teams_repo.dart';

class DatabaseEditorCountriesCubit extends Cubit<DatabaseEditorCountriesState> {
  DatabaseEditorCountriesCubit({
    required this.countriesRepo,
    required this.teamsRepo,
  }) : super(
          const DatabaseEditorCountriesInitial(),
        );

  final CountriesRepo countriesRepo;
  final TeamsRepo<CountryTeam> teamsRepo;

  void setUp() {
    final rawTeams = teamsRepo.last.toList();
    final noneCountry = countriesRepo.none;

    final maleTeamsByStars = _teamsBySex(_teamsByStars(rawTeams), Sex.male);
    final femaleTeamsByStars = _teamsBySex(_teamsByStars(rawTeams), Sex.female);

    final maleJumpersCountries = [
      noneCountry,
      ..._countriesHavingTeam(maleTeamsByStars),
    ];
    final femaleJumpersCountries = [
      noneCountry,
      ..._countriesHavingTeam(femaleTeamsByStars)
    ];
    final universalCountries = [
      noneCountry,
      ..._constructUniversalCountries(
        maleTeams: maleTeamsByStars,
        femaleTeams: femaleTeamsByStars,
      )
    ];
    emit(
      DatabaseEditorCountriesReady(
        maleJumpersCountries: CountriesRepo(initial: maleJumpersCountries),
        femaleJumpersCountries: CountriesRepo(initial: femaleJumpersCountries),
        universalCountries: CountriesRepo(initial: universalCountries),
      ),
    );
  }

  List<CountryTeam> _teamsByStars(List<CountryTeam> teams, {bool ascending = false}) {
    var copiedTeams = List.of(teams);
    final descending = !ascending;

    copiedTeams.sort((first, second) => first.facts.stars.compareTo(second.facts.stars));
    if (descending) {
      copiedTeams = copiedTeams.reversed.toList();
    }

    return copiedTeams;
  }

  List<CountryTeam> _teamsBySex(List<CountryTeam> teams, Sex sex) {
    return teamsRepo.last.where((team) => team.sex == sex).toList();
  }

  List<Country> _countriesHavingTeam(List<CountryTeam> teams) {
    final countries = <Country>{};
    for (var team in teams) {
      countries.add(team.country);
    }
    return countries.toList();
  }

  List<Country> _constructUniversalCountries({
    required List<CountryTeam> maleTeams,
    required List<CountryTeam> femaleTeams,
  }) {
    final starsByCountry = <Country, int>{};

    for (var maleTeam in maleTeams) {
      starsByCountry[maleTeam.country] =
          maleTeam.facts.stars + (starsByCountry[maleTeam.country] ?? 0);
    }

    for (var femaleTeam in femaleTeams) {
      starsByCountry[femaleTeam.country] =
          femaleTeam.facts.stars + (starsByCountry[femaleTeam.country] ?? 0);
    }

    final averageStarsByCountry = starsByCountry.map((country, totalStars) {
      final averageStars = totalStars / 2;
      return MapEntry(country, averageStars);
    });

    final sortedCountries = averageStarsByCountry.keys.toList()
      ..sort((a, b) => averageStarsByCountry[b]!.compareTo(averageStarsByCountry[a]!));

    return sortedCountries;
  }

  void dispose() {
    if (state is DatabaseEditorCountriesInitial) {
      throw StateError(
          'Cannot dispose DatabaseEditorCountriesCubit when its state is initial');
    }
    final readyState = state as DatabaseEditorCountriesReady;
    readyState.maleJumpersCountries.dispose();
    readyState.femaleJumpersCountries.dispose();
    readyState.universalCountries.dispose();
  }
}