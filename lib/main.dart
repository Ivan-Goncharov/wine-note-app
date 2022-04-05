import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';

import 'package:flutter_my_wine_app/screens/edit_screens/search_screen.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/wine_sort.dart';
import 'package:flutter_my_wine_app/screens/search_wine_note.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';
import 'package:flutter_my_wine_app/screens/wine_overview_screen.dart';
import 'package:flutter_my_wine_app/widgets/custom_page_route.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';

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
    return ChangeNotifierProvider(
      create: (context) => WineListProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        // home: const TabsScreen(),
        initialRoute: TabsScreen.routName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case WineFullDescripScreen.routName:
              return MaterialPageRoute(
                builder: (context) => const WineFullDescripScreen(),
                settings: settings,
              );

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
          }
        },
      ),
    );
  }
}
