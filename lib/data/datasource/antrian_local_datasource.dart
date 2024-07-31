import 'package:flutter_antrian_app/data/models/antrian.dart';
import 'package:sqflite/sqflite.dart';

class AntrianLocalDatasource {
  AntrianLocalDatasource._init();

  static final AntrianLocalDatasource instance = AntrianLocalDatasource._init();

  final String tableAntrian = 'tbl_antrian';

  static Database? _database;

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableAntrian (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        noAntrian TEXT,
        isActive INTEGER
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Insert db
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('antrian.db');
    return _database!;
  }

  // Save antrian
  Future<void> saveAntrian(Antrian antrian) async {
    final db = await instance.database;
    await db.insert(tableAntrian, antrian.toMap());
  }

  // Get all antrian
  Future<List<Antrian>> getAllAntrian() async {
    final db = await instance.database;
    final result = await db.query(tableAntrian);

    return result.map((e) => Antrian.fromMap(e)).toList();
  }

  // Update antrian
  Future<void> updateAntrian(Antrian antrian) async {
    final db = await instance.database;
    await db.update(
      tableAntrian,
      antrian.toMap(),
      where: 'id = ?',
      whereArgs: [antrian.id],
    );
  }

  // Delete antrian
  Future<void> daleteAntrian(int id) async {
    final db = await instance.database;
    await db.delete(
      tableAntrian,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
