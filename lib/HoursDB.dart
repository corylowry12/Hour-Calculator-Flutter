import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'HoursModel.dart';

class HoursDatabase {
  static final HoursDatabase instance = HoursDatabase._init();

  static Database? _database;

  HoursDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('hours.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableHours ( 
  ${HoursFields.id} $idType, 
  ${HoursFields.inTime} $textType,
  ${HoursFields.outTime} $textType,
  ${HoursFields.breakTime} $textType,
  ${HoursFields.totalHours} $textType,
  ${HoursFields.date} $textType
  )
''');
  }

  Future<Hour> create(Hour note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableHours, note.toJson());
    return note.copy(id: id);
  }

  Future<Hour> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHours,
      columns: HoursFields.values,
      where: '${HoursFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Hour.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Hour>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${HoursFields.date} DESC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableHours, orderBy: orderBy);

    return result.map((json) => Hour.fromJson(json)).toList();
  }

  Future<int> update(Hour note) async {
    final db = await instance.database;

    return db.update(
      tableHours,
      note.toJson(),
      where: '${HoursFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableHours,
      where: '${HoursFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    //db.close();
  }
}