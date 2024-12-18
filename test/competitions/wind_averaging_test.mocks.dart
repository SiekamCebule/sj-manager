// Mocks generated by Mockito 5.4.4 from annotations
// in sj_manager/test/competitions/wind_averaging_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:osje_sim/osje_sim.dart' as _i7;
import 'package:sj_manager/core/core_classes/hill/hill.dart' as _i6;
import 'package:sj_manager/features/competitions/domain/utils/wind_averager/wind_averaging_context.dart'
    as _i8;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/event_series/event_series.dart'
    as _i4;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/calendar/simulation_season.dart'
    as _i3;
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/simulation_database.dart'
    as _i2;
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

class _FakeWindMeasurement_5 extends _i1.SmartFake
    implements _i7.WindMeasurement {
  _FakeWindMeasurement_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WindAveragingContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockWindAveragingContext<T> extends _i1.Mock
    implements _i8.WindAveragingContext<T> {
  MockWindAveragingContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  T get subject => (super.noSuchMethod(
        Invocation.getter(#subject),
        returnValue: _i9.dummyValue<T>(
          this,
          Invocation.getter(#subject),
        ),
      ) as T);

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
  _i5.Competition<dynamic> get competition => (super.noSuchMethod(
        Invocation.getter(#competition),
        returnValue: _FakeCompetition_3<dynamic>(
          this,
          Invocation.getter(#competition),
        ),
      ) as _i5.Competition<dynamic>);

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
  int get initialGate => (super.noSuchMethod(
        Invocation.getter(#initialGate),
        returnValue: 0,
      ) as int);

  @override
  int get gate => (super.noSuchMethod(
        Invocation.getter(#gate),
        returnValue: 0,
      ) as int);

  @override
  _i7.WindMeasurement get windMeasurement => (super.noSuchMethod(
        Invocation.getter(#windMeasurement),
        returnValue: _FakeWindMeasurement_5(
          this,
          Invocation.getter(#windMeasurement),
        ),
      ) as _i7.WindMeasurement);

  @override
  double get distance => (super.noSuchMethod(
        Invocation.getter(#distance),
        returnValue: 0.0,
      ) as double);
}
