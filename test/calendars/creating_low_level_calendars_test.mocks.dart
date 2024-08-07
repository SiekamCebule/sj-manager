// Mocks generated by Mockito 5.4.4 from annotations
// in sj_manager/test/calendars/creating_low_level_calendars_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:sj_manager/models/db/event_series/competition/rules/competition_round_rules/competition_round_rules.dart'
    as _i3;
import 'package:sj_manager/models/db/event_series/competition/rules/competition_rules/competition_rules.dart'
    as _i2;

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

/// A class which mocks [CompetitionRules].
///
/// See the documentation for Mockito's code generation for more information.
class MockCompetitionRules<T> extends _i1.Mock
    implements _i2.CompetitionRules<T> {
  MockCompetitionRules() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.CompetitionRoundRules<T>> get rounds => (super.noSuchMethod(
        Invocation.getter(#rounds),
        returnValue: <_i3.CompetitionRoundRules<T>>[],
      ) as List<_i3.CompetitionRoundRules<T>>);

  @override
  int get roundsCount => (super.noSuchMethod(
        Invocation.getter(#roundsCount),
        returnValue: 0,
      ) as int);

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
      ) as List<Object?>);
}
