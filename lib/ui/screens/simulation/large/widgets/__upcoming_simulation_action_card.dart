part of '../../simulation_route.dart';

class _UpcomingSimulationActionCard extends StatelessWidget {
  const _UpcomingSimulationActionCard({
    required this.onTap,
    required this.actionType,
    required this.important,
  });

  final VoidCallback onTap;
  final SimulationActionType actionType;
  final bool important;

  @override
  Widget build(BuildContext context) {
    final database = context.watch<SimulationDatabaseCubit>().state;
    final translator = translate(context);
    final actionText = switch (actionType) {
      SimulationActionType.settingUpTraining => translator.settingUpTraining,
      SimulationActionType.settingUpSubteams => translator.settingUpSubteams,
    };
    final dateText = sjmShortDateDescription(
      context: context,
      currentDate: database.currentDate,
      targetDate: database.actionDeadlines[actionType]!,
    );
    final textColor = important
        ? Theme.of(context).colorScheme.onErrorContainer
        : Theme.of(context).colorScheme.onTertiaryContainer;
    final titleTextStyle =
        Theme.of(context).textTheme.titleSmall!.copyWith(color: textColor);
    final subtitleTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor);

    return Material(
      color: important
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.help,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  actionText,
                  style: titleTextStyle,
                ),
                Text(
                  dateText,
                  style: subtitleTextStyle,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}