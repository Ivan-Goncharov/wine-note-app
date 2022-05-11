import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/my_themes.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import './models/wine_list_provider.dart';
import './models/wine_sorted_provider.dart';
import './models/wine_overview_provider.dart';
import './screens/edit_screens/search_screen.dart';
import './screens/edit_screens/edit_wine_screen.dart';
import './screens/edit_screens/wine_sort.dart';
import './screens/overview_screens/countries_overview.dart';
import './screens/overview_screens/item_filter.dart';
import './screens/edit_screens/manuf_name_search.dart';
import './screens/tabs_screen.dart';
import 'screens/overview_screens/manuf_grape_screen.dart';
import './widgets/custom_page_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: WineListProvider()),
          ChangeNotifierProvider.value(value: WineSortProvider()),
          ChangeNotifierProvider.value(value: WineOverviewProvider()),
          ChangeNotifierProvider.value(value: ChangeThemeProvider()),
        ],
        builder: (context, child) {
          final themeProvider = Provider.of<ChangeThemeProvider>(context);
          return MaterialApp(
            theme:
                themeProvider.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
            initialRoute: TabsScreen.routName,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case TabsScreen.routName:
                  return MaterialPageRoute(
                    builder: (context) {
                      return ShowCaseWidget(
                        builder: Builder(
                          builder: (context) => const TabsScreen(),
                        ),
                        autoPlay: true,
                        autoPlayDelay: const Duration(seconds: 3),
                      );
                    },
                    settings: settings,
                  );

                case EditWineScreen.routName:
                  return MaterialPageRoute(
                    builder: (context) => const EditWineScreen(),
                    settings: settings,
                  );

                case SearchScreen.routName:
                  return CustomPageRoute(
                    child: const SearchScreen(),
                    settings: settings,
                  );

                case WineSortScreen.routName:
                  return CustomPageRoute(
                    child: const WineSortScreen(),
                    settings: settings,
                  );

                case CountriesOverview.routName:
                  return MaterialPageRoute(
                    builder: (context) => const CountriesOverview(),
                    settings: settings,
                  );

                case ManufGrapeOverviewScreen.routName:
                  return MaterialPageRoute(
                    builder: (context) => const ManufGrapeOverviewScreen(),
                    settings: settings,
                  );

                case ItemFilterNotes.routName:
                  return CustomPageRoute(
                    child: const ItemFilterNotes(),
                    settings: settings,
                  );

                case ManufSearchName.routName:
                  return CustomPageRoute(
                    child: const ManufSearchName(),
                    settings: settings,
                  );
              }
            },
          );
        });
  }
}
