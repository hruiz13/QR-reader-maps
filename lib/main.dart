import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_)=> UiProvider() ),
        ChangeNotifierProvider(create: (_)=> ScanListProvider() ),
      ],

      child: MaterialApp(
        title: 'WA reader App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          
          appBar: AppBar(
            title: const Text('QR Reader'),
          ),
        ),
        initialRoute: 'home',
        routes: {
          'home': (_)=> const HomePage(),
          'map': (_)=>const MapPage()
        },
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blueGrey
          )
        ),
      ),
    );
  }
}