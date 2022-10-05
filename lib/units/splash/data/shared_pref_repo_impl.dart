import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/units/splash/data/shared_pref_locale_data_source.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';

class SharedPrefRepoImpl implements SharedPrefRepo {
  @override
  Future<bool> isFirstLaunch() {
    return getIt<SharedPrefLocaleDataSource>().isFirstLaunch();
  }
}
