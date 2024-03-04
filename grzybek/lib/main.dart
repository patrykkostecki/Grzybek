import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SideBar(),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Tło całego ekranu
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Przypięcie do lewej strony
            children: <Widget>[
              SizedBox(
                height: 130,
              ),
              SidebarButton(label: 'Rozpoznawanie', width: 300),
              SidebarButton(label: 'Encyklopedia', width: 250),
              SidebarButton(label: 'Kolekcja', width: 200),
              SidebarButton(label: 'Forum', width: 150),
              SidebarButton(label: 'Mapy', width: 100),
            ],
          ),
          Expanded(
            child: Container(
              // Pozostała część ekranu
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String label;
  final double width;

  const SidebarButton({Key? key, required this.label, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50, // Ustaw wysokość przycisków
      padding:
          EdgeInsets.only(bottom: 8.0), // Dodaj odstęp od dolnego przycisku
      child: TextButton(
        onPressed: () {
          print('Naciśnięto: $label');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.amber, // Kolor tekstu przycisku
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
              horizontal:
                  16.0), // Wewnętrzny odstęp tekstu od krawędzi przycisku
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Usunięcie zaokrągleń
          ),
        ),
        child: Text(label, textAlign: TextAlign.left),
      ),
    );
  }
}
