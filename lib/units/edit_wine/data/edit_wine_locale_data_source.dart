import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

abstract class EditWineLocaleDataSource {
  /// Поиск вина по БД
  Future<WineItem> getWineByid(String id);

  /// Обновить заметку
  Future<void> updateNote(WineItem note);

  /// Создать новую заметку
  Future<void> addNewNote(WineItem note);

  /// Создать новый файл по данному пути
  Future<String> saveImageFile(String fileImage);
}

class EditWineLocaleDataSourceImpl extends EditWineLocaleDataSource {
  @override
  Future<void> addNewNote(WineItem note) {
    return DBProvider.instanse.create(note);
  }

  @override
  Future<WineItem> getWineByid(String id) {
    return DBProvider.instanse.searchWineItem(id);
  }

  @override
  Future<void> updateNote(WineItem note) {
    return DBProvider.instanse.update(note);
  }
  
  @override
  Future<String> saveImageFile(String fileImage) {
    // TODO: implement saveImageFile
    throw UnimplementedError();
  }
}
