//mapa_screen.dart - Antoni Maqueda DI04

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)?.settings.arguments as ScanModel?;
    if (scan == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("No hay datos disponibles")),
      );
    }
    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('id1'),
        position: scan.getLatLng(),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(_puntInicial));
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: _currentMapType,
        initialCameraPosition: _puntInicial,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            child: Icon(Icons.map),
            onPressed: () {
              setState(() {
                _currentMapType = _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
              });
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn2",
            child: Icon(Icons.center_focus_strong),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(_puntInicial));
            },
          ),
        ],
      ),
    );
  }
}