//home_screen.dart - Antoni Maqueda DI04

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_list_provider.dart';
import '../providers/ui_provider.dart';
import '../widgets/custom_navigatorbar.dart';
import '../widgets/scan_bottom.dart';
import 'direccions_screen.dart';
import 'mapas_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context,listen: false).esborrarTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("_HomeScreenBody.build() esta executant...");
    final uiProvider = Provider.of<UIProvider>(context);
    print(" UIProvider obtingut. selectedMenuOpt: ${uiProvider.selectedMenuOpt}");
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    //Ho vaig implementar per gestió d'errors
    if (scanListProvider == null) {
      print(" scanListProvider es NULL!");
    } else {
      print(" scanListProvider está inicialitzat.");
    }

    switch (currentIndex) {
      case 0:
        print("Carregant scans de tipus geo");
        scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();

      case 1:
        print("Carregant scans de tipus http");
        scanListProvider.carregaScansPerTipus('http');
        return DireccionsScreen();

      default:
        print("Carregant scans default de tipus geo");
        scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();
    }
  }
}