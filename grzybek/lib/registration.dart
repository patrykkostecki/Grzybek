import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grzybek/login_screen.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  void _registerUser() async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String repeatPassword = _repeatPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Żadne pole nie może być puste')),
      );
      return;
    }

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hasła się nie zgadzają')),
      );
      return;
    }

    try {
      // Używamy Firebase Authentication do rejestracji użytkownika
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Zapisz dodatkowe informacje o użytkowniku w Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': username,
        'email': email,
        // Nie zapisuj haseł w bazie danych! Zostają one bezpiecznie zarządzane przez FirebaseAuth
      });

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SecondScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rejestracja się powiodła')),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Wystąpił błąd przy rejestracji';
      if (e.code == 'weak-password') {
        message = 'Podane hasło jest za słabe.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Konto z tym adresem email już istnieje.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wystąpił błąd przy rejestracji')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rejestracja')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 50)),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nazwa użytkownika',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _repeatPasswordController,
                decoration: InputDecoration(
                  labelText: 'Powtórz hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 70),
              TextButton(
                onPressed: _registerUser,
                child: Text('Zarejestruj'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
