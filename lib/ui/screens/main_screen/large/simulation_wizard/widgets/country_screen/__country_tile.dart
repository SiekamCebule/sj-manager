part of '../../simulation_wizard_dialog.dart';

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    super.key,
    required this.country,
    required this.onTap,
    required this.isSelected,
  });

  final Country country;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(4),
      ),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SimulationWizardOptionButton(
        onTap: onTap,
        isSelected: isSelected,
        child: Column(
          children: [
            const Gap(20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => CountryFlag(
                  country: country,
                  height: constraints.maxHeight,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  country.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}