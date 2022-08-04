import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> newScan(String value)async{

    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    if(typeSelected == newScan.type){
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans()async{
    final dbscans = await DBProvider.db.getAllScans();
    scans = [...dbscans];
    notifyListeners();
  }

  loadScanByType(String type)async{
    final dbscans = await DBProvider.db.getScansByType(type);
    scans = [...dbscans];
    typeSelected = type;
    notifyListeners();
  }

  deleteAll()async{
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteById(int id)async{
    await DBProvider.db.deleteScan(id);
    loadScanByType(typeSelected);
  }

}