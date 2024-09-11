import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sj_manager/models/simulation_db/event_series/event_series_calendar_preset.dart';
import 'package:sj_manager/models/user_db/items_repos_registry.dart';
import 'package:sj_manager/ui/database_item_editors/calendar_editor/simple_calendar_editor/simple_calendar_editor_screen.dart';
import 'package:sj_manager/ui/screens/database_editor/database_editor_screen.dart';
import 'package:sj_manager/ui/screens/main_screen/main_screen.dart';
import 'package:sj_manager/ui/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

void configureRoutes(FluroRouter router) {
  void define(
    String routePath,
    Widget? Function(BuildContext?, Map<String, List<String>>) handlerFunc, {
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    TransitionType? transitionType,
    Curve? inCurve,
    Curve? outCurve,
  }) {
    router.define(
      routePath,
      handler: Handler(handlerFunc: handlerFunc),
      transitionDuration: Durations.long3,
      transitionType: transitionBuilder != null ? TransitionType.custom : transitionType,
      transitionBuilder: transitionBuilder ??
          (context, animation, secondaryAnimation, child) {
            final slideIn =
                CurvedAnimation(parent: animation, curve: inCurve ?? Curves.easeInOutSine)
                    .drive(
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ),
            );
            final slideOut = CurvedAnimation(
                    parent: secondaryAnimation, curve: outCurve ?? Curves.easeOutBack)
                .drive(
              Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0, 1),
              ),
            );
            return SlideTransition(
              position: slideOut,
              child: SlideTransition(
                position: slideIn,
                child: child,
              ),
            );
          },
    );
  }

  Widget defaultInFromLeft(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final slideIn = CurvedAnimation(parent: animation, curve: Curves.easeInOutSine).drive(
      Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero),
    );
    final slideOut =
        CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeOutBack).drive(
      Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)),
    );
    return SlideTransition(
      position: slideOut,
      child: SlideTransition(position: slideIn, child: child),
    );
  }

  Widget defaultMaterialFullscreen(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final scaleIn = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic).drive(
      Tween<double>(begin: 0.9, end: 1.0),
    );

    final fadeIn = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic).drive(
      Tween<double>(begin: 0.0, end: 1.0),
    );

    final scaleOut =
        CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInCubic).drive(
      Tween<double>(begin: 1.0, end: 1.1),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: ScaleTransition(
        scale: animation.status == AnimationStatus.reverse ? scaleOut : scaleIn,
        child: child,
      ),
    );
  }

  define(
    '/',
    (context, params) => const MainScreen(),
  );
  define(
    '/settings',
    (context, params) => const SettingsScreen(),
    transitionBuilder: defaultInFromLeft,
  );
  define(
    '/databaseEditor',
    (context, params) => const DatabaseEditorScreen(),
    transitionBuilder: defaultInFromLeft,
  );
  define(
    '/databaseEditor/simpleCalendarEditor/:presetIndexInList',
    (context, params) {
      final presetIndexInList = int.parse(params['presetIndexInList']![0]);
      final preset = context!
          .read<ItemsReposRegistry>()
          .get<EventSeriesCalendarPreset>()
          .last
          .elementAt(presetIndexInList) as SimpleEventSeriesCalendarPreset;
      return MultiProvider(
        providers: defaultDbEditorProviders(context),
        child: SimpleCalendarEditorScreen(
          preset: preset,
          onChange: null,
        ),
      );
    },
    transitionType: TransitionType.custom,
    transitionBuilder: defaultMaterialFullscreen,
  );
}
