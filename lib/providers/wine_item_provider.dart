import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/http_exeption.dart';
import 'package:http/http.dart' as http;

//Модель для создания одной заметки вина
class WineItemProvider with ChangeNotifier {
  String? id;
  String name;
  String manufacturer;
  String country;
  String region;
  String year;
  String grapeVariety;
  String? wineColors;
  String taste;
  String aroma;
  String comment;
  String imageUrl;
  bool isFavorite;

  WineItemProvider({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.country,
    required this.region,
    required this.year,
    required this.aroma,
    required this.grapeVariety,
    required this.taste,
    required this.wineColors,
    this.comment = '',
    this.imageUrl = '',
    this.isFavorite = false,
  });

// метод для обновления одного параметра для заметки
  WineItemProvider copyWith({
    String? id,
    String? name,
    String? manufacturer,
    String? country,
    String? region,
    String? year,
    String? aroma,
    String? grapeVariety,
    String? taste,
    String? wineColors,
    String? comment,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return WineItemProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      country: country ?? this.country,
      region: region ?? this.region,
      year: year ?? this.year,
      aroma: aroma ?? this.aroma,
      grapeVariety: grapeVariety ?? this.grapeVariety,
      taste: taste ?? this.taste,
      wineColors: wineColors ?? this.wineColors,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  //метод для возврата предыдщего статуса заметки
  void _changeStatus(bool status) {
    isFavorite = status;
    notifyListeners();
  }

  //метод для изменения статуса любимого у заметки
  //также изменяет статус заметки на сервере
  Future<void> toogleStatusFavorite() async {
    final oldStatus = isFavorite;

    final urlPatch = Uri.https(
        'flutter-update-ivan-default-rtdb.firebaseio.com', '/notes/$id');

    isFavorite = !isFavorite;
    notifyListeners();
    http.patch(urlPatch,
        body: json.encode({
          'isFavorite': isFavorite,
        }));
    print(isFavorite);
  }

// метод возвращает список значений для выпадающего меню выбора цвета
  static List<DropdownMenuItem<String>> get colorDopdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text('Красное'), value: 'Красное'),
      const DropdownMenuItem(child: Text('Белое'), value: 'Белое'),
      const DropdownMenuItem(child: Text('Оранжевое'), value: 'Оранжевое'),
      const DropdownMenuItem(child: Text('Розовое'), value: 'Розовое'),
    ];
    return menuItems;
  }
}
