import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import './models/wine_list_provider.dart';
import './models/wine_sorted_provider.dart';
import './models/wine_overview_provider.dart';
import './models/my_themes.dart';
import './screens/edit_screens/search_screen.dart';
import './screens/edit_screens/edit_wine_screen.dart';
import './screens/edit_screens/wine_sort.dart';
import './screens/overview_screens/countries_overview.dart';
import './screens/overview_screens/item_filter.dart';
import './screens/edit_screens/manuf_name_search.dart';
import './screens/tabs_screen.dart';
import './screens/overview_screens/manuf_grape_screen.dart';
import './screens/intro_screens.dart/introdaction_screen.dart';
import './screens/intro_screens.dart/pages_intro.dart';
import './widgets/custom_page_route.dart';

//переменная для хранения информации о первом запуске приложения
// true - приложение запущено впервые
// false - приложение уже было запущено до этого
bool? isFirstLaunch;

Future<void> main() async {
  //перед вызовом runApp убеждаемся, что у нас есть WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();
  //создаем экземлпяр shar.pref.,
  // делаем запрос на наличие флага - обозначения первого запуска приложения
  final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
  isFirstLaunch = _sharedPref.getBool(PagesIntro.sharedKey) ?? true;
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

        //путь навигации - зависит от того, было ли запущено приложение впервые или нет
        String _initialRoute = isFirstLaunch ?? false
            ? IntroductionScreen.routName
            : TabsScreen.routName;
        return MaterialApp(
          theme: themeProvider.isDark ? MyTheme.darkTheme : MyTheme.lightTheme,
          initialRoute: _initialRoute,
          // initialRoute: IntroductionScreen.routName,
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
                      autoPlayDelay: const Duration(seconds: 5),
                    );
                  },
                  settings: settings,
                );

              case IntroductionScreen.routName:
                return MaterialPageRoute(
                  builder: (context) => const IntroductionScreen(),
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
      },
    );
  }
}
