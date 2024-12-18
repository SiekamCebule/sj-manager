import 'package:flutter/material.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart';
import 'package:sj_manager/general_ui/reusable_widgets/jumpers_ranking/jumper_in_ranking_tile.dart';

class TeamJumpersRankingList extends StatelessWidget {
  const TeamJumpersRankingList({
    super.key,
    required this.jumpers,
  });

  final Iterable<SimulationJumper> jumpers;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < jumpers.length; i++)
          JumperInRankingTile(
            jumper: jumpers.elementAt(i),
            position: i + 1,
          ),
      ],
    );
  }
}
