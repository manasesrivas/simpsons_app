import 'helper.dart';
import 'package:sqflite/sqflite.dart';

Future<void> agregarFavorito(int id, String nombre) async {
  final db = await DbHelper.db;
  await db.insert(
    'favoritos',
    {'id': id, 'nombre': nombre},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> quitarFavorito(int id) async {
  final db = await DbHelper.db;
  await db.delete('favoritos', where: 'id = ?', whereArgs: [id]);
}

Future<Set<int>> obtenerFavoritos(String nombre) async {
  final db = await DbHelper.db;
    final filas = await db.query(
    'favoritos',
    columns: ['id'],
    where: 'nombre = ?',
    whereArgs: [nombre],
  );
  return filas.map((f) => f['id'] as int).toSet();
}

Future<bool> buscarFavorito(int id) async {
  final db = await DbHelper.db;
  final filas = await db.query(
    'favoritos',
    where: 'id = ?',
    whereArgs: [id],
    limit: 1,
  );
  return filas.isNotEmpty;
}