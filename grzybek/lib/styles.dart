import 'package:flutter/material.dart';

class AppButtonStyles {
  static const Color primaryGradientStart = Color.fromARGB(255, 87, 66, 44);
  static const Color primaryGradientEnd = Color.fromARGB(255, 138, 95, 70);
  static const Color warningGradientStart = Color.fromARGB(255, 255, 99, 71);
  static const Color warningGradientEnd = Color.fromARGB(255, 255, 160, 122);

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(
        color: Color.fromARGB(255, 189, 165, 130),
        width: 4,
      ),
    ),
    shadowColor: Colors.black,
    elevation: 8,
  ).copyWith(
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
  );

  static Ink getGradientInk(String text, {double borderRadius = 30}) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryGradientStart, // Softer dark brown
            primaryGradientEnd, // Softer light brown
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 150,
          minHeight: 50,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 229, 215, 194),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static final ButtonStyle warningButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: Color.fromARGB(255, 255, 178, 102), // Softer orange border
        width: 3,
      ),
    ),
    shadowColor: Colors.black, // Shadow color
    elevation: 10, // Shadow intensity
  ).copyWith(
    backgroundColor: MaterialStateProperty.all(
        Color.fromARGB(255, 255, 193, 119)), // Softer orange
  );

  static Ink getWarningGradientInk(String text, {double borderRadius = 20}) {
    return Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            warningGradientStart, // Softer darker orange
            warningGradientEnd, // Softer light orange
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 150,
          minHeight: 50,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
