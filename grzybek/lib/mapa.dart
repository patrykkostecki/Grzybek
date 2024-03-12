import 'package:flutter/material.dart';
import 'package:grzybek/bottom_navigatiton_bar.dart';
import 'package:grzybek/main.dart'; // Upewnij się, że tutaj są właściwe ścieżki
import 'mapa.dart'; // Importuj MapaScreen z właściwego pliku

class MapaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_menu.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('MAPSKO.'),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 4, // Zakładając, że MapaScreen ma index 4
        // onItemSelected: (index) {
        //   // Dodaj logikę dla przełączania między ekranami
        // },
      ),
    );
  }
}
