import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarSelectionScreen extends StatefulWidget {
  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int _selectedAvatar = -1;

  final List<String> _avatars = [
    'assets/avatars/1.png',
    'assets/avatars/2.png',
    'assets/avatars/3.png',
    'assets/avatars/4.png',
    'assets/avatars/5.png',
    'assets/avatars/6.png',
  ];

  void _saveAvatar(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_avatar', index);
    setState(() {
      _selectedAvatar = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Avatar został wybrany')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wybierz awatara'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _avatars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _saveAvatar(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedAvatar == index ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(_avatars[index]),
            ),
          );
        },
      ),
    );
  }
}
