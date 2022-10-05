import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

abstract class LastWineLocaleDataSource {
  Future<List<WineItem>> fetchLastWineNotes();
}

class LastWineLocaleDataSourceImpl implements LastWineLocaleDataSource {
  @override
  Future<List<WineItem>> fetchLastWineNotes() {
    return DBProvider.instanse.fetchLastTenWine();
  }
}
