import 'package:flutter/material.dart';

import '../database/databse.dart';
import '../models/wine_item.dart';

//провадйер для получения заметки конкретного типа из базы данных
class WineSortProvider with ChangeNotifier {
  //список заметок для дополнительного фильтра(например, по регионам)
  List<WineItem> _filterList = [];
  List<WineItem> get filterList => _filterList;

  //список всех заметок конкретного типа
  List<WineItem> _allNotes = [];

  //список регионов, которые используются в заметках
  final List<String> _regions = [];
  List<String> get regions => _regions;

  //метод для чтения заметок конкретного типа, принимает тип поля фильтрации
  //и данные для фильтрации
  Future<void> fetchCustomNotes(String filterName, String data) async {
    _filterList = [];
    try {
      await DBProvider.instanse.customReadNotes(filterName, data).then((value) {
        _allNotes = value;
        _filterList = _allNotes;
        notifyListeners();
        createRegionList();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //метод для создания списка регионов конкретной страны
  void createRegionList() {
    for (var note in _filterList) {
      //проходимся по листу заметок и добавляем регионы, которые представлены в заметках данной страны
      //избегаем повторов
      if (!_regions.contains(note.region)) {
        _regions.add(note.region);
      }
    }
  }

  //метод для фильтрации по регионам
  void selectRegion(String regionName) {
    _filterList = [];
    for (var note in _allNotes) {
      if (note.region == regionName) {
        _filterList.add(note);
      }
    }
    notifyListeners();
  }

  //метод для очистки фильтра по регионам
  //список вновь равен всем заметкам
  void clearFilter() {
    _filterList = _allNotes;
    _filterList.length;
    notifyListeners();
  }
}
