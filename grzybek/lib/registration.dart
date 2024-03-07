import 'package:flutter/material.dart';
import 'package:grzybek/main.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/Login_Background.png'),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nazwa uzytkownika',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Hasło', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Powtórz hasło', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(
                height: 70,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('Zarejestruj'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown))),
            ],
          )),
    );
  }
}
