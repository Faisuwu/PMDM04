//main.dart - Antoni Maqueda DI04

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';
import 'package:qrscanner/providers/ui_provider.dart';
import 'package:qrscanner/screens/home_screen.dart';
import 'package:qrscanner/screens/mapa_screen.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: ( _ ) => UIProvider()),
    ChangeNotifierProvider(create: ( _ ) => ScanListProvider()),
    ],
    child: MyApp(),));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mapa': (_) => MapaScreen(),
      },
      theme: ThemeData(
        // No es pot emprar colorPrimary des de l'actualització de Flutter
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}