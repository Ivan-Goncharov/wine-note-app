import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/router.dart';
import 'package:provider/provider.dart';

import './models/my_themes.dart';

Future<void> main() async {
  setupGetIt();
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
    return ChangeNotifierProvider(
      create: (_) => ChangeThemeProvider(),
      builder: (context, child) {
        return MaterialApp.router(
          theme: context.watch<ChangeThemeProvider>().isDark
              ? MyTheme.darkTheme
              : MyTheme.lightTheme,
          routerConfig: NavigateRouter.router,
        );
      },
    );
  }
}
