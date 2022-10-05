import 'package:flutter_my_wine_app/models/wine_item.dart';

abstract class LastWineRepo {
  Future<List<WineItem>> fetchListOfLastWine();
}
