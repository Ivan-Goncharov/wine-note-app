import 'package:flutter/cupertino.dart';

import '../database/databse.dart';

//провайдер для работы с производителями вин
class WineManufcatProvider with ChangeNotifier {
  //список всех производителей и количество вин этих производителей
  final List<Map<String, dynamic>> _allManufactores = [];

  //список производителей, в которых содержался введенный текст
  //данный список нужен для поиска и для подсказки ввода
  final List<Map<String, dynamic>> _manufactSearch = [];

  //список для подсказки ввода названия производителя
  List<String> hintList = [];
  //возвращаем отсортированный список только названий производителей для подсказки ввода
  void hintCreate() {
    hintList.clear();
    //создаем список из названий производителей
    hintList = _createManufTitleList(_manufactSearch);
    hintList.sort(((a, b) => a.compareTo(b)));
  }

  //метод для очистки списка производителей
  void clearManufactList() {
    _manufactSearch.clear();
    hintList.clear();
    notifyListeners();
  }

  //возвращает отсортированный список найденных производителей
  List<Map<String, dynamic>> get manufactSearch {
    return _manufactSearch;
  }

  //метод, который запускается, когда поле поиска производителя пустое
  //заполняем список всеми производителями
  void addAllManufactures() {
    _manufactSearch.clear();
    _manufactSearch.addAll(_allManufactores);
    notifyListeners();
  }

  //метод для создания списка всех производиелей в заметках
  Future<void> createManufactList() async {
    _allManufactores.clear();
    //получаем список всех заметок
    await DBProvider.instanse.readAllNotes().then(
      (wineList) {
        //список уже добавленных производителей
        final List<String> selectItem = [];
        //проходимся по списку заметок
        for (var note in wineList) {
          //если уже добавляли такого производителя - увеличиваем количество вин у него
          if (selectItem.contains(note.manufacturer.toLowerCase())) {
            //получаем индекс производителя в списке
            final index = _allManufactores.indexWhere(
                (element) => element['manufacturer'] == note.manufacturer);

            //увеличиваем у него количество вин
            _allManufactores[index]['count'] += 1;
          } else {
            //если нет такого производителя, то добавляем его в список
            selectItem.add(note.manufacturer.toLowerCase());
            //и создаем карту с производителем, указываем, что на данный момент у него 1 вино в заметках
            _allManufactores.add(
              {
                'manufacturer': note.manufacturer,
                'count': 1,
              },
            );
          }
        }
      },
    );

    //сортировка по названию
    _allManufactores.sort(
      (a, b) => (a['manufacturer'] as String).compareTo(b['manufacturer']),
    );

    //сортировка по количеству вин у производителя
    _allManufactores.sort(
      ((a, b) => (b['count'] as int).compareTo(a['count'])),
    );

    //очищаем список для поиска и заполняем всеми производителями
    _manufactSearch.clear();
    _manufactSearch.addAll(_allManufactores);
    notifyListeners();
  }

  //метод для создания списка производителей,
  //названия которых содержат введенный текст
  //принимает введенный текст и тип ввода
  void searchManufact(String name, bool isHintText) {
    _manufactSearch.clear();

    //проходим по списку всех производителей -
    //если какой-то из них содержит введенный текст,
    //то добавляем в список найденных производителей

    for (var item in _allManufactores) {
      if ((item['manufacturer'] as String)
          .toLowerCase()
          .contains(name.toLowerCase())) {
        _manufactSearch.add(item);
      }
    }

    //если тип поиска - создание подсказки ввода, то создаем список только названий
    if (isHintText) {
      hintCreate();
    }
    notifyListeners();
  }

  //метод для создания списка названий производителей
  List<String> _createManufTitleList(List<Map<String, dynamic>> listOfMap) {
    final list = <String>[];
    for (var manuf in listOfMap) {
      list.add(manuf['manufacturer']);
    }
    return list;
  }
}
