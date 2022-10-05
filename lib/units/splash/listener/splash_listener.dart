import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';
import 'package:go_router/go_router.dart';

class SplachListener extends ChangeNotifier {
  var _isFirstLaunch = true;

  Future<void> init(BuildContext context)  async {
    print('DEBUG INIT');
    _isFirstLaunch = await getIt<SharedPrefRepo>().isFirstLaunch();
    if (_isFirstLaunch) {
      print('DEBUG FIRST LAUNCH');
      context.go(introScreenRoute);
    } else {
      print('DEBUG SECNOD LAUNCH');
      context.go(tabsScreenRoute);
    }
  }
}
