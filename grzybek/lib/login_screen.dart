import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grzybek/HomeView.dart';
import 'package:grzybek/main.dart';
import 'package:grzybek/login.dart';
import 'package:grzybek/providers.dart';
import 'package:grzybek/registration.dart';
import 'package:grzybek/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends ConsumerWidget {
  Future<String?> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

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
                      'assets/Grzybek _Login.png',
                      width: 275,
                      height: 275,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 0.1),
                      child: Text(
                        isLoggedIn
                            ? 'Witaj w Aplikacji Grzybek!'
                            : 'Zaloguj się, aby uzyskać więcej funkcji!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLoggedIn ? 20.0 : 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    if (!isLoggedIn)
                      Container(
                        width: 200, // Set the desired width here
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: AppButtonStyles.primaryButtonStyle,
                          child: AppButtonStyles.getGradientInk(
                            'Logowanie',
                            borderRadius: 24,
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    Container(
                      width: 200, // Set the desired width here
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLoggedIn) {
                            FirebaseAuth.instance.signOut();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()),
                            );
                          }
                        },
                        style: AppButtonStyles.primaryButtonStyle,
                        child: AppButtonStyles.getGradientInk(
                          isLoggedIn ? 'Wyloguj' : 'Rejestracja',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 200, // Set the desired width here
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLoggedIn) {
                            // Przechodzi do HomeView, zachowując możliwość powrotu
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()),
                            );
                          } else {
                            // Wylogowanie, jeśli użytkownik nie jest zalogowany i przejście do HomeView
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()),
                            );
                          }
                        },
                        style: AppButtonStyles.primaryButtonStyle,
                        child: AppButtonStyles.getGradientInk(
                          isLoggedIn ? 'Menu' : 'Kontynuuj bez logowania',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
