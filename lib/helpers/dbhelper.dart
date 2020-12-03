import 'dart:io';
import 'package:meditation_app/models/books.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._CreateObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._CreateObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'books.db';
    var booksDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return booksDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    tahun TEXT,
    penerbit TEXT,
    no TEXT
    )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<int> insert(Books object) async {
    Database db = await this.database;
    int count = await db.insert('books', object.toMap());
    return count;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('books', orderBy: 'name');
    return mapList;
  }

  Future<int> update(Books object) async {
    Database db = await this.database;
    int count = await db
        .update('books', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('books', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Books>> getBooksList() async {
    var booksMapList = await select();
    int count = booksMapList.length;

    List<Books> booksList = List<Books>();
    for (int i = 0; i < count; i++) {
      booksList.add(Books.forMap(booksMapList[i]));
    }
    return booksList;
  }
}
