import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grzybek/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GRZYBEK!',
      home: Builder(
        builder: (context) => Scaffold(
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
                    SvgPicture.asset(
                      'assets/LOGO.svg',
                      width: 256,
                      height: 256,
                    ),
                    // SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "UWAGA!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 0.1),
                      child: Text(
                        "Ta aplikacja służy wyłącznie do celów informacyjnych i edukacyjnych. "
                        "Nie należy jej używać jako jedynego narzędzia do identyfikacji grzybów. "
                        "Rozpoznawanie grzybów jest skomplikowanym procesem i błędna identyfikacja może prowadzić do poważnych konsekwencji zdrowotnych, w tym zatruć. "
                        "Zawsze korzystaj z usług wykwalifikowanych ekspertów mykologicznych lub odpowiednich przewodników. "
                        "Twórcy aplikacji nie biorą odpowiedzialności za żadne szkody wynikające z użycia aplikacji, w tym za niewłaściwe zidentyfikowanie grzybów. "
                        "Użytkownik aplikacji robi to na własne ryzyko.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // SizedBox(height: 0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen()),
                        );
                      },
                      child: Image.asset(
                        'assets/kontynuuj_button.png',
                        width: 700,
                        height: 300,
                      ),
                    ),
                    // SizedBox(height: 0),
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
