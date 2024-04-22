import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grzybek/login_screen.dart'; // Upewnij się, że ta ścieżka jest poprawna w Twoim projekcie

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      // Obejmujemy aplikację ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GRZYBEK!',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/Warning.png',
                    width: 130,
                    height: 130,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.brown),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(150, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen()),
                      );
                    },
                    child: Text('Kontynnuj'),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Key? key;
  @override
  final Size preferredSize;

  CustomAppBar({
    this.key,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFFFFDABA),
      elevation: 0,
      title: SvgPicture.asset(
        'assets/LOGO.svg',
        height: 135,
      ),
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isLoggedIn ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
