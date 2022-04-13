import 'package:flutter/cupertino.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

import '../database/databse.dart';

//провайдер для работы с производителями вин и сортами
class WineOverviewProvider with ChangeNotifier {
  //список всех сортов или производителей и количество вин
  final List<Map<String, dynamic>> _allData = [];

  //список сортов и производителей, в которых содержался введенный текст
  //данный список нужен для поиска и для подсказки ввода
  final List<Map<String, dynamic>> _searchList = [];

  //список для подсказки ввода названия производителя
  List<String> hintList = [];
  //возвращаем отсортированный список только названий производителей для подсказки ввода
  void hintCreate() {
    hintList.clear();
    //создаем список из названий производителей
    hintList = _createTitleList(_searchList);
    hintList.sort(((a, b) => a.compareTo(b)));
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
    //получаем список всех заметок
    await DBProvider.instanse.readAllNotes().then(
      (wineList) {
        //список уже добавленных производителей
        final List<String> selectItem = [];

        //если тип поля, с которым работаем - производитель
        if (fieldType == WineNoteFields.manufacturer) {
          //заполняем список производителями вина
          _createManufacturerList(wineList, selectItem);
        }
        // если переданный тип поля - "сорт винограда "
        // создаем список сортов винограда
        else if (fieldType == WineNoteFields.grapeVariety) {
          _createGrapeList(wineList, selectItem);
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
  void _createManufacturerList(
      List<WineItem> wineList, List<String> selectItem) {
    //проходимся по списку заметок
    for (var note in wineList) {
      //если уже добавляли такого производителя - увеличиваем количество вин у него
      if (selectItem.contains(note.manufacturer.toLowerCase())) {
        //получаем индекс производителя в списке
        final index = _allData
            .indexWhere((element) => element['title'] == note.manufacturer);

        //увеличиваем у него количество вин
        _allData[index]['count'] += 1;
      } else {
        //если нет такого производителя, то добавляем его в список
        selectItem.add(note.manufacturer.toLowerCase());
        //и создаем карту с производителем, указываем, что на данный момент у него 1 вино в заметках
        _allData.add(
          {
            'title': note.manufacturer,
            'count': 1,
          },
        );
      }
    }
  }

  //метод, который создает список производителей
  void _createGrapeList(List<WineItem> wineList, List<String> selectItem) {
    //проходимся по списку заметок
    for (var note in wineList) {
      //если уже добавляли такой сорт - увеличиваем количество вин у него
      if (selectItem.contains(note.grapeVariety)) {
        //получаем индекс сорта винограда в списке
        final index = _allData
            .indexWhere((element) => element['title'] == note.manufacturer);

        //увеличиваем у него количество вин
        _allData[index]['count'] += 1;
      } else {
        //если нет такого сорта, то добавляем его в список
        selectItem.add(note.grapeVariety);
        //и создаем карту с сортом, указываем, что на данный момент у него 1 вино в заметках
        _allData.add(
          {
            'title': note.grapeVariety,
            'count': 1,
          },
        );
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
  List<String> _createTitleList(List<Map<String, dynamic>> listOfMap) {
    final list = <String>[];
    for (var manuf in listOfMap) {
      list.add(manuf['title']);
    }
    return list;
  }
}
