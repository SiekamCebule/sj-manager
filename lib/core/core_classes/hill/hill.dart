import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sj_manager/core/mixins/country_mixin.dart';

import 'package:sj_manager/core/general_utils/json/countries.dart';
import 'package:sj_manager/core/general_utils/json/json_types.dart';
import 'package:sj_manager/core/core_classes/country/country.dart';
import 'package:sj_manager/core/core_classes/hill/hill_profile_type.dart';
import 'package:sj_manager/core/core_classes/hill/hill_type_by_size.dart';
import 'package:sj_manager/core/core_classes/hill/jumps_variability.dart';
import 'package:sj_manager/core/core_classes/hill/landing_ease.dart';
import 'package:sj_manager/core/core_classes/hill/typical_wind_direction.dart';
import 'package:sj_manager/core/general_utils/doubles.dart';

part '../../general_utils/json/manual_json/hill_json.dart';

class Hill with EquatableMixin, CountryMixin {
  Hill({
    required this.name,
    required this.locality,
    required this.country,
    required this.k,
    required this.hs,
    required this.landingEase,
    required this.profileType,
    required this.jumpsVariability,
    this.typicalWindDirection,
    this.typicalWindStrength,
    required this.pointsForGate,
    required this.pointsForHeadwind,
    required this.pointsForTailwind,
  });

  Hill.empty({required Country country})
      : this(
          name: '',
          locality: '',
          country: country,
          k: 0,
          hs: 0,
          landingEase: LandingEase.average,
          profileType: HillProfileType.balanced,
          jumpsVariability: JumpsVariability.average,
          pointsForGate: 0,
          pointsForHeadwind: 0,
          pointsForTailwind: 0,
        );

  String name;
  String locality;

  @override
  Country country;

  double k;
  double hs;
  LandingEase landingEase;
  HillProfileType profileType;
  JumpsVariability jumpsVariability;

  TypicalWindDirection? typicalWindDirection;
  double? typicalWindStrength;

  double pointsForGate;
  double pointsForHeadwind;
  double pointsForTailwind;

  HillTypeBySize get typeBySize => HillTypeBySize.fromHsPoint(hs);

  Json toJson({required JsonCountrySaver countrySaver}) {
    return _hillToJson(this, countrySaver: countrySaver);
  }

  static Future<Hill> fromJson(Json json,
      {required JsonCountryLoader countryLoader}) async {
    return await _hillFromJson(json, countryLoader: countryLoader);
  }

  @override
  String toString() {
    return '$locality HS${minimizeDecimalPlaces(hs)}';
  }

  @override
  List<Object?> get props => [
        name,
        locality,
        country,
        k,
        hs,
        landingEase,
        profileType,
        jumpsVariability,
        typicalWindDirection,
        typicalWindStrength,
        pointsForGate,
        pointsForHeadwind,
        pointsForTailwind,
      ];

  Hill copyWith({
    String? name,
    String? locality,
    Country? country,
    double? k,
    double? hs,
    LandingEase? landingEase,
    HillProfileType? profileType,
    JumpsVariability? jumpsVariability,
    TypicalWindDirection? typicalWindDirection,
    double? typicalWindStrength,
    double? pointsForGate,
    double? pointsForHeadwind,
    double? pointsForTailwind,
  }) {
    return Hill(
      name: name ?? this.name,
      locality: locality ?? this.locality,
      country: country ?? this.country,
      k: k ?? this.k,
      hs: hs ?? this.hs,
      landingEase: landingEase ?? this.landingEase,
      profileType: profileType ?? this.profileType,
      jumpsVariability: jumpsVariability ?? this.jumpsVariability,
      typicalWindDirection: typicalWindDirection ?? this.typicalWindDirection,
      typicalWindStrength: typicalWindStrength ?? this.typicalWindStrength,
      pointsForGate: pointsForGate ?? this.pointsForGate,
      pointsForHeadwind: pointsForHeadwind ?? this.pointsForHeadwind,
      pointsForTailwind: pointsForTailwind ?? this.pointsForTailwind,
    );
  }
}
