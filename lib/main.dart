import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'models/wine_database_provider.dart';
import 'models/wine_filter_provider.dart';
import './models/wine_overview_provider.dart';
import './models/my_themes.dart';
import 'units/edit_wine_screen.dart';
import 'units/overview_screens/countries_overview.dart';
import 'units/overview_screens/item_filter.dart';
import 'units/tabs_screen.dart';
import 'units/overview_screens/manuf_grape_overview.dart';
import 'units/introduction/view/introdaction_screen.dart';
import 'units/introduction/view/pages_intro.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: WineDatabaseProvider()),
        ChangeNotifierProvider.value(value: WineFilterProvider()),
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
            }
            return null;
          },
        );
      },
    );
  }
}
