import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grzybek/database/database_helper.dart';
import 'package:grzybek/main.dart';
import 'package:grzybek/menu.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
    print("Próba logowania...");
    String email =
        _usernameController.text.trim(); // Upewnij się, że jest to e-mail
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Żadne pole nie może być puste')),
      );
      return; // Przerwanie funkcji, jeśli jakiekolwiek pole jest puste
    }

    try {
      // Użyj FirebaseAuth do logowania
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jeśli nie zostanie rzucony wyjątek, logowanie jest udane
      print("Logowanie udane, przechodzenie do MenuScreen...");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MenuScreen())); // Przekierowanie
    } on FirebaseAuthException catch (e) {
      // Obsługa błędów logowania
      print("Logowanie nieudane. Błąd: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logowanie nieudane: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/Login_Background.png"), // Tło zostało przywrócone
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Hasło', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginUser,
                child: Text('Zaloguj'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.brown),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Tutaj dodaj funkcjonalność przypominania hasła
                },
                child: Text('Zapomniałem hasła'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
