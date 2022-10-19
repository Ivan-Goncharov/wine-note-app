import 'package:flutter_my_wine_app/units/splash/data/shared_pref_locale_data_source.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';

class SharedPrefRepoImpl implements SharedPrefRepo {
  final SharedPrefLocaleDataSource _dataSource;
  const SharedPrefRepoImpl(this._dataSource);
  @override
  Future<bool> isFirstLaunch() {
    return _dataSource.isFirstLaunch();
  }

  @override
  Future<void> saveFirstLaunch() {
    return  _dataSource.saveFirstLaunch();
  }
}
