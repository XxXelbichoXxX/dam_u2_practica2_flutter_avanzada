import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE contactos(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nombre TEXT,
      numero TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'agenda.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createContact(String nombre, String numero) async {
    final db = await SQLHelper.db();
    final contacto = {'nombre': nombre, 'numero': numero};
    final id = await db.insert('contactos', contacto,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getContacts() async {
    final db = await SQLHelper.db();
    return db.query('contactos', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getContact(int id) async {
    final db = await SQLHelper.db();
    return db.query('contactos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String nombre, String numero) async {
    final db = await SQLHelper.db();

    final data = {
      'nombre': nombre,
      'numero': numero
    };

    final result = await db.update('contactos', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteContact(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete('contactos', where: "id = ?", whereArgs: [id]);
    }catch (err) {
      debugPrint("Algo salio mal borrando el contacto:$err");
    }
  }

}

