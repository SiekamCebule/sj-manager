import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sj_manager/features/career_mode/presentation/bloc/my_team_cubit.dart';
import 'package:sj_manager/features/simulations/domain/entities/simulation/database/jumper/simulation_jumper.dart';
import 'package:sj_manager/core/country_flags/country_flags_repository.dart';
import 'package:sj_manager/general_ui/reusable_widgets/database_item_images/db_item_image_generating_setup.dart';
import 'package:sj_manager/core/general_utils/dialogs.dart';
import 'package:sj_manager/features/career_mode/presentation/dialogs/set_up_subteams/subteams_set_up_personal_coach_dialog.dart';

Future<void> showSubteamsSetUpPersonalCoachDialog({
  required BuildContext context,
}) async {
  final myTeamState = context.read<MyTeamCubit>().state as MyTeamDefault;
  return await showSjmDialog(
    barrierDismissible: true,
    context: context,
    child: MultiProvider(
      providers: [
        Provider.value(
            value: context.read<DbItemImageGeneratingSetup<SimulationJumper>>()),
        Provider.value(value: context.read<CountryFlagsRepository>()),
      ],
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SubteamsSetUpPersonalCoachDialog(
          jumpers: myTeamState.trainees,
        ),
      ),
    ),
  );
}
