// Mocks generated by Mockito 5.4.4 from annotations
// in sj_manager/test/competitions/ko_competition_utilities_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i17;
import 'package:sj_manager/core/core_classes/country/country.dart' as _i8;
import 'package:sj_manager/core/core_classes/hill/hill.dart' as _i6;
import 'package:sj_manager/core/core_classes/sex.dart' as _i19;
import 'package:sj_manager/core/psyche/level_of_consciousness.dart' as _i10;
import 'package:sj_manager/features/career_mode/subfeatures/subteams/domain/entities/subteam.dart'
    as _i18;
import 'package:sj_manager/features/career_mode/subfeatures/training/domain/entities/jumper_training_config.dart'
    as _i20;
import 'package:sj_manager/features/competitions/domain/entities/scoring/standings.dart'
    as _i7;
import 'package:sj_manager/features/competitions/domain/utils/ko_group_creator.dart/concrete/default.dart'
    as _i15;
import 'package:sj_manager/features/competitions/domain/utils/ko_group_creator.dart/context/ko_groups_creator_context.dart'
    as _i14;
import 'package:sj_manager/features/competitions/domain/utils/ko_round_advancement_determinator/context/ko_round_advancemenent_determinating_context.dart'
    as _i16;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/event_series/event_series.dart'
    as _i4;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/simulation_season.dart'
    as _i3;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/reports/jumper_reports.dart'
    as _i11;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart'
    as _i13;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/stats/jumper_stats.dart'
    as _i12;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/simulation_database.dart'
    as _i2;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/team/simulation_team/country_team.dart'
    as _i9;
