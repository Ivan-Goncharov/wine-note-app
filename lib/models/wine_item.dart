import 'package:flutter/material.dart';

//Модель для создания одной заметки вина
class WineItem with ChangeNotifier {
  //необходимые поля для заполнения
  String? id;
  String name;
  String manufacturer;
  String country;
  String region;
  DateTime? year;
  DateTime? creationDate;
  String grapeVariety;
  String wineColors;
  String taste;
  String aroma;
  String comment;
  String imageUrl;

  WineItem({
    this.id,
    required this.name,
    required this.manufacturer,
    required this.country,
    required this.region,
    required this.year,
    required this.creationDate,
    required this.aroma,
    required this.grapeVariety,
    required this.taste,
    required this.wineColors,
    required this.comment,
    required this.imageUrl,
  });

  // метод для преобразования значений заметки в карту для записи в базу данных
  Map<String, dynamic> toMap() => {
        WineNoteFields.id: id,
        WineNoteFields.name: name,
        WineNoteFields.manufacturer: manufacturer,
        WineNoteFields.country: country,
        WineNoteFields.region: region,
        WineNoteFields.year: year?.toIso8601String() ?? '',
        WineNoteFields.creationDate: year?.toIso8601String() ?? '',
        WineNoteFields.grapeVariety: grapeVariety,
        WineNoteFields.wineColors: wineColors,
        WineNoteFields.taste: taste,
        WineNoteFields.aroma: aroma,
        WineNoteFields.comment: comment,
        WineNoteFields.imageUrl: imageUrl,
      };

  //метод для преобразования карты из базы данных обратно в заметку
  static WineItem fromMap(Map<String, dynamic> map) {
    return WineItem(
      id: map[WineNoteFields.id].toString(),
      name: map[WineNoteFields.name] as String,
      manufacturer: map[WineNoteFields.manufacturer] as String,
      country: map[WineNoteFields.country] as String,
      region: map[WineNoteFields.region] as String,
      year: DateTime.parse(map[WineNoteFields.year]),
      creationDate: DateTime.parse(map[WineNoteFields.creationDate]),
      grapeVariety: map[WineNoteFields.grapeVariety] as String,
      wineColors: map[WineNoteFields.wineColors] as String,
      taste: map[WineNoteFields.taste] as String,
      aroma: map[WineNoteFields.aroma] as String,
      comment: map[WineNoteFields.comment] as String,
      imageUrl: map[WineNoteFields.imageUrl] as String,
    );
  }

// метод для обновления одного параметра для заметки
  WineItem copyWith({
    String? id,
    String? name,
    String? manufacturer,
    String? country,
    String? region,
    DateTime? year,
    DateTime? creationDate,
    String? aroma,
    String? grapeVariety,
    String? taste,
    String? wineColors,
    String? comment,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return WineItem(
      id: id ?? this.id,
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      country: country ?? this.country,
      region: region ?? this.region,
      year: year ?? this.year,
      creationDate: creationDate ?? this.creationDate,
      aroma: aroma ?? this.aroma,
      grapeVariety: grapeVariety ?? this.grapeVariety,
      taste: taste ?? this.taste,
      wineColors: wineColors ?? this.wineColors,
      imageUrl: imageUrl ?? this.imageUrl,
      comment: comment ?? this.comment,
    );
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

  //если пользователь не выбра фотографию для вина,
  // то подставляем дефолтную, взависимости от цвета вина
  String changeImage() {
    switch (wineColors) {
      case 'Белое':
        return 'assets/images/white_wine.jpg';

      case 'Красное':
        return 'assets/images/red_wine.jpg';

      case 'Оранжевое':
        return 'assets/images/orange_wine.jpg';

      case 'Розовое':
        return 'assets/images/rose_wine.jpg';

      default:
        return '';
    }
  }
}

//класс для создания полей в базе данных
class WineNoteFields {
  static const List<String> values = [
    id,
    name,
    manufacturer,
    country,
    region,
    year,
    creationDate,
    grapeVariety,
    wineColors,
    taste,
    aroma,
    comment,
    imageUrl
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String manufacturer = 'manufactor';
  static const String country = 'country';
  static const String region = 'region';
  static const String year = 'year';
  static const String creationDate = 'creationDate';
  static const String grapeVariety = 'grapeVariety';
  static const String wineColors = 'wineColors';
  static const String taste = 'taste';
  static const String aroma = 'aroma';
  static const String comment = 'commnet';
  static const String imageUrl = 'imageUrl';
}
