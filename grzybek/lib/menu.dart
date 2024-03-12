import 'package:flutter/material.dart';
import 'package:grzybek/bottom_navigatiton_bar.dart';
import 'package:grzybek/main.dart'; // Upewnij się, że tutaj są właściwe ścieżki
import 'mapa.dart'; // Importuj MapaScreen z właściwego pliku

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(), // CustomAppBar powinien być zdefiniowany w innym miejscu
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_menu.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('KLASYFIKACJA GRZYBA'),
                // Reszta treści
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: 2, // Tutaj ustawiasz indeks dla strony MenuScreen
      ),
    );
  }
}
