import 'package:flutter/cupertino.dart';

import '../../models/wine_item.dart';
import '../database/databse.dart';

// класс провайдер для работы с базой данных
class WineDatabaseProvider with ChangeNotifier {
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
        //сортируем заметки
        _winesList.sort(
          (a, b) => b.creationDate!.compareTo(a.creationDate!),
        );
        notifyListeners();
      },
    );
  }

  //метод для добавления одной заметки в список
  Future<void> addNote(WineItem note) async {
    await DBProvider.instanse.create(note).then((value) {
      _winesList.insert(0, value);
      notifyListeners();
    });
  }

  //метод для Удаления заметки
  Future<void> deleteNote(String id) async {
    DBProvider.instanse.delete(id).then((value) {
      _winesList.removeWhere((note) => note.id == id);
      notifyListeners();
    });
  }

  //метод для обновления заметок
  void updateNote(WineItem note) {
    //получаем индекс заметки в списке
    final indexNote = _winesList.indexWhere((element) => element.id == note.id);

    //обновляем заметку в базе данных
    DBProvider.instanse.update(note).then((_) {
      //и в локальном списке
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

      //ищем все совпадения по тексту в полях заметки
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

  //создание листа подсказок по вводу
  //принимаем тип поля, по которому создаем подсказку
  List<String> createHintList(String dataType) {
    final List<String> hintList = [];

    //если список вин еще пуст, создаем его
    if (_winesList.isEmpty) {
      fetchAllNotes();
    }

    //если тип - производитель
    if (dataType == WineNoteFields.manufacturer) {
      //проходим по списку и создаем список всех производителей без повторов
      for (var item in _winesList) {
        if (!hintList.contains(item.manufacturer)) {
          hintList.add(item.manufacturer);
        }
      }
    }

    //если тип - поставщик вина
    else if (dataType == WineNoteFields.vendor) {
      for (var item in _winesList) {
        if (!hintList.contains(item.vendor)) {
          hintList.add(item.vendor);
        }
      }
    }

    return hintList;
  }
}
