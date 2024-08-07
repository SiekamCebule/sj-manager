import 'package:sj_manager/models/db/country/country.dart';
import 'package:sj_manager/models/db/jumper/jumper.dart';
import 'package:sj_manager/models/db/jumper/jumper_skills.dart';
import 'package:sj_manager/models/db/jumper/jumps_consistency.dart';
import 'package:sj_manager/models/db/jumper/landing_style.dart';
import 'package:sj_manager/models/db/sex.dart';

const jumpersMale = [
  Jumper(
    name: 'Philipp',
    surname: 'Aschenwald',
    age: 28,
    country: Country(code: 'at', name: 'Austria'),
    sex: Sex.male,
    skills: JumperSkills(
      qualityOnSmallerHills: 82,
      qualityOnLargerHills: 74,
      landingStyle: LandingStyle.graceful,
      jumpsConsistency: JumpsConsistency.veryConsistent,
    ),
  ),
  Jumper(
    name: 'Daniel',
    surname: 'Huber',
    age: 31,
    country: Country(code: 'at', name: 'Austria'),
    sex: Sex.male,
    skills: JumperSkills(
      qualityOnSmallerHills: 85,
      qualityOnLargerHills: 86,
      landingStyle: LandingStyle.average,
      jumpsConsistency: JumpsConsistency.inconsistent,
    ),
  ),
  Jumper(
    name: 'Yevhen',
    surname: 'Marusiak',
    age: 24,
    country: Country(code: 'ua', name: 'Ukraina'),
    sex: Sex.male,
    skills: JumperSkills(
      qualityOnSmallerHills: 74,
      qualityOnLargerHills: 77,
      landingStyle: LandingStyle.average,
      jumpsConsistency: JumpsConsistency.inconsistent,
    ),
  ),
  Jumper(
    name: 'Vladimir',
    surname: 'Zografski',
    age: 30,
    country: Country(code: 'bg', name: 'Bułgaria'),
    sex: Sex.male,
    skills: JumperSkills(
      qualityOnSmallerHills: 77,
      qualityOnLargerHills: 75,
      landingStyle: LandingStyle.ugly,
      jumpsConsistency: JumpsConsistency.inconsistent,
    ),
  ),
];
