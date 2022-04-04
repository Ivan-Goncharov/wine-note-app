import 'package:flutter/cupertino.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

import '../database/databse.dart';

// класс провайдер для работы с базой данных
class WineListProvider with ChangeNotifier {
  //cписок винных заметок
  List<WineItem> _winesList = [];
  List<WineItem> get wineList => _winesList;

  //метод для получения всех заметок о вине
  Future<void> fetchAllNotes() async {
    //вызываем метод, который получает из базы данных все заметки
    await DBProvider.instanse.readAllNotes().then((value) {
      _winesList = value;
      notifyListeners();
    });
  }

  //метод для добавления одной заметки в список
  Future<void> addNote(WineItem note) async {
    await DBProvider.instanse.create(note).then((value) {
      _winesList.add(value);
      notifyListeners();
    });
  }

  //метод для добавления заметки
  void deleteNote(String id) {
    DBProvider.instanse.delete(id).then((value) {
      _winesList.removeWhere((note) => note.id == id);
      notifyListeners();
    });
  }

  void updateNote(WineItem note) {
    final indexNote = _winesList.indexWhere((element) => element.id == note.id);
    DBProvider.instanse.update(note).then((value) {
      _winesList[indexNote] = note;
      notifyListeners();
    });
  }

  //метод для поиска заметки по id
  WineItem findById(String id) {
    return _winesList.firstWhere((note) => note.id == id);
  }
}
