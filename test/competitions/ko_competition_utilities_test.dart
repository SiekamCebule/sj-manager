import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/entities_limit.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/ko/ko_group.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/concrete/default.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/concrete/default_classic.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/concrete/default_random.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/concrete/default_with_pots.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_group_creator.dart/ko_groups_creator.dart';
import 'package:sj_manager/models/simulation_db/competition/rules/utils/ko_round_advancement_determinator/concrete/n_best.dart';
import 'package:sj_manager/models/simulation_db/standings/score/details/score_details.dart';
import 'package:sj_manager/models/simulation_db/standings/score/score.dart';
import 'package:sj_manager/models/simulation_db/standings/standings.dart';
import 'package:sj_manager/models/simulation_db/standings/standings_positions_map_creator/standings_positions_with_ex_aequos_creator.dart';
import 'package:sj_manager/models/simulation_db/standings/standings_positions_map_creator/standings_positions_with_no_ex_aequo_creator.dart';
import 'package:sj_manager/models/simulation_db/standings/standings_positions_map_creator/standings_positions_with_shuffle_on_equal_positions_creator.dart';
import 'package:sj_manager/models/user_db/country/country.dart';
import 'package:sj_manager/models/user_db/jumper/jumper.dart';

import 'ko_competition_utilities_test.mocks.dart';

