import 'package:flutter_my_wine_app/units/last_wine/bloc/last_wine_bloc.dart';
import 'package:flutter_my_wine_app/units/last_wine/data/last_wine_locale_data_source.dart';
import 'package:flutter_my_wine_app/units/last_wine/data/last_wine_repo_impl.dart';
import 'package:flutter_my_wine_app/units/last_wine/domain/last_wine_repo.dart';
import 'package:flutter_my_wine_app/units/splash/data/shared_pref_locale_data_source.dart';
import 'package:flutter_my_wine_app/units/splash/data/shared_pref_repo_impl.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';
import 'package:flutter_my_wine_app/units/splash/listener/splash_listener.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  /// DataSources
  getIt.registerSingleton<SharedPrefLocaleDataSource>(
      SharedPrefeLocaleDataSourceImpl());

  getIt.registerSingleton<LastWineLocaleDataSource>(
      LastWineLocaleDataSourceImpl());

  /// Repositories
  getIt.registerSingleton<SharedPrefRepo>(SharedPrefRepoImpl());
  getIt.registerSingleton<LastWineRepo>(LastWineRepoImpl());

  /// Listers and Bloc
  getIt.registerFactory(() => SplachListener());

  getIt.registerFactory(() => LastWineBloc(getIt()));
}
