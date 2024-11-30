import 'package:sj_manager/core/countries/countries_repository/countries_repository.dart';
import 'package:sj_manager/core/countries/countries_repository/in_memory_countries_repository.dart';
import 'package:sj_manager/features/career_mode/subfeatures/actions/domain/entities/simulation_action.dart';
import 'package:sj_manager/features/career_mode/subfeatures/jumper_stats/domain/entities/jumper_attribute.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/manager_data/simulation_manager_data.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/stats/jumper_attribute_history.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/stats/jumper_stats.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/simulation_mode.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/simulation_database.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/simulation_season.dart';
import 'package:sj_manager/features/simulations/presentation/simulation_wizard/simulation_wizard_options_repo.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/reports/jumper_reports.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/details/classification_score_details.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/details/competition_score_details.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/details/jump_score_details.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/standings/score/score.dart';
import 'package:sj_manager/core/core_classes/hill/hill.dart';
import 'package:sj_manager/core/psyche/psyche_utils.dart';
import 'package:sj_manager/core/core_classes/country_team/country_team_db_record.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/team/simulation_team/personal_coach_team.dart';
import 'package:sj_manager/features/career_mode/subfeatures/subteams/domain/entities/subteam.dart';
import 'package:sj_manager/core/general_utils/ids_repository.dart';
import 'package:sj_manager/core/general_utils/id_generator.dart';

class DefaultSimulationDatabaseCreator {
  DefaultSimulationDatabaseCreator({
    required this.idGenerator,
  });

  final IdGenerator idGenerator;

  late IdsRepository<String> _idsRepo;
  late List<SimulationJumper> _jumpers;
  late List<Hill> _hills;
  late List<CountryTeamDbRecord> _countryTeams;
  late CountriesRepository _countries;
  late List<SimulationSeason> _seasons;

  Future<SimulationDatabase> create(SimulationWizardOptions options) async {
    final mode = options.mode!;
    _idsRepo = IdsRepository();
    _hills = List.of(options.gameVariant!.hills);
    _countryTeams = options.gameVariant!.countryTeams
        .map((countryTeamDbRecord) => countryTeamDbRecord.toSimulationCountryTeam());
    _countries = InMemoryCountriesRepository(countries: options.gameVariant!.countries);
    _seasons = List.of([options.gameVariant!.season]);
    const attributeHistoryLimit =
        31; // Max number of days in a month. The biggest need is when we create a monthly training report.
    final jumperRecords = List.of(options.gameVariant!.jumpers);

    _jumpers = jumperRecords.map(
      (dbRecord) {
        return SimulationJumper(
          dateOfBirth: dbRecord.dateOfBirth,
          name: dbRecord.name,
          surname: dbRecord.surname,
          country: dbRecord.country,
          countryTeam: _countryTeams
              .singleWhere((countryTeam) => countryTeam.country == dbRecord.country),
              subteam: ,
          sex: dbRecord.sex,
          takeoffQuality: dbRecord.skills.takeoffQuality,
          flightQuality: dbRecord.skills.flightQuality,
          landingQuality: dbRecord.skills.landingQuality,
          trainingConfig: null,
          form: 10,
          jumpsConsistency: 5,
          morale: 0,
          fatigue: 0,
          levelOfConsciousness: locByPersonality(dbRecord.personality),
          reports: JumperReports(
            levelReport: null,
            weeklyTrainingReport: null,
            monthlyTrainingReport: null,
            moraleRating: null,
            jumpsRating: null,
          ),
          stats: JumperStats(progressableAttributeHistory: {
            JumperAttributeType.takeoffQuality:
                JumperAttributeHistory.empty(limit: attributeHistoryLimit),
            JumperAttributeType.flightQuality:
                JumperAttributeHistory.empty(limit: attributeHistoryLimit),
            JumperAttributeType.landingQuality:
                JumperAttributeHistory.empty(limit: attributeHistoryLimit),
            JumperAttributeType.consistency:
                JumperAttributeHistory.empty(limit: attributeHistoryLimit),
            JumperAttributeType.form:
                JumperAttributeHistory.empty(limit: attributeHistoryLimit),
          }),
        );
      },
    ).toList();
    await _setUpIdsRepo();
    final personalCoachTeam = options.mode! == SimulationMode.personalCoach
        ? PersonalCoachTeam(jumpers: [], reports: null)
        : null;
    _idsRepo.register(personalCoachTeam, id: idGenerator.generate());
    final userSubteam = mode == SimulationMode.classicCoach
        ? Subteam(
            parentTeam: options.team!,
            type: options.subteamType!,
            jumpers: [],
          )
        : null;
    final earliestDate = options.gameVariant!.startDates.first;
    return SimulationDatabase(
      managerData: SimulationManagerData(
        mode: mode,
        userSubteam: userSubteam,
        personalCoachTeam: personalCoachTeam,
      ),
      startDate: earliestDate.date,
      currentDate: earliestDate.date,
      jumpers: _jumpers,
      hills: _hills,
      countryTeams: _countryTeams,
      countries: _countries,
      seasons: _seasons,
      idsRepository: _idsRepo,
      actions: [
        for (var actionType in options.gameVariant!.actionDeadlines.keys)
          SimulationAction(
            type: actionType,
            deadline: options.gameVariant!.actionDeadlines[actionType],
            isCompleted: false,
          )
      ],
    );
  }

  Future<void> _setUpIdsRepo() async {
    void register(dynamic item) {
      _idsRepo.register(item, id: idGenerator.generate());
    }

    final items = [
      ..._jumpers,
      ..._hills,
      ..._countryTeams,
      ...(await _countries.getAll()),
      ..._seasons,
      for (var season in _seasons) ...[
        for (var eventSeries in season.eventSeries) ...[
          eventSeries,
          for (var competition in eventSeries.calendar.competitions) ...[
            competition,
            competition.rules,
            for (var score in competition.standings?.scores ?? <Score>[]) ...[
              score,
              score.entity,
              score.details,
              if (score.details is CompetitionJumperScoreDetails) ...[
                ...(score.details as CompetitionJumperScoreDetails).jumpScores,
                ...(score.details as CompetitionJumperScoreDetails)
                    .jumpScores
                    .map((score) => score.details.jumpRecord),
              ],
              if (score.details is CompetitionTeamScoreDetails) ...[
                ...(score.details as CompetitionTeamScoreDetails).jumperScores,
                ...(score.details as CompetitionTeamScoreDetails).jumpScores,
                ...(score.details as CompetitionTeamScoreDetails)
                    .jumpScores
                    .map((score) => score.details.jumpRecord),
              ],
              if (score.details is JumpScoreDetails)
                ...(score.details as CompetitionJumperScoreDetails).jumpScores,
            ],
          ],
          for (var classification in eventSeries.calendar.classifications) ...[
            classification,
            classification.rules,
            for (var score in classification.standings?.scores ?? <Score>[]) ...[
              score,
              score.entity,
              score.details,
              if (score.details is ClassificationScoreDetails) ...[
                ...(score.details as ClassificationScoreDetails).competitionScores,
                ...(score.details as ClassificationScoreDetails)
                    .competitionScores
                    .map((score) => score.details.jumpScores),
              ],
            ],
          ],
        ],
      ],
    ];
    items.forEach(register);
  }
}
