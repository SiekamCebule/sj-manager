part of '../simulation_wizard_dialog.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: MainMenuCard(
        child: Stack(
          children: [
            Center(
              child: BlocBuilder<SimulationWizardNavigationCubit,
                  SimulationWizardNavigationState>(
                builder: (context, state) {
                  return Text(
                    _appropiateTitleText(
                        context,
                        (state as InitializedSimulationWizardNavigationState)
                            .currentScreen),
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: const Icon(Symbols.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _appropiateTitleText(BuildContext context, SimulationWizardScreen screen) {
    return switch (screen) {
      SimulationWizardScreen.mode => "Wybierz tryb rozgrywki",
      SimulationWizardScreen.calendars => "Wybierz kalendarze",
      SimulationWizardScreen.country => "Wybierz swój kraj",
      SimulationWizardScreen.formGenerating => "Skonfiguruj generator formy",
      SimulationWizardScreen.otherOptions => "Przyjrzyj się innym opcjom",
      SimulationWizardScreen.simulationDepth => "Wybierz głębię symulacji",
      SimulationWizardScreen.startDate => "Wybierz datę startową",
    };
  }
}