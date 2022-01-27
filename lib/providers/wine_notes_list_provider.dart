import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'wine_item_provider.dart';

//провайдер для создания списка вин
class WineNotesListProvider with ChangeNotifier {
  //cписок вин
  List<WineItemProvider> _items = [
    // WineItemProvider(
    //   id: 'p1',
    //   name: 'Rebentos Pequentos',
    //   manufacturer: 'Marcio Lopes',
    //   country: 'Португалия',
    //   region: 'Виньо Верде',
    //   year: '2020',
    //   aroma: 'Яблоко, груша, крыжовник',
    //   grapeVariety: 'Лоурейро',
    //   taste: 'кислотно, свежее, легкое, цитрусовое',
    //   wineColors: 'Оранжевое',
    // ),
    // WineItemProvider(
    //     id: 'p2',
    //     name: 'A Pedreira',
    //     manufacturer: 'Manuel Mondelsh',
    //     country: 'Испания',
    //     region: 'Галисия',
    //     year: '2020',
    //     aroma: 'цитрусовый, мускатный',
    //     grapeVariety: 'Альбариньо',
    //     taste: 'сочное, хорошая кислотность, очень чистое во вкусе',
    //     wineColors: 'Белое',
    //     comment: 'Без сульфитов и серы, натуральнное вино'
    //         'выдержка - 30% в стальных чанах, 70% в дубе'),
  ];

  //получаем ссылку для хранения данных
  final url = Uri.https(
      'flutter-update-ivan-default-rtdb.firebaseio.com', '/notes.json');

// возвращаем лист с заметками о вине
  List<WineItemProvider> get items {
    return _items;
  }

  //возвращаем лист с любимыми винами
  List<WineItemProvider> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  //метод для назначения дефолтного изображения, взависимости от того, выбрано ли фото
  void changeImage(String? id, String? wineColor) {
    int itemIndex = _items.indexWhere((element) => element.id == id);
    switch (wineColor) {
      case 'Red':
        _items[itemIndex].imageUrl = 'assets/images/red_wine.jpg';
        break;
      case 'Orange':
        _items[itemIndex].imageUrl = 'assets/images/orange_wine.jpg';
        break;
      case 'Rose':
        _items[itemIndex].imageUrl = 'assets/images/rose_wine.jpg';
        break;
      default:
        _items[itemIndex].imageUrl = 'assets/images/white_wine.jpg';
    }
  }

  /// метод, который извлекает данные о заметки с сервера
  Future<void> getAndFetchNotes() async {
    // try {
    //загружаем json файл  в виде Map
    try {
      final response = await http.get(url);
      print(response.toString());
      Map<String, dynamic> loadedData = {};
      if (json.decode(response.body) != Null) {
        loadedData = json.decode(response.body) as Map<String, dynamic>;
      }
      final List<WineItemProvider> notesLoadedList = [];
      if (loadedData.isNotEmpty) {
        //декодируем карту и записываем заметки в лист с заметками
        print(loadedData.toString());
        loadedData.forEach((noteId, note) {
          notesLoadedList.add(WineItemProvider(
            id: noteId,
            name: note['name'],
            aroma: note['aroma'],
            country: note['country'],
            grapeVariety: note['grapeVariety'],
            manufacturer: note['manufacturer'],
            region: note['region'],
            taste: note['taste'],
            wineColors: note['wineColors'],
            year: note['year'],
          ));
        });
      }
      _items = notesLoadedList;
      notifyListeners();
    } catch (error) {
      print('You have a error $error');
    }

    // } catch (error) {
    //   print('You have a error $error');
    // }
  }

  // добавляем заметку в основной список вин
  Future<void> addNotes(WineItemProvider wN) async {
    //записываем данные заметки в firebase
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': wN.name,
          'manufacturer': wN.manufacturer,
          'country': wN.country,
          'region': wN.region,
          'year': wN.year,
          'aroma': wN.aroma,
          'grapeVariety': wN.grapeVariety,
          'taste': wN.taste,
          'wineColors': wN.wineColors,
        }),
      );
      wN.id = json.decode(response.body)['name'];
      _items.add(wN);
      notifyListeners();
      print('Notes add in Firebase');
    } catch (erorr) {
      print('Find erorr $erorr');
    }
  }

  // метод для поиска записи в списке по id
  WineItemProvider findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // метод для обновления существующей записи на сервер и в локальную память
  Future<void> updateProduct(String? id, WineItemProvider wN) async {
    final noteIndex = _items.indexWhere((element) => element.id == id);
    if (noteIndex >= 0) {
      //получаем доступ к определнной записи в формате json
      final urlPatch = Uri.https(
          'flutter-update-ivan-default-rtdb.firebaseio.com', '/notes/$id.json');
      http.patch(
        urlPatch,
        body: json.encode({
          'name': wN.name,
          'manufacturer': wN.manufacturer,
          'country': wN.country,
          'region': wN.region,
          'year': wN.year,
          'aroma': wN.aroma,
          'grapeVariety': wN.grapeVariety,
          'taste': wN.taste,
          'wineColors': wN.wineColors,
        }),
      );

      _items[noteIndex] = wN;
      notifyListeners();
    }
  }

  //метод для удаления записи о вине
  void removeNote(String? id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
