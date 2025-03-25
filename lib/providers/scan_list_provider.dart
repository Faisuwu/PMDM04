//scan_list_provider.dart - Antoni Maqueda DI04

import 'package:flutter/cupertino.dart';
import 'package:qrscanner/models/scan_model.dart';
import '../models/scan_model.dart';
import 'db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat){
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  //CarregaScansPerTipus Implementat!
  void carregaScansPerTipus(String tipus) async {
    print("Carregant scans de la base de dades...");

    // Carregar les dades abans de filtrar
    final scansDB = await DBProvider.db.getScanByType(tipus);
    this.scans = [...scansDB];

    print("Llista filtrada: $scans");

    if (scans.isEmpty) {
      print("No hi ha scans disponibles per '$tipus'");
    }

    notifyListeners();
  }


  //IMPLEMENTAT esborrartots
  esborrarTots() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  //IMPLEMENTAT esborrarPerId
  esborrarPerId(int id) async {
    await DBProvider.db.deleteScan(id);
    scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }
}