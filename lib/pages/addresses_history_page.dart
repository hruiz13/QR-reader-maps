import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_list.dart';

class AddressesHistoryPage extends StatelessWidget {
   
  const AddressesHistoryPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return const ScanList(type: 'geo',icon:Icons.home_outlined);
  }
}