@GenerateMocks([
  KoGroupsCreatingContext,
  ClassicKoGroupsCreatingContext,
  RandomKoGroupsCreatingContext,
  KoGroupsPotsCreatingContext,
  KoRoundNBestAdvancementDeterminingContext
])
void main() {
  const country = Country.emptyNone();
  group('KoGroupsCreator', () {
    group('DefaultClassicKoGroupsCreator', () {
      test(
          'Creates groups for 8 jumpers in good order (groups\'s order and the order wihin group). Checks if passing uneven number causes an error',
          () {
        final context = MockClassicKoGroupsCreatingContext<Jumper>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Dawid', surname: 'Kubacki'),
          Jumper.empty(country: country).copyWith(name: 'Piotr', surname: 'Żyła'),
          Jumper.empty(country: country).copyWith(name: 'David', surname: 'Siegel'),
          Jumper.empty(country: country)
              .copyWith(name: 'Tymoteusz', surname: 'Amilkiewicz'),
          Jumper.empty(country: country).copyWith(name: 'Yevhen', surname: 'Marusiak'),
          Jumper.empty(country: country).copyWith(name: 'Evgeniy', surname: 'Klimov'),
          Jumper.empty(country: country).copyWith(name: 'Robert', surname: 'Johansson'),
        ];
        final creator = DefaultClassicKoGroupsCreator<Jumper>();
        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        expect(
          () {
            creator.compute(context);
          },
          throwsA(isA<ArgumentError>()),
        );
        jumpers.add(
          Jumper.empty(country: country)
              .copyWith(name: 'Halvor Egner', surname: 'Granerud'),
        );
        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        final groups = creator.compute(context);
        expect(groups, [
          KoGroup(entities: [jumpers[4], jumpers[3]]),
          KoGroup(entities: [jumpers[5], jumpers[2]]),
          KoGroup(entities: [jumpers[6], jumpers[1]]),
          KoGroup(entities: [jumpers[7], jumpers[0]]),
        ]);
      });
    });

    group('DefaultRandomKoGroupsCreator', () {
      test('Even groups', () {
        final context = MockRandomKoGroupsCreatingContext<Jumper>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
        ];
        final creator = DefaultRandomKoGroupsCreator<Jumper>();

        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        when(context.entitiesInGroup).thenReturn(3);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.throwError);

        final groups = creator.compute(context);

        expect(groups.length, 3);
        expect(groups.every((group) => group.entities.length == 3), isTrue);
        expect(groups.expand((group) => group.entities).toSet().length,
            jumpers.length); // no duplicates
      });

      test('Uneven groups, remainingEntitiesAction - placeInSmallestGroup', () {
        final context = MockRandomKoGroupsCreatingContext<Jumper>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
        ];
        final creator = DefaultRandomKoGroupsCreator<Jumper>();

        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeInSmallestGroup);

        final groups = creator.compute(context);

        expect(groups.length, 2);
        expect(groups.where((group) => group.entities.length == 5).length, 2);
        expect(groups.expand((group) => group.entities).toSet().length,
            jumpers.length); // no duplicates
      });

      test('Uneven groups, remainingEntitiesAction - placeRandomly', () {
        final context = MockRandomKoGroupsCreatingContext<Jumper>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 11'),
        ];
        final creator = DefaultRandomKoGroupsCreator<Jumper>();

        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeRandomly);

        final groups = creator.compute(context);

        expect(groups.length, 2);
        expect(groups.where((group) => group.entities.length == 5).length, 1);
        expect(groups.where((group) => group.entities.length == 6).length, 1);
        expect(groups.expand((group) => group.entities).toSet().length,
            jumpers.length); // no duplicates
      });

      test('Uneven groups, remainingEntitiesAction - placeAtBegin', () {
        final context = MockRandomKoGroupsCreatingContext<Jumper>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
          Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
        ];
        final creator = DefaultRandomKoGroupsCreator<Jumper>();

        when(context.entities).thenReturn(jumpers);
        when(context.entitiesCount).thenReturn(jumpers.length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeAtBegin);

        final groups = creator.compute(context);
        expect(groups.length, 2);
        expect(groups.first.entities.length, 5);
        expect(groups[1].entities.length, 4);
        expect(groups.expand((group) => group.entities).toSet().length,
            jumpers.length); // no duplicates
      });
    });

    group('DefaultPotsKoGroupsCreator', () {
      test('Typical scenario', () {
        final context = MockKoGroupsPotsCreatingContext();
        final pots = [
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 11'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 12'),
          ],
        ];
        final creator = DefaultPotsKoGroupsCreator();

        when(context.pots).thenReturn(pots);
        when(context.entitiesCount)
            .thenReturn(pots.expand((entities) => entities).length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.throwError);

        final groups = creator.compute(context);
        expect(groups.length, 3);
        expect(groups.every((group) => group.entities.length == 4), isTrue);
        expect(groups.map((group) => group.entities.first), containsAll(pots[0]));
      });
      test('Uneven groups, remainingEntitiesAction - placeRandomly', () {
        final context = MockKoGroupsPotsCreatingContext();
        final additionalJumper =
            Jumper.empty(country: country).copyWith(name: 'Jumper 3.5');
        final pots = [
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
            additionalJumper,
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 11'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 12'),
          ],
        ];
        final creator = DefaultPotsKoGroupsCreator();
        when(context.pots).thenReturn(pots);
        when(context.entitiesCount)
            .thenReturn(pots.expand((entities) => entities).length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeRandomly);

        final groups = creator.compute(context);
        expect(groups.length, 3);
        expect(groups.where((group) => group.entities.length == 4).length, 2);
        expect(groups.where((group) => group.entities.length == 5).length, 1);
        final firstEntities = groups.map((group) => group.entities[0]);
        final secondEntities = groups.map((group) => group.entities[1]);
        expect(
          firstEntities.contains(additionalJumper) ||
              secondEntities.contains(additionalJumper),
          true,
        );
      });

      test('Overwhelming entities count in first group', () {
        final context = MockKoGroupsPotsCreatingContext();
        final pots = [
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 11'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 12'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 13'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 14'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 15'),
          ],
        ];
        final creator = DefaultPotsKoGroupsCreator();
        when(context.pots).thenReturn(pots);
        when(context.entitiesCount)
            .thenReturn(pots.expand((entities) => entities).length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeRandomly);

        final groups = creator.compute(context);
        expect(groups.length, 3);
        expect(groups.expand((group) => group.entities).length, 15);
      });

      test('Additional pot with one entity', () {
        final context = MockKoGroupsPotsCreatingContext();
        final pots = [
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 1'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 2'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 3'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 4'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 5'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 6'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 7'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 8'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 9'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 10'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 11'),
            Jumper.empty(country: country).copyWith(name: 'Jumper 12'),
          ],
          [
            Jumper.empty(country: country).copyWith(name: 'Jumper 13'),
          ],
        ];
        final creator = DefaultPotsKoGroupsCreator();
        when(context.pots).thenReturn(pots);
        when(context.entitiesCount)
            .thenReturn(pots.expand((entities) => entities).length);
        when(context.entitiesInGroup).thenReturn(4);
        when(context.remainingEntitiesAction)
            .thenReturn(KoGroupsCreatorRemainingEntitiesAction.placeRandomly);

        final groups = creator.compute(context);
        expect(groups.length, 3);
        expect(groups.where((group) => group.entities.length == 4).length, 2);
        expect(groups.where((group) => group.entities.length == 5).length, 1);
      });
    });
  });

  group('KoRoundAdvancementDeterminator', () {
    group('NBestKoRoundAdvancementDeterminator', () {
      test('Typical without ex aequo conflicts', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithExAequosCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 134.5,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.exact(1));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced, [jumpers[1]]);
      });

      test('Ex aequo on first place, but limit is exact(1)', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithExAequosCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.exact(1));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced.length, 1);
      });

      test('No ex aequos, but same points count', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithNoExAequoCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.exact(1));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced, [jumpers[0]]);
      });

      test('Shuffle on same points count', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithShuffleOnEqualPositionsCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.exact(1));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced.length, 1);
      });

      test('Soft limit + ex aequo', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithExAequosCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.soft(1));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced.toSet(), {jumpers[0], jumpers[1]});
      });

      test('Soft limit (count: 2) + ex aequo on first place', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithExAequosCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(const EntitiesLimit.soft(2));
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced.toSet(), {jumpers[0], jumpers[1]});
      });

      test('No limit', () {
        const determinator = NBestKoRoundAdvancementDeterminator<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final context = MockKoRoundNBestAdvancementDeterminingContext<Jumper,
            Standings<Jumper, SimplePointsScoreDetails>>();
        final jumpers = [
          Jumper.empty(country: country).copyWith(name: 'Kamil', surname: 'Stoch'),
          Jumper.empty(country: country).copyWith(name: 'Giovanni', surname: 'Bresadola'),
          Jumper.empty(country: country).copyWith(name: 'Martin', surname: 'Hamann'),
        ];
        final standings = Standings<Jumper, SimplePointsScoreDetails>(
          positionsCreator: StandingsPositionsWithShuffleOnEqualPositionsCreator(),
          initialScores: <Score<Jumper, SimplePointsScoreDetails>>[
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[0],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[1],
              points: 127.7,
              details: const SimplePointsScoreDetails(),
            ),
            Score<Jumper, SimplePointsScoreDetails>(
              entity: jumpers[2],
              points: 105.4,
              details: const SimplePointsScoreDetails(),
            ),
          ],
        );
        provideDummy(standings);
        when(context.entities).thenReturn(jumpers);
        when(context.limit).thenReturn(null);
        when(context.koStandings).thenReturn(
          standings,
        );
        final advanced = determinator.compute(context);
        expect(advanced, jumpers);
      });
    });
  });
}