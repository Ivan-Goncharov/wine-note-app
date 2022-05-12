import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/overview_widget/notes_sorting.dart';

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
  void clearRegions() => _regions.clear();

  //метод для чтения заметок конкретного типа, принимает тип поля фильтрации
  //и данные для фильтрации
  Future<void> fetchCustomNotes(String filterName, String data) async {
    _filterList.clear();
    try {
      await DBProvider.instanse.customReadNotes(filterName, data).then((value) {
        _allNotes = value;
        _filterList.addAll(_allNotes);
        createRegionList();
      });
      // notifyListeners();/
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
      if (!_regions.contains(note.region) && note.region.isNotEmpty) {
        _regions.add(note.region);
      }
    }
  }

  //метод для дополнительной фильтрации
  //принимает поле для фильтрации и данные, которые должны содержаться в этом поле
  void selectFilter({required String filterName, required String data}) {
    _filterList = [];
    //если тип фильтрации по регионам
    if (filterName == WineNoteFields.region) {
      for (var note in _allNotes) {
        if (note.region == data) {
          _filterList.add(note);
        }
      }
    }

    //если тип фильтрации по цвету
    else if (filterName == WineNoteFields.wineColors) {
      for (var note in _allNotes) {
        if (note.wineColors == data) {
          _filterList.add(note);
        }
      }
    }

    notifyListeners();
  }

  //метод для очистки фильтра
  //список вновь равен всем заметкам
  void clearFilter() {
    _filterList.clear();
    _filterList.addAll(_allNotes);

    notifyListeners();
  }

  //метод для сорптировки списка заметок
  //принимает тип сортировки
  //сортирует список определнным образом, в зависимости от типа
  void sortNotes(TypeOfSotring type) {
    switch (type) {
      case TypeOfSotring.alphabet:
        _filterList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case TypeOfSotring.creationDate:
        _filterList.sort((a, b) => a.creationDate!.compareTo(b.creationDate!));
        break;
      case TypeOfSotring.grapeYear:
        _filterList.sort((a, b) => a.year!.compareTo(b.year!));
        break;
      default:
        _filterList.shuffle();
    }
    notifyListeners();
  }

  void checkDelete() {
    notifyListeners();
  }
}
