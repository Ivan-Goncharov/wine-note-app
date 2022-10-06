import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';

class SplachListener extends ChangeNotifier {
  var _isFirstLaunch = true;

  Future<void> init(BuildContext context)  async {
    _isFirstLaunch = await getIt<SharedPrefRepo>().isFirstLaunch();
    if (_isFirstLaunch) {
      Navigator.pushReplacementNamed(context, introScreenRoute);
    } else {
      Navigator.pushReplacementNamed(context, tabsScreenRoute);
    }
  }
}
