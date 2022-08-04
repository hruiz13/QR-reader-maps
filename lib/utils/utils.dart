import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> golaunchUrl(BuildContext context, ScanModel scan) async {
  final url = scan.value;
  if(scan.type == 'http'){
    //open website
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }else{
    Navigator.pushNamed(context, 'map', arguments: scan);
  }

}