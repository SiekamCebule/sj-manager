import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sj_manager/models/country.dart';
import 'package:sj_manager/models/hill/hill.dart';
import 'package:sj_manager/repositories/database_editing/db_editing_defaults_repo.dart';
import 'package:sj_manager/repositories/database_editing/db_io_parameters_repo.dart';
import 'package:sj_manager/repositories/database_editing/db_items_repository.dart';
import 'package:sj_manager/json/countries.dart';
import 'package:sj_manager/json/json_types.dart';
import 'package:sj_manager/models/jumper/jumper.dart';
import 'package:sj_manager/repositories/countries/countries_repo.dart';
import 'package:sj_manager/repositories/country_flags.dart/country_flags_repo.dart';
import 'package:sj_manager/repositories/country_flags.dart/local_storage_country_flags_repo.dart';
import 'package:sj_manager/repositories/database_editing/default_items_repository.dart';
import 'package:sj_manager/setup/set_up_app.dart';
import 'package:sj_manager/ui/app.dart';
import 'package:sj_manager/ui/providers/locale_provider.dart';
import 'package:sj_manager/ui/reusable_widgets/database_item_images/hill_image/hill_image_generating_setup.dart';
import 'package:sj_manager/ui/reusable_widgets/database_item_images/jumper_image/jumper_image_generating_setup.dart';
import 'package:sj_manager/ui/screens/main_screen/main_screen.dart';
import 'package:sj_manager/ui/theme/app_theme_brightness_cubit.dart';
import 'package:sj_manager/ui/theme/color_scheme_cubit.dart';
import 'package:sj_manager/ui/theme/theme_cubit.dart';
import 'package:sj_manager/utils/file_system.dart';

final router = FluroRouter();

void main() async {
  final pathsCache = PlarformSpecificPathsCache();
  await pathsCache.setup();

  MaleJumper maleJumperFromJson(Json json, BuildContext context) {
    return MaleJumper.fromJson(
      json,
      countryLoader: JsonCountryLoaderByCode(repo: context.read()),
    );
  }

  FemaleJumper femaleJumperFromJson(Json json, BuildContext context) {
    return FemaleJumper.fromJson(
      json,
      countryLoader: JsonCountryLoaderByCode(repo: context.read()),
    );
  }

  Hill hillFromJson(Json json, BuildContext context) {
    return Hill.fromJson(
      json,
      countryLoader: JsonCountryLoaderByCode(repo: context.read()),
    );
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) => child!,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CountriesRepo>(
            create: (context) => CountriesRepo(),
          ),
          RepositoryProvider<CountryFlagsRepo>(
            create: (context) {
              final storageDirectory =
                  userDataDirectory(pathsCache, 'countries/country_flags');
              return LocalStorageCountryFlagsRepo(
                imagesDirectory: storageDirectory,
                imagesExtension: 'png',
              );
            },
          ),
          RepositoryProvider(
            create: (context) => DbItemsRepo<MaleJumper>(),
          ),
          RepositoryProvider(
            create: (context) => DbItemsRepo<FemaleJumper>(),
          ),
          RepositoryProvider(
            create: (context) => DbItemsRepo<Hill>(),
          ),
          RepositoryProvider(create: (context) {
            final noneCountry = context.read<CountriesRepo>().none;
            return DefaultItemsRepo(
              defaultFemaleJumper: FemaleJumper.empty(country: noneCountry),
              defaultMaleJumper: MaleJumper.empty(country: noneCountry),
              defaultHill: Hill.empty(country: noneCountry),
            );
          }),
          RepositoryProvider(create: (context) {
            return DbEditingDefaultsRepo.appDefault();
          }),
        ],
        child: MultiProvider(
          providers: [
            Provider(create: (context) {
              return JumperImageGeneratingSetup(
                  imagesDirectory:
                      userDataDirectory(pathsCache, 'database/jumper_images'),
                  toFileName: (jumper) {
                    return '${jumper.country.code.toLowerCase()}_${jumper.name.toLowerCase()}_${jumper.surname.toLowerCase()}';
                  },
                  extension: 'png');
            }),
            Provider(create: (context) {
              return HillImageGeneratingSetup(
                  imagesDirectory: userDataDirectory(pathsCache, 'database/hill_images'),
                  toFileName: (hill) {
                    return '${hill.locality.toLowerCase()}_${hill.hs.truncate().toString()}';
                  });
            }),
            Provider(create: (context) {
              return DbIoParametersRepo<MaleJumper>(
                storageFile: userDataFile(pathsCache, 'database/jumpers_male.json'),
                fromJson: (json) => maleJumperFromJson(json, context),
                toJson: (jumper) => jumper.toJson(
                  countrySaver: const JsonCountryCodeSaver(),
                ),
              );
            }),
            Provider(create: (context) {
              return DbIoParametersRepo<FemaleJumper>(
                storageFile: userDataFile(pathsCache, 'database/jumpers_female.json'),
                fromJson: (json) => femaleJumperFromJson(json, context),
                toJson: (jumper) => jumper.toJson(
                  countrySaver: const JsonCountryCodeSaver(),
                ),
              );
            }),
            Provider(create: (context) {
              return DbIoParametersRepo<Hill>(
                storageFile: userDataFile(pathsCache, 'database/hills.json'),
                fromJson: (json) => hillFromJson(json, context),
                toJson: (hill) => hill.toJson(
                  countrySaver: const JsonCountryCodeSaver(),
                ),
              );
            }),
            Provider(create: (context) {
              return DbIoParametersRepo<Country>(
                storageFile: userDataFile(pathsCache, 'countries/countries.json'),
                fromJson: (json) {
                  return Country.fromMultilingualJson(
                      json, context.read<LocaleProvider>().locale!.languageCode);
                },
                toJson: (hill) => {},
              );
            }),
            Provider(
              create: (context) => AppConfigurator(
                router: router,
                shouldSetUpRouting: true,
                shouldLoadDatabase: true,
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppThemeBrightnessCubit(),
              ),
              BlocProvider(
                create: (context) => AppColorSchemeCubit(),
              ),
              BlocProvider(create: (context) {
                return ThemeCubit(
                  appSchemeSubscription:
                      BlocProvider.of<AppColorSchemeCubit>(context).stream.listen(null),
                  appThemeBrightnessSubscription:
                      BlocProvider.of<AppThemeBrightnessCubit>(context)
                          .stream
                          .listen(null),
                );
              }),
            ],
            child: const App(
              home: MainScreen(),
            ),
          ),
        ),
      ),
    ),
  );
}
