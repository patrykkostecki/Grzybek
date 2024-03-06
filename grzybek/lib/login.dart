import 'package:flutter/material.dart';
import 'package:grzybek/main.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50)),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Login', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Hasło', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Zaloguj'),
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
