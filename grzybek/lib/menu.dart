import 'package:flutter/material.dart';
import 'package:grzybek/main.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
          appBar: CustomAppBar(),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                  Image.asset(
                    'assets/Login.png',
                    width: 200,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 0.1),
                    child: Text(
                      "Pomyślnie zalogowano",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ]))),
          )),
    ));
  }
}
