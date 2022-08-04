// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        this.id,
        this.type,
        required this.value,
    }){
      if(value.contains('http')){
        type = 'http';
      }else{
        type = 'geo';
      }
    }

    int? id;
    String? type;
    String value;

    LatLng getLatLng(){

      String dir = value;
      if(dir.contains('?')){
        dir = dir.split('?')[0];
      }
      final latLng = dir.substring(4).split(',');
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);

      return LatLng(lat, lng);

    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };
}
