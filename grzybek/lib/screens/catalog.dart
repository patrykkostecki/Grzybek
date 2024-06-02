import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grzybek/mushroom_data.dart';
import 'package:grzybek/styles.dart';

class MushroomCatalog extends ConsumerStatefulWidget {
  const MushroomCatalog({Key? key}) : super(key: key);

  @override
  _MushroomCatalogState createState() => _MushroomCatalogState();
}

class _MushroomCatalogState extends ConsumerState<MushroomCatalog> {
  String? selectedMushroom;

  @override
  Widget build(BuildContext context) {
    final selectedMushroomDetails = mushrooms.firstWhere(
      (mushroom) => mushroom['name'] == selectedMushroom,
      orElse: () => {},
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/HomeBackground.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppButtonStyles.primaryGradientStart.withOpacity(0.8),
                      AppButtonStyles.primaryGradientEnd.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 189, 165, 130).withOpacity(0.8),
                    width: 4,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMushroom,
                    hint: Text(
                      'Wybierz grzyba',
                      style: TextStyle(
                        color: Color.fromARGB(
                            255, 229, 215, 194), // Kolor tekstu wskazówki
                      ),
                    ),
                    dropdownColor: AppButtonStyles
                        .primaryGradientStart, // Kolor tła listy rozwijanej
                    iconEnabledColor: Color.fromARGB(
                        255, 229, 215, 194), // Kolor ikony rozwijania
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 229, 215, 194), // Kolor tekstu elementów listy
                    ),
                    items: mushrooms.map((mushroom) {
                      return DropdownMenuItem<String>(
                        value: mushroom['name'],
                        child: Text(
                          mushroom['name']!,
                          style: TextStyle(
                            color: Color.fromARGB(255, 229, 215,
                                194), // Kolor tekstu elementu listy
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMushroom = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            if (selectedMushroom != null && selectedMushroomDetails.isNotEmpty)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 26.0),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                          maxHeight: 200,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 165, 130)
                                .withOpacity(0.8),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          selectedMushroomDetails['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 250, // Fixed height for the container
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppButtonStyles.primaryGradientStart
                                .withOpacity(0.8),
                            AppButtonStyles.primaryGradientEnd.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Color.fromARGB(255, 189, 165, 130)
                              .withOpacity(0.8),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 200, // Same height as the container
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 229, 215, 194),
                                height: 1.5,
                              ),
                              children: selectedMushroomDetails['description']!
                                  .trim()
                                  .split('\n')
                                  .map((line) {
                                if (line.contains(':')) {
                                  final parts = line.split(':');
                                  return TextSpan(
                                    children: [
                                      TextSpan(
                                        text: parts[0] + ': ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: parts[1] + '\n'),
                                    ],
                                  );
                                } else {
                                  return TextSpan(text: line + '\n');
                                }
                              }).toList(),
                            ),
                            textAlign:
                                TextAlign.center, // Center-align the text
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
