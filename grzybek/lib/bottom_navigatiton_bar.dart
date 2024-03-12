import 'package:flutter/material.dart';
import 'mapa.dart'; // Załóżmy, że plik nazywa się mapa_screen.dart i zawiera klasę MapaScreen
import 'menu.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;

  CustomBottomAppBar({this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(const Radius.circular(50.0)),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 60.0,
          decoration: const BoxDecoration(
            color: Color(0xFF795548),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildBottomAppBarItem(
                context,
                iconData: Icons.menu_book_outlined,
                index: 0,
              ),
              _buildBottomAppBarItem(
                context,
                iconData: Icons.forum_outlined,
                index: 1,
              ),
              _buildBottomAppBarItem(
                context,
                iconData: Icons.local_florist_outlined,
                index: 2,
              ),
              _buildBottomAppBarItem(
                context,
                iconData: Icons.notifications,
                index: 3,
              ),
              _buildBottomAppBarItem(
                context,
                iconData: Icons.forest_outlined,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAppBarItem(BuildContext context,
      {required IconData iconData, required int index}) {
    return IconButton(
      icon: Icon(iconData),
      color: selectedIndex == index ? Colors.white : Colors.white60,
      onPressed: () {
        switch (index) {
          case 0:
            // Navigator.pushNamed(context, '/home');
            break;
          case 1:
            // Navigator.pushNamed(context, '/forum');
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
            break;
          case 3:
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MenuScreen()),
            // );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapaScreen()),
            );
            break;
        }
      },
    );
  }
}
