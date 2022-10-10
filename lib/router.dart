import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_my_wine_app/units/edit_wine/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/units/introduction/view/introdaction_screen.dart';
import 'package:flutter_my_wine_app/units/overview_screens/countries_overview.dart';
import 'package:flutter_my_wine_app/units/overview_screens/item_filter.dart';
import 'package:flutter_my_wine_app/units/overview_screens/manuf_grape_overview.dart';
import 'package:flutter_my_wine_app/units/splash/view/splash_screen.dart';
import 'package:flutter_my_wine_app/units/tabs_screen.dart';
import 'package:flutter_my_wine_app/widgets/custom_page_route.dart';
import 'package:showcaseview/showcaseview.dart';

Route<dynamic>? getRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
    case tabsScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          return ShowCaseWidget(
            builder: Builder(
              builder: (context) => const TabsScreen(),
            ),
            autoPlay: true,
            autoPlayDelay: const Duration(seconds: 5),
          );
        },
        settings: settings,
      );

    case introScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const IntroductionScreen(),
        settings: settings,
      );

    case editWineRoute:
      return MaterialPageRoute(
        builder: (context) => const EditWineScreen(),
        settings: settings,
      );

    case countriesOverviewRoute:
      return MaterialPageRoute(
        builder: (context) => const CountriesOverview(),
        settings: settings,
      );

    case manufGrapeOveviewRoute:
      return MaterialPageRoute(
        builder: (context) => const ManufGrapeOverviewScreen(),
        settings: settings,
      );

    case itemFilterNotesRoute:
      return CustomPageRoute(
        child: const ItemFilterNotes(),
        settings: settings,
      );
  }
  return null;
}
