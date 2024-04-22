import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grzybek/HomeView.dart';
import 'package:grzybek/main.dart';
import 'package:grzybek/login.dart';
import 'package:grzybek/providers.dart';
import 'package:grzybek/registration.dart';

class SecondScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).asData?.value;
    final isLoggedIn = user != null;
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
                    child: isLoggedIn
                        ? Text('WITAM')
                        : Text(
                            "Zaloguj się do aplikacji Grzybek aby mieć dostęp do wiekszych mozliwosci!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  isLoggedIn
                      ? SizedBox(
                          height: 50,
                        )
                      : TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.brown),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('Logowanie'),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      onPressed: () {
                        if (isLoggedIn) {
                          FirebaseAuth.instance.signOut();
                        } else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                      },
                      child:
                          isLoggedIn ? Text('Wyloguj') : Text('Rejestracja')),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      if (isLoggedIn) {
                        // Przechodzi do HomeView, zachowując możliwość powrotu
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        );
                      } else {
                        // Wylogowanie, jeśli użytkownik nie jest zalogowany i przejście do HomeView
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        );
                      }
                    },
                    child: isLoggedIn
                        ? Text('Menu')
                        : Text('Kontynuuj bez logowania'),
                  ),
                ]))),
          )),
    ));
  }
}
