import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/addresses_history_page.dart';
import 'package:qr_reader/pages/maps_history_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: (){
              final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.deleteAll();
            }, 
          )
        ]
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const _HomePageBody()
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //get option from provider
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //get the scanlistprovider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen:false);

    switch (currentIndex) {
      case 0:
      scanListProvider.loadScanByType('geo');
      return const MapsHistoryPAge();
      case 1:
      scanListProvider.loadScanByType('http');
      return const AddressesHistoryPage();
      default:
      return const MapsHistoryPAge();
    }
    
  }
}