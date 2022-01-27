import 'package:flutter/material.dart';

import 'package:flutter_my_wine_app/providers/wine_notes_list_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';
import 'package:flutter_my_wine_app/screens/wine_overview_screen.dart';
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
      create: (context) => WineNotesListProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        routes: {
          '/': (ctx) => TabsScreen(),
          WineFullDescripScreen.routname: (ctx) => WineFullDescripScreen(),
          WineOverViewScreen.routNamed: (ctx) => WineOverViewScreen(),
          EditWineScreen.routName: (ctx) => EditWineScreen(),
        },
      ),
    );
  }
}
