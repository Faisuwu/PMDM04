//db_provider.dart - Antoni Maqueda DI04

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future <Database> get database async{

    if (_database == null) _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    //Obtenir es path
    //Directory documentsDirectory = await getApplicationCacheDirectory();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path,'Scans.db');
    print(path);

    //Creacio de la BBDD
    return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db, int version) async{
          await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipus TEXT,
              valor TEXT
            )
          ''');
        }
    );
  }

  Future<int> insertRawScan(ScanModel nouScan) async{
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;
    final db = await database;
    /*final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
        VALUES ($id, $tipus, $valor)
    ''');*/
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
      VALUES (?, ?, ?)
      ''', [id, tipus, valor]);

    return res;
  }

  Future<int> insertScan(ScanModel nouScan) async{
    final db = await database;
    final res = await db.insert('Scans', nouScan.toMap());

    print(res);
    return res;
  }

  Future<List<ScanModel>> getAllScans() async{
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async{
    final db = await database;
    final res = await db.query('Scans',where: 'id = ?',whereArgs: [id]);

    if(res.isNotEmpty){
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  //Aqui he implementat GetScanByType, es a dir (String tipus) => Llista de ScanModel
  Future<List<ScanModel>> getScanByType(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nouScan) async{
    final db = await database;
    final res = db.update('Scans', nouScan.toMap(),where: 'id = ?',whereArgs: [nouScan.id]);
    return res;
  }

  Future<int> deleteAllScans() async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }

  //Aqui he implementat deletescan en funció de l'id (int)
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }
}