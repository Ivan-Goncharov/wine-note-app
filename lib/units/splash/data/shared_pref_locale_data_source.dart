import 'package:flutter_my_wine_app/constants/other_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefLocaleDataSource {
  Future<bool> isFirstLaunch();
}

class SharedPrefeLocaleDataSourceImpl implements SharedPrefLocaleDataSource {
  @override
  Future<bool> isFirstLaunch() async {
    // Cоздаем экземлпяр shar.pref.,
    // Делаем запрос на наличие флага - обозначения первого запуска приложения
    final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    return _sharedPref.getBool(sharedPrefFirstLaunchKey) ?? true;
  }
}
