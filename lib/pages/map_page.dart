import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
   
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 16,
      //tilt: 50
    );

    //Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getLatLng()
      )
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            onPressed: ()async{

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: 16
                  )
              ));

            }, 
            icon: const Icon(Icons.location_searching)
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: (){
          if(mapType == MapType.normal){
            mapType = MapType.satellite;
          }else{
            mapType = MapType.normal;
          }
          setState(() { });
        },
      ),

      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        myLocationButtonEnabled: false,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}