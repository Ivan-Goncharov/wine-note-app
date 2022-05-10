import 'package:flutter/cupertino.dart';

import '../../models/wine_item.dart';
import '../database/databse.dart';

// класс провайдер для работы с базой данных
class WineListProvider with ChangeNotifier {
  //cписок винных заметок
  List<WineItem> _winesList = [];
  List<WineItem> get wineList => _winesList;

  //список, который будет заполняться при поиске заметок
  final List<WineItem> _searchList = [];

  //метод для очистки листа с найденными заметками
  void clearList() {
    _searchList.clear();
    notifyListeners();
  }

  //метод для очистки листа с найденными заметками
  // без уведомления о том, что необходимо перестариваться
  void clearDisposeList() {
    _searchList.clear();
  }

  List<WineItem> get searchList => _searchList;

  //метод для получения всех заметок о вине
  Future<void> fetchAllNotes() async {
    //вызываем метод, который получает из базы данных все заметки
    await DBProvider.instanse.readAllNotes().then(
      (value) {
        _winesList = value;
        _winesList.sort(
          (a, b) => a.creationDate!.compareTo(b.creationDate!),
        );

        notifyListeners();
      },
    );
  }

  //метод для добавления одной заметки в список
  Future<void> addNote(WineItem note) async {
    await DBProvider.instanse.create(note).then((value) {
      _winesList.add(value);
      notifyListeners();
    });
  }

  //метод для Удаления заметки
  Future<void> deleteNote(String id) async {
    debugPrint('deb: мы тут');
    DBProvider.instanse.delete(id).then((value) {
      _winesList.removeWhere((note) => note.id == id);
      notifyListeners();
    });

    debugPrint('deb: ${_winesList.length}');
  }

  void updateNote(WineItem note) {
    final indexNote = _winesList.indexWhere((element) => element.id == note.id);
    DBProvider.instanse.update(note).then((_) {
      _winesList[indexNote] = note;
      notifyListeners();
    });
  }

  //метод для поиска заметки по id
  WineItem findById(String id) {
    try {
      return _winesList.firstWhere((note) => note.id == id);
    } catch (er) {
      rethrow;
    }
  }

  //метод для поиска заметок
  void searchNotes(String searchText) {
    for (var note in _winesList) {
      final text = searchText.toLowerCase();
      if (note.grapeVariety.toLowerCase().contains(text) ||
          note.name.toLowerCase().contains(text) ||
          note.country.toLowerCase().contains(text) ||
          note.region.toLowerCase().contains(text) ||
          note.manufacturer.toLowerCase().contains(text)) {
        _searchList.add(note);
      }
    }
    notifyListeners();
  }
}
