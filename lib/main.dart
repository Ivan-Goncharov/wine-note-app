import 'package:flutter/material.dart';

import 'package:flutter_my_wine_app/screens/edit_screens/search_screen.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/wine_sort.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';
import 'package:flutter_my_wine_app/screens/wine_overview_screen.dart';
import 'package:flutter_my_wine_app/widgets/custom_page_route.dart';

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
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const TabsScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case WineFullDescripScreen.routName:
            return MaterialPageRoute(
              builder: (context) => WineFullDescripScreen(),
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
        }
      },
      // routes: {
      //   '/': (ctx) => TabsScreen(),
      //   WineFullDescripScreen.routName: (ctx) => WineFullDescripScreen(),
      //   WineOverViewScreen.routNamed: (ctx) => WineOverViewScreen(),
      //   EditWineScreen.routName: (ctx) => EditWineScreen(),
      // },
    );
  }
}
