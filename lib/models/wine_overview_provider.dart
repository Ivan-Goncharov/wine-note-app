import 'package:flutter/cupertino.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

import '../database/databse.dart';

//провайдер для работы с производителями вин и сортами
class WineOverviewProvider with ChangeNotifier {
  //список всех сортов или производителей и количество вин
  final List<Map<String, dynamic>> _allData = [];

  //список уже добавленных производителей
  final List<String> _selectItem = [];

  //список сортов и производителей, в которых содержался введенный текст
  //данный список нужен для поиска и для подсказки ввода
  final List<Map<String, dynamic>> _searchList = [];

  static const String notFoundGrape = 'Сорт не найден';

  //список для подсказки ввода названия производителя
  List<String> hintList = [];
  //возвращаем отсортированный список только названий производителей для подсказки ввода
  void hintCreate() {
    hintList.clear();
    //создаем список из названий производителей
    hintList = _createTitleList();
    hintList.sort(((a, b) => a.compareTo(b)));
    notifyListeners();
  }

  //метод для очистки списка производителей
  void clearManufactList() {
    _searchList.clear();
    hintList.clear();
    notifyListeners();
  }

  //getter списка найденных сортов и производителей
  List<Map<String, dynamic>> get manufactSearch {
    return _searchList;
  }

  //метод, который запускается, когда поле поиска  пустое
  //заполняем список всеми данными (сорт или производитель)
  void addAllData() {
    _searchList.clear();
    _searchList.addAll(_allData);
    notifyListeners();
  }

  //метод для создания списка всех производиелей в заметках
  Future<void> createAllDataList(String fieldType) async {
    _allData.clear();
    _selectItem.clear();
    hintList.clear();

    //получаем список всех заметок
    await DBProvider.instanse.readAllNotes().then(
      (wineList) {
        // если переданный тип поля - "сорт винограда "
        // создаем список сортов винограда
        if (fieldType == WineNoteFields.grapeVariety) {
          _createGrapeList(wineList);
        }

        //если тип поля, с которым работаем - производитель
        else if (fieldType == WineNoteFields.manufacturer) {
          //заполняем список производителями вина
          _createManufacturerList(wineList);
        }
      },
    );

    //сортировка по названию
    _allData.sort(
      (a, b) => (a['title'] as String).compareTo(b['title']),
    );

    //сортировка по количеству вин у производителя
    _allData.sort(
      ((a, b) => (b['count'] as int).compareTo(a['count'])),
    );

    //очищаем список для поиска и заполняем всеми производителями
    _searchList.clear();
    _searchList.addAll(_allData);
    notifyListeners();
  }

  //метод, который создает список производителей
  void _createManufacturerList(List<WineItem> wineList) {
    //проходимся по списку заметок
    for (var note in wineList) {
      //если уже добавляли такого производителя - увеличиваем количество вин у него
      if (_selectItem.contains(note.manufacturer.toLowerCase())) {
        _increaseCount(note.manufacturer);
      }

      //иначе создаем запись с такими данными
      else {
        _addOneData(note.manufacturer);
      }
    }
  }

  //метод, который создает список сортов винограда
  void _createGrapeList(List<WineItem> wineList) {
    //проходимся по списку заметок;
    for (var note in wineList) {
      final List<String> list = [];
      if (note.grapeVariety.contains(',')) {
        list.addAll(note.grapeVariety.split(','));
      } else {
        list.add(note.grapeVariety);
      }

      for (var name in list) {
        final grapeName = name.trim();
        //если у заметки не указан сорт винограда, то следующая логика
        if (grapeName.isEmpty) {
          //если уже была запись у которой не указан сорт винограда
          //то увеличиваем количество заметок
          if (_selectItem.contains(notFoundGrape.toLowerCase())) {
            _increaseCount(notFoundGrape);
          }

          //если записи не было, то создаем запись на карте с константой "Сорт не указан"
          else {
            _addOneData(notFoundGrape);
          }
        }

        //если у заметки указан сорт винограда
        else {
          //если уже добавляли такой сорт - увеличиваем количество вин у него
          if (_selectItem.contains(grapeName.toLowerCase())) {
            _increaseCount(grapeName);
          }

          //если нет такого сорта, то добавляем его в список
          else {
            _addOneData(grapeName);
          }
        }
      }
    }
  }

  //метод для создания списка сортов и производителей,
  //названия которых содержат введенный текст
  //принимает введенный текст и тип ввода
  void searchData(String name, bool isHintText) {
    _searchList.clear();

    //проходим по списку всех данных -
    //если какой-то из них содержит введенный текст,
    //то добавляем в поисковый список

    for (var item in _allData) {
      if ((item['title'] as String)
          .toLowerCase()
          .contains(name.toLowerCase())) {
        _searchList.add(item);
      }
    }

    //если тип поиска - создание подсказки ввода, то создаем список только названий
    if (isHintText) {
      hintCreate();
    }
    notifyListeners();
  }

  //метод для создания списка названий
  List<String> _createTitleList() {
    final list = <String>[];
    for (var manuf in _searchList) {
      list.add(manuf['title']);
    }
    return list;
  }

  //метод для увеличения количества вин у одного сорта винограда
  void _increaseCount(String title) {
    final index = _allData.indexWhere((element) => element['title'] == title);
    _allData[index]['count'] += 1;
  }

  //метод для добавления сорта винограда в список данных
  void _addOneData(String title) {
    _selectItem.add(title.toLowerCase());
    _allData.add(
      {
        'title': title,
        'count': 1,
      },
    );
  }
}
