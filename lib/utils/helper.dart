import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    final ruta = join(await getDatabasesPath(), 'simpsons.db');
    _db = await openDatabase(
      ruta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE favoritos (id INTEGER PRIMARY KEY, nombre TEXT)',
        );
      },
    );
    return _db!;
  }
}