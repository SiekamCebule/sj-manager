import 'package:flutter/material.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart';
import 'package:sj_manager/features/career_mode/presentation/widgets/jumper/simulation_jumper_image.dart';

class JumperInRankingTile extends StatelessWidget {
  const JumperInRankingTile({
    super.key,
    required this.jumper,
    required this.position,
    this.onTap,
  });

  final SimulationJumper jumper;
  final int position;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        position.toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: SimulationJumperImage(
        jumper: jumper,
        width: 25,
      ),
      title: Text(jumper.nameAndSurname()),
      onTap: onTap,
    );
  }
}
