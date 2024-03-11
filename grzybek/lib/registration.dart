import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grzybek/login_screen.dart';
import 'package:grzybek/main.dart';

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
    final String password = _passwordController.text.trim();
    final String repeatPassword = _repeatPasswordController.text.trim();

    // Sprawdzenie, czy żadne pole nie jest puste
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Żadne pole nie może być puste')),
      );
      return;
    }

    // Sprawdzenie, czy hasła są takie same
    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hasła się nie zgadzają')),
      );
      return;
    }

    // Użycie Firebase Authentication do utworzenia nowego użytkownika
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Możesz także chcieć zapisywać dodatkowe dane użytkownika, jak nazwę użytkownika
      // Tutaj możesz to zrobić, ale upewnij się, że masz odpowiednią strukturę bazy danych Firestore
      // await FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
      //   'username': username,
      //   'email': email,
      //   // inne potrzebne dane
      // });

      // Przekierowanie po pomyślnej rejestracji
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SecondScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rejestracja się powiodła')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rejestracja nieudana: ${e.message}')),
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
      appBar: CustomAppBar(),
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
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Hasło', border: OutlineInputBorder()),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Powtórz hasło', border: OutlineInputBorder()),
                  obscureText: true,
                ),
                SizedBox(
                  height: 70,
                ),
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
          )),
    );
  }
}
