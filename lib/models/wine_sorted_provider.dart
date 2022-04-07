import 'package:flutter/cupertino.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

//провадйер для получения заметки конкретного типа из базы данных
class WineSortProvider with ChangeNotifier {
  //список заметок
  List<WineItem> _notesList = [];
  List<WineItem> get notesList => _notesList;

  //

  //метод для чтения заметок конкретного типа, принимает тип поля фильтрации
  //и данные для фильтрации
  Future<void> fetchCustomNotes(String filterName, String data) async {
    try {
      await DBProvider.instanse.customReadNotes(filterName, data).then((value) {
        _notesList = value;
        notifyListeners();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
