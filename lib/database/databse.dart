import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../providers/wine_item_provider.dart';

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
    _database = await _initDB('wine.db');
    return _database!;
  }

  //метод для инициализации базы данных
  Future<Database> _initDB(String filePath) async {
    //получаем путь через пакет path_provider
    Directory dir = await getApplicationDocumentsDirectory();

    //путь для нашей базы данных
    final path = dir.path + filePath;

    //открываем базу
    return await openDatabase(path, version: 2, onCreate: _createDB);
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
  Future<WineItemProvider> create(WineItemProvider note) async {
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
  Future<WineItemProvider> read(int id) async {
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
      return WineItemProvider.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //метод для чтения всех заметок о вине
  Future<List<WineItemProvider>> readAllNotes() async {
    final db = await instanse.getDataBase();

    //создаем map записей в базе
    final maps = await db.query(_tableName);

    //возвращаем список заметок
    return maps.map((json) => WineItemProvider.fromMap(json)).toList();
  }

  //метод для обновления заметки в базе данных
  //принимает заметку
  Future<int> update(WineItemProvider note) async {
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
  Future<int> delete(int id) async {
    final db = await instanse.getDataBase();

    return await db.delete(
      _tableName,
      where: '${WineNoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  //метод для закрытия базы данных
  Future _close() async {
    final db = await instanse.getDataBase();

    db.close();
  }
}