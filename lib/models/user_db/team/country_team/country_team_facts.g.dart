// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_team_facts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryTeamFacts _$CountryTeamFactsFromJson(Map<String, dynamic> json) =>
    CountryTeamFacts(
      stars: (json['stars'] as num).toInt(),
      record: json['record'] == null
          ? null
          : SimpleJump.fromJson(json['record'] as Map<String, dynamic>),
      subteams: (json['subteams'] as List<dynamic>)
          .map((e) => $enumDecode(_$SubteamTypeEnumMap, e))
          .toSet(),
      limitInSubteam: (json['limitInSubteam'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$SubteamTypeEnumMap, k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$CountryTeamFactsToJson(CountryTeamFacts instance) =>
    <String, dynamic>{
      'stars': instance.stars,
      'record': instance.record,
      'subteams':
          instance.subteams.map((e) => _$SubteamTypeEnumMap[e]!).toList(),
      'limitInSubteam': instance.limitInSubteam
          .map((k, e) => MapEntry(_$SubteamTypeEnumMap[k]!, e)),
    };

const _$SubteamTypeEnumMap = {
  SubteamType.a: 'a',
  SubteamType.b: 'b',
  SubteamType.c: 'c',
  SubteamType.d: 'd',
};
