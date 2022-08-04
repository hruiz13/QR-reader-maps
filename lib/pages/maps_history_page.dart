import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_list.dart';


class MapsHistoryPAge extends StatelessWidget {
   
  const MapsHistoryPAge({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return const ScanList(type: 'http', icon:Icons.map_outlined);
  }
}