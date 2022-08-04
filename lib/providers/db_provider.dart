

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if(_database != null)return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: ( Database db, int version)async{
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )
      ''');
      }
    );
        
  }

  Future<int> newScanRaw(ScanModel newScan) async {

    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    //verify db
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, type, value)
      VALUES($id, '$type', '$value')
    ''');

    return res;
    
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  Future<ScanModel> getScanById(int id)async{
    final db = await database;
    final res = await db.query('Scans', where:'id=?', whereArgs: [id]);
    return res.isNotEmpty 
    ? ScanModel.fromJson(res.first) 
    : null!;
  }

  Future<List<ScanModel>> getAllScans()async{
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty 
    ? res.map((e) => ScanModel.fromJson(e)).toList()
    : [];
  }

  Future<List<ScanModel>> getScansByType(String type)async{
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE type = '$type'
    ''');
    return res.isNotEmpty 
    ? res.map((e) => ScanModel.fromJson(e)).toList()
    : [];
  }

  Future<int> updateScan(ScanModel data)async{
    final db = await database;
    final res = await db.update('Scans', data.toJson(), where:'id=?', whereArgs: [data.id]);
    return res;
  }

  Future<int> deleteScan(int id)async{
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans()async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }


}