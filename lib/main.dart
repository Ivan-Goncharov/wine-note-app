import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/my_themes.dart';
import 'package:provider/provider.dart';

import './models/wine_list_provider.dart';
import './models/wine_sorted_provider.dart';
import './models/wine_overview_provider.dart';
import './screens/edit_screens/search_screen.dart';
import './screens/edit_screens/edit_wine_screen.dart';
import './screens/edit_screens/wine_sort.dart';
import './screens/overview_screens/countries_overview.dart';
import './screens/overview_screens/item_filter.dart';
import './screens/search_wine_note.dart';
import './screens/overview_screens/wine_overview_screen.dart';
import './screens/edit_screens/manuf_name_search.dart';
import './screens/tabs_screen.dart';
import './screens/overview_screens/manufacturer_screen.dart';
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
      ],
      builder: (context, child) => MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        initialRoute: TabsScreen.routName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case TabsScreen.routName:
              return MaterialPageRoute(
                builder: (context) => const TabsScreen(),
                settings: settings,
              );

            case WineOverViewScreen.routNamed:
              return MaterialPageRoute(
                builder: (context) => const WineOverViewScreen(),
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

            case SearchWineNote.routName:
              return CustomPageRoute(
                child: const SearchWineNote(),
                settings: settings,
              );

            case CountriesOverview.routName:
              return MaterialPageRoute(
                builder: (context) => const CountriesOverview(),
                settings: settings,
              );

            case ManufactOverviewScreen.routName:
              return MaterialPageRoute(
                builder: (context) => const ManufactOverviewScreen(),
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
      ),
    );
  }
}
