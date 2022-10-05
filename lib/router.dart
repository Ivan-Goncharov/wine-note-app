import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_my_wine_app/units/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/units/introduction/view/introdaction_screen.dart';
import 'package:flutter_my_wine_app/units/overview_screens/countries_overview.dart';
import 'package:flutter_my_wine_app/units/overview_screens/item_filter.dart';
import 'package:flutter_my_wine_app/units/overview_screens/manuf_grape_overview.dart';
import 'package:flutter_my_wine_app/units/splash/view/splash_screen.dart';
import 'package:flutter_my_wine_app/units/tabs_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

/// Класс для навигации по приложению
class NavigateRouter {
  static final router = GoRouter(
    routes: [
      // Экран затычка в приложении
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: introScreenRoute,
        builder: (context, state) => const IntroductionScreen(),
      ),
      GoRoute(
        path: editWineRoute,
        builder: (context, state) => const EditWineScreen(),
      ),
      GoRoute(
        path: countriesOverviewRoute,
        builder: (context, state) => const CountriesOverview(),
      ),
      GoRoute(
        path: manufGrapeOveviewRoute,
        builder: (context, state) => const ManufGrapeOverviewScreen(),
      ),
      GoRoute(
        path: itemFilterNotesRoute,
        builder: (context, state) => const ItemFilterNotes(),
      ),
      GoRoute(
        path: tabsScreenRoute,
        builder: (context, state) => ShowCaseWidget(
          builder: Builder(
            builder: (context) => const TabsScreen(),
          ),
          autoPlay: true,
          autoPlayDelay: const Duration(seconds: 5),
        ),
      ),
    ],
  );
}
