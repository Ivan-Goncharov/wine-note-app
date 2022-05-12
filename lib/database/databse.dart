import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/wine_item.dart';

//База данных Sqllite - для сохранения заметок пользователей о вине
class DBProvider {
  //имя таблицы
  final String _tableName = 'wineNotes';

  //синглтон для создания единственного экземпляра базы данных
  DBProvider._init();
  static final DBProvider instanse = DBProvider._init();

  static Database? _database;

  // получаем базу данных
  Future<Database> getDataBase() async {
    //если уже инициализирована
    if (_database != null) return _database!;

    //если нет, то создаем ее
    _database = await _initDB('wines_notes.db');
    return _database!;
  }

  //метод для инициализации базы данных
  Future<Database> _initDB(String filePath) async {
    //получаем путь через пакет path_provider
    Directory dir = await getApplicationDocumentsDirectory();

    //путь для нашей базы данных
    final path = dir.path + filePath;

    //открываем базу
    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  //метод для созданя базы данных
  Future _createDB(Database db, int version) async {
    const idTypes = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    //создаем базу со всеми полями нашей заметки
    await db.execute('''
CREATE TABLE $_tableName (
  ${WineNoteFields.id} $idTypes,
  ${WineNoteFields.name} $textType,
  ${WineNoteFields.manufacturer} $textType,
  ${WineNoteFields.country} $textType,
  ${WineNoteFields.region} $textType,
  ${WineNoteFields.year} $textType,
  ${WineNoteFields.creationDate} $textType,
  ${WineNoteFields.grapeVariety} $textType,
  ${WineNoteFields.wineColors} $textType,
  ${WineNoteFields.taste} $textType,
  ${WineNoteFields.aroma} $textType,
  ${WineNoteFields.comment} $textType,
  ${WineNoteFields.imageUrl} $textType
)
''');
  }

  //метод для записи одной заметки в базу
  Future<WineItem> create(WineItem note) async {
    final db = await instanse.getDataBase();

    //вставляем заметку в формате map
    final id = await db.insert(
      _tableName,
      note.toMap(),
    );

    //возвращает заметку с id, который присвоила база данных заметке
    return note.copyWith(id: id.toString());
  }

  //метод для чтения одной заметки о вине
  //принимает id данной заметки
  Future<WineItem> read(String id) async {
    final db = await instanse.getDataBase();

    //читаем заметку, если id совпадает
    final maps = await db.query(
      _tableName,
      columns: WineNoteFields.values,
      where: '${WineNoteFields.id} = ?',
      whereArgs: [id],
    );

    //если такая запись есть, то возвращаем заметку
    if (maps.isNotEmpty) {
      return WineItem.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //метод для чтения всех заметок о вине
  Future<List<WineItem>> readAllNotes() async {
    final db = await instanse.getDataBase();

    //создаем map записей в базе
    final maps = await db.query(_tableName);

    //возвращаем список заметок
    return maps.map((json) => WineItem.fromMap(json)).toList();
  }

  //метод для получения заметки конкретного типа
  //принимает имя поля, по которому будем искать
  //и значение, по которому будем искать
  Future<List<WineItem>> customReadNotes(String filterName, String data) async {
    final db = await instanse.getDataBase();

    //составляем список заметок с нужными параметрами
    final maps = await db.query(
      _tableName,
      columns: WineNoteFields.values,
      where: data.isEmpty ? '$filterName = ?' : '$filterName LIKE ?',
      whereArgs: data.isEmpty ? [data] : ['%$data%'],
    );

    //возвращаем список заметок
    return maps.map((json) => WineItem.fromMap(json)).toList();
  }

  //метод для обновления заметки в базе данных
  //принимает заметку
  Future<int> update(WineItem note) async {
    final db = await instanse.getDataBase();

    //вызываем метод обновления, передавая id записи и заметку
    return db.update(
      _tableName,
      note.toMap(),
      where: '${WineNoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  //метод для удаления записи в базе данных
  //принимает id записи
  Future<int> delete(String id) async {
    final db = await instanse.getDataBase();

    return await db.delete(
      _tableName,
      where: '${WineNoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  //метод для закрытия базы данных
  // Future _close() async {
  //   final db = await instanse.getDataBase();

  //   db.close();
  // }
}
