import 'package:flutter_my_wine_app/getIt.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/units/last_wine/data/last_wine_locale_data_source.dart';
import 'package:flutter_my_wine_app/units/last_wine/domain/last_wine_repo.dart';

class LastWineRepoImpl extends LastWineRepo {
  @override
  Future<List<WineItem>> fetchListOfLastWine() {
    return getIt<LastWineLocaleDataSource>().fetchLastWineNotes();
  }
}