import 'package:sj_manager/to_embrace/competition/competition.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSimulationDatabase_0 extends _i1.SmartFake
    implements _i2.SimulationDatabase {
  _FakeSimulationDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSimulationSeason_1 extends _i1.SmartFake
    implements _i3.SimulationSeason {
  _FakeSimulationSeason_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEventSeries_2 extends _i1.SmartFake implements _i4.EventSeries {
  _FakeEventSeries_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCompetition_3<E> extends _i1.SmartFake
    implements _i5.Competition<E> {
  _FakeCompetition_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHill_4 extends _i1.SmartFake implements _i6.Hill {
  _FakeHill_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStandings_5 extends _i1.SmartFake implements _i7.Standings {
  _FakeStandings_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_6 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCountry_7 extends _i1.SmartFake implements _i8.Country {
  _FakeCountry_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCountryTeam_8 extends _i1.SmartFake implements _i9.CountryTeam {
  _FakeCountryTeam_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLevelOfConsciousness_9 extends _i1.SmartFake
    implements _i10.LevelOfConsciousness {
  _FakeLevelOfConsciousness_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeJumperReports_10 extends _i1.SmartFake
    implements _i11.JumperReports {
  _FakeJumperReports_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeJumperStats_11 extends _i1.SmartFake implements _i12.JumperStats {
  _FakeJumperStats_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSimulationJumper_12 extends _i1.SmartFake
    implements _i13.SimulationJumper {
  _FakeSimulationJumper_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [KoGroupsCreatingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockKoGroupsCreatingContext<T> extends _i1.Mock
    implements _i14.KoGroupsCreatingContext<T> {
  MockKoGroupsCreatingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SimulationDatabase get simulationDatabase => (super.noSuchMethod(
        Invocation.getter(#simulationDatabase),
        returnValue: _FakeSimulationDatabase_0(
          this,
          Invocation.getter(#simulationDatabase),
        ),
      ) as _i2.SimulationDatabase);

  @override
  _i3.SimulationSeason get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSimulationSeason_1(
          this,
          Invocation.getter(#season),
        ),
      ) as _i3.SimulationSeason);

  @override
  _i4.EventSeries get eventSeries => (super.noSuchMethod(
        Invocation.getter(#eventSeries),
        returnValue: _FakeEventSeries_2(
          this,
          Invocation.getter(#eventSeries),
        ),
      ) as _i4.EventSeries);

  @override
  _i5.Competition<T> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<T>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<T>);

  @override
  int get currentRound => (super.noSuchMethod(
        Invocation.getter(#currentRound),
        returnValue: 0,
      ) as int);

  @override
  _i6.Hill get hill => (super.noSuchMethod(
        Invocation.getter(#hill),
        returnValue: _FakeHill_4(
          this,
          Invocation.getter(#hill),
        ),
      ) as _i6.Hill);

  @override
  int get entitiesCount => (super.noSuchMethod(
        Invocation.getter(#entitiesCount),
        returnValue: 0,
      ) as int);
}

/// A class which mocks [ClassicKoGroupsCreatingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockClassicKoGroupsCreatingContext<T> extends _i1.Mock
    implements _i14.ClassicKoGroupsCreatingContext<T> {
  MockClassicKoGroupsCreatingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<T> get entities => (super.noSuchMethod(
        Invocation.getter(#entities),
        returnValue: <T>[],
      ) as List<T>);

  @override
  int get entitiesCount => (super.noSuchMethod(
        Invocation.getter(#entitiesCount),
        returnValue: 0,
      ) as int);

  @override
  _i2.SimulationDatabase get simulationDatabase => (super.noSuchMethod(
        Invocation.getter(#simulationDatabase),
        returnValue: _FakeSimulationDatabase_0(
          this,
          Invocation.getter(#simulationDatabase),
        ),
      ) as _i2.SimulationDatabase);

  @override
  _i3.SimulationSeason get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSimulationSeason_1(
          this,
          Invocation.getter(#season),
        ),
      ) as _i3.SimulationSeason);

  @override
  _i4.EventSeries get eventSeries => (super.noSuchMethod(
        Invocation.getter(#eventSeries),
        returnValue: _FakeEventSeries_2(
          this,
          Invocation.getter(#eventSeries),
        ),
      ) as _i4.EventSeries);

  @override
  _i5.Competition<T> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<T>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<T>);

  @override
  int get currentRound => (super.noSuchMethod(
        Invocation.getter(#currentRound),
        returnValue: 0,
      ) as int);

  @override
  _i6.Hill get hill => (super.noSuchMethod(
        Invocation.getter(#hill),
        returnValue: _FakeHill_4(
          this,
          Invocation.getter(#hill),
        ),
      ) as _i6.Hill);
}

/// A class which mocks [RandomKoGroupsCreatingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockRandomKoGroupsCreatingContext<T> extends _i1.Mock
    implements _i14.RandomKoGroupsCreatingContext<T> {
  MockRandomKoGroupsCreatingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<T> get entities => (super.noSuchMethod(
        Invocation.getter(#entities),
        returnValue: <T>[],
      ) as List<T>);

  @override
  int get entitiesCount => (super.noSuchMethod(
        Invocation.getter(#entitiesCount),
        returnValue: 0,
      ) as int);

  @override
  int get entitiesInGroup => (super.noSuchMethod(
        Invocation.getter(#entitiesInGroup),
        returnValue: 0,
      ) as int);

  @override
  _i15.KoGroupsCreatorRemainingEntitiesAction get remainingEntitiesAction =>
      (super.noSuchMethod(
        Invocation.getter(#remainingEntitiesAction),
        returnValue: _i15.KoGroupsCreatorRemainingEntitiesAction.placeRandomly,
      ) as _i15.KoGroupsCreatorRemainingEntitiesAction);

  @override
  _i2.SimulationDatabase get simulationDatabase => (super.noSuchMethod(
        Invocation.getter(#simulationDatabase),
        returnValue: _FakeSimulationDatabase_0(
          this,
          Invocation.getter(#simulationDatabase),
        ),
      ) as _i2.SimulationDatabase);

  @override
  _i3.SimulationSeason get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSimulationSeason_1(
          this,
          Invocation.getter(#season),
        ),
      ) as _i3.SimulationSeason);

  @override
  _i4.EventSeries get eventSeries => (super.noSuchMethod(
        Invocation.getter(#eventSeries),
        returnValue: _FakeEventSeries_2(
          this,
          Invocation.getter(#eventSeries),
        ),
      ) as _i4.EventSeries);

  @override
  _i5.Competition<T> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<T>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<T>);

  @override
  int get currentRound => (super.noSuchMethod(
        Invocation.getter(#currentRound),
        returnValue: 0,
      ) as int);

  @override
  _i6.Hill get hill => (super.noSuchMethod(
        Invocation.getter(#hill),
        returnValue: _FakeHill_4(
          this,
          Invocation.getter(#hill),
        ),
      ) as _i6.Hill);
}

/// A class which mocks [KoGroupsPotsCreatingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockKoGroupsPotsCreatingContext<T> extends _i1.Mock
    implements _i14.KoGroupsPotsCreatingContext<T> {
  MockKoGroupsPotsCreatingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<List<T>> get pots => (super.noSuchMethod(
        Invocation.getter(#pots),
        returnValue: <List<T>>[],
      ) as List<List<T>>);

  @override
  int get entitiesCount => (super.noSuchMethod(
        Invocation.getter(#entitiesCount),
        returnValue: 0,
      ) as int);

  @override
  int get entitiesInGroup => (super.noSuchMethod(
        Invocation.getter(#entitiesInGroup),
        returnValue: 0,
      ) as int);

  @override
  _i15.KoGroupsCreatorRemainingEntitiesAction get remainingEntitiesAction =>
      (super.noSuchMethod(
        Invocation.getter(#remainingEntitiesAction),
        returnValue: _i15.KoGroupsCreatorRemainingEntitiesAction.placeRandomly,
      ) as _i15.KoGroupsCreatorRemainingEntitiesAction);

  @override
  _i2.SimulationDatabase get simulationDatabase => (super.noSuchMethod(
        Invocation.getter(#simulationDatabase),
        returnValue: _FakeSimulationDatabase_0(
          this,
          Invocation.getter(#simulationDatabase),
        ),
      ) as _i2.SimulationDatabase);

  @override
  _i3.SimulationSeason get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSimulationSeason_1(
          this,
          Invocation.getter(#season),
        ),
      ) as _i3.SimulationSeason);

  @override
  _i4.EventSeries get eventSeries => (super.noSuchMethod(
        Invocation.getter(#eventSeries),
        returnValue: _FakeEventSeries_2(
          this,
          Invocation.getter(#eventSeries),
        ),
      ) as _i4.EventSeries);

  @override
  _i5.Competition<T> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<T>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<T>);

  @override
  int get currentRound => (super.noSuchMethod(
        Invocation.getter(#currentRound),
        returnValue: 0,
      ) as int);

  @override
  _i6.Hill get hill => (super.noSuchMethod(
        Invocation.getter(#hill),
        returnValue: _FakeHill_4(
          this,
          Invocation.getter(#hill),
        ),
      ) as _i6.Hill);
}

/// A class which mocks [KoRoundNBestAdvancementDeterminingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockKoRoundNBestAdvancementDeterminingContext<T> extends _i1.Mock
    implements _i16.KoRoundNBestAdvancementDeterminingContext<T> {
  MockKoRoundNBestAdvancementDeterminingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SimulationDatabase get simulationDatabase => (super.noSuchMethod(
        Invocation.getter(#simulationDatabase),
        returnValue: _FakeSimulationDatabase_0(
          this,
          Invocation.getter(#simulationDatabase),
        ),
      ) as _i2.SimulationDatabase);

  @override
  _i3.SimulationSeason get season => (super.noSuchMethod(
        Invocation.getter(#season),
        returnValue: _FakeSimulationSeason_1(
          this,
          Invocation.getter(#season),
        ),
      ) as _i3.SimulationSeason);

  @override
  _i4.EventSeries get eventSeries => (super.noSuchMethod(
        Invocation.getter(#eventSeries),
        returnValue: _FakeEventSeries_2(
          this,
          Invocation.getter(#eventSeries),
        ),
      ) as _i4.EventSeries);

  @override
  _i5.Competition<T> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<T>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<T>);

  @override
  _i7.Standings get koStandings => (super.noSuchMethod(
        Invocation.getter(#koStandings),
        returnValue: _FakeStandings_5(
          this,
          Invocation.getter(#koStandings),
        ),
      ) as _i7.Standings);

  @override
  int get currentRound => (super.noSuchMethod(
        Invocation.getter(#currentRound),
        returnValue: 0,
      ) as int);

  @override
  _i6.Hill get hill => (super.noSuchMethod(
        Invocation.getter(#hill),
        returnValue: _FakeHill_4(
          this,
          Invocation.getter(#hill),
        ),
      ) as _i6.Hill);

  @override
  List<T> get entities => (super.noSuchMethod(
        Invocation.getter(#entities),
        returnValue: <T>[],
      ) as List<T>);
}

/// A class which mocks [SimulationJumper].
///
/// See the documentation for Mockito's code generation for more information.
class MockSimulationJumper extends _i1.Mock implements _i13.SimulationJumper {
  MockSimulationJumper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  DateTime get dateOfBirth => (super.noSuchMethod(
        Invocation.getter(#dateOfBirth),
        returnValue: _FakeDateTime_6(
          this,
          Invocation.getter(#dateOfBirth),
        ),
      ) as DateTime);

  @override
  set dateOfBirth(DateTime? _dateOfBirth) => super.noSuchMethod(
        Invocation.setter(
          #dateOfBirth,
          _dateOfBirth,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i17.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  set name(String? _name) => super.noSuchMethod(
        Invocation.setter(
          #name,
          _name,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get surname => (super.noSuchMethod(
        Invocation.getter(#surname),
        returnValue: _i17.dummyValue<String>(
          this,
          Invocation.getter(#surname),
        ),
      ) as String);

  @override
  set surname(String? _surname) => super.noSuchMethod(
        Invocation.setter(
          #surname,
          _surname,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i8.Country get country => (super.noSuchMethod(
        Invocation.getter(#country),
        returnValue: _FakeCountry_7(
          this,
          Invocation.getter(#country),
        ),
      ) as _i8.Country);

  @override
  set country(_i8.Country? _country) => super.noSuchMethod(
        Invocation.setter(
          #country,
          _country,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.CountryTeam get countryTeam => (super.noSuchMethod(
        Invocation.getter(#countryTeam),
        returnValue: _FakeCountryTeam_8(
          this,
          Invocation.getter(#countryTeam),
        ),
      ) as _i9.CountryTeam);

  @override
  set countryTeam(_i9.CountryTeam? _countryTeam) => super.noSuchMethod(
        Invocation.setter(
          #countryTeam,
          _countryTeam,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set subteam(_i18.Subteam? _subteam) => super.noSuchMethod(
        Invocation.setter(
          #subteam,
          _subteam,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i19.Sex get sex => (super.noSuchMethod(
        Invocation.getter(#sex),
        returnValue: _i19.Sex.male,
      ) as _i19.Sex);

  @override
  set sex(_i19.Sex? _sex) => super.noSuchMethod(
        Invocation.setter(
          #sex,
          _sex,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get takeoffQuality => (super.noSuchMethod(
        Invocation.getter(#takeoffQuality),
        returnValue: 0.0,
      ) as double);

  @override
  set takeoffQuality(double? _takeoffQuality) => super.noSuchMethod(
        Invocation.setter(
          #takeoffQuality,
          _takeoffQuality,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get flightQuality => (super.noSuchMethod(
        Invocation.getter(#flightQuality),
        returnValue: 0.0,
      ) as double);

  @override
  set flightQuality(double? _flightQuality) => super.noSuchMethod(
        Invocation.setter(
          #flightQuality,
          _flightQuality,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get landingQuality => (super.noSuchMethod(
        Invocation.getter(#landingQuality),
        returnValue: 0.0,
      ) as double);

  @override
  set landingQuality(double? _landingQuality) => super.noSuchMethod(
        Invocation.setter(
          #landingQuality,
          _landingQuality,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set trainingConfig(_i20.JumperTrainingConfig? _trainingConfig) =>
      super.noSuchMethod(
        Invocation.setter(
          #trainingConfig,
          _trainingConfig,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get form => (super.noSuchMethod(
        Invocation.getter(#form),
        returnValue: 0.0,
      ) as double);

  @override
  set form(double? _form) => super.noSuchMethod(
        Invocation.setter(
          #form,
          _form,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get jumpsConsistency => (super.noSuchMethod(
        Invocation.getter(#jumpsConsistency),
        returnValue: 0.0,
      ) as double);

  @override
  set jumpsConsistency(double? _jumpsConsistency) => super.noSuchMethod(
        Invocation.setter(
          #jumpsConsistency,
          _jumpsConsistency,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get morale => (super.noSuchMethod(
        Invocation.getter(#morale),
        returnValue: 0.0,
      ) as double);

  @override
  set morale(double? _morale) => super.noSuchMethod(
        Invocation.setter(
          #morale,
          _morale,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get fatigue => (super.noSuchMethod(
        Invocation.getter(#fatigue),
        returnValue: 0.0,
      ) as double);

  @override
  set fatigue(double? _fatigue) => super.noSuchMethod(
        Invocation.setter(
          #fatigue,
          _fatigue,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.LevelOfConsciousness get levelOfConsciousness => (super.noSuchMethod(
        Invocation.getter(#levelOfConsciousness),
        returnValue: _FakeLevelOfConsciousness_9(
          this,
          Invocation.getter(#levelOfConsciousness),
        ),
      ) as _i10.LevelOfConsciousness);

  @override
  set levelOfConsciousness(_i10.LevelOfConsciousness? _levelOfConsciousness) =>
      super.noSuchMethod(
        Invocation.setter(
          #levelOfConsciousness,
          _levelOfConsciousness,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.JumperReports get reports => (super.noSuchMethod(
        Invocation.getter(#reports),
        returnValue: _FakeJumperReports_10(
          this,
          Invocation.getter(#reports),
        ),
      ) as _i11.JumperReports);

  @override
  set reports(_i11.JumperReports? _reports) => super.noSuchMethod(
        Invocation.setter(
          #reports,
          _reports,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i12.JumperStats get stats => (super.noSuchMethod(
        Invocation.getter(#stats),
        returnValue: _FakeJumperStats_11(
          this,
          Invocation.getter(#stats),
        ),
      ) as _i12.JumperStats);

  @override
  set stats(_i12.JumperStats? _stats) => super.noSuchMethod(
        Invocation.setter(
          #stats,
          _stats,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
      ) as List<Object?>);

  @override
  int age({required DateTime? date}) => (super.noSuchMethod(
        Invocation.method(
          #age,
          [],
          {#date: date},
        ),
        returnValue: 0,
      ) as int);

  @override
  int calculateAge(DateTime? birthDate) => (super.noSuchMethod(
        Invocation.method(
          #calculateAge,
          [birthDate],
        ),
        returnValue: 0,
      ) as int);

  @override
  String nameAndSurname({
    bool? capitalizeSurname = false,
    bool? reverse = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #nameAndSurname,
          [],
          {
            #capitalizeSurname: capitalizeSurname,
            #reverse: reverse,
          },
        ),
        returnValue: _i17.dummyValue<String>(
          this,
          Invocation.method(
            #nameAndSurname,
            [],
            {
              #capitalizeSurname: capitalizeSurname,
              #reverse: reverse,
            },
          ),
        ),
      ) as String);

  @override
  _i13.SimulationJumper copyWith({
    DateTime? dateOfBirth,
    String? name,
    String? surname,
    _i8.Country? country,
    _i9.CountryTeam? countryTeam,
    _i18.Subteam? subteam,
    _i19.Sex? sex,
    double? takeoffQuality,
    double? flightQuality,
    double? landingQuality,
    _i20.JumperTrainingConfig? trainingConfig,
    double? form,
    double? jumpsConsistency,
    double? morale,
    double? fatigue,
    _i10.LevelOfConsciousness? levelOfConsciousness,
    _i11.JumperReports? reports,
    _i12.JumperStats? stats,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #copyWith,
          [],
          {
            #dateOfBirth: dateOfBirth,
            #name: name,
            #surname: surname,
            #country: country,
            #countryTeam: countryTeam,
            #subteam: subteam,
            #sex: sex,
            #takeoffQuality: takeoffQuality,
            #flightQuality: flightQuality,
            #landingQuality: landingQuality,
            #trainingConfig: trainingConfig,
            #form: form,
            #jumpsConsistency: jumpsConsistency,
            #morale: morale,
            #fatigue: fatigue,
            #levelOfConsciousness: levelOfConsciousness,
            #reports: reports,
            #stats: stats,
          },
        ),
        returnValue: _FakeSimulationJumper_12(
          this,
          Invocation.method(
            #copyWith,
            [],
            {
              #dateOfBirth: dateOfBirth,
              #name: name,
              #surname: surname,
              #country: country,
              #countryTeam: countryTeam,
              #subteam: subteam,
              #sex: sex,
              #takeoffQuality: takeoffQuality,
              #flightQuality: flightQuality,
              #landingQuality: landingQuality,
              #trainingConfig: trainingConfig,
              #form: form,
              #jumpsConsistency: jumpsConsistency,
              #morale: morale,
              #fatigue: fatigue,
              #levelOfConsciousness: levelOfConsciousness,
              #reports: reports,
              #stats: stats,
            },
          ),
        ),
      ) as _i13.SimulationJumper);
}
