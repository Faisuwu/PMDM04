//scan_bottom.dart - Antoni Maqueda DI04

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/scan_model.dart';
import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');
        //String barcodeScanRes = 'http://paucasesnovescifp.cat';
        String barcodeScanRes = 'geo:39.7260888,2.9113035';

        /*String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D88EF',
            'Cancelar',
            false,
            ScanMode.QR);
        print(barcodeScanRes);*/

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context, nouScan);
      },
    );
  }
}




















