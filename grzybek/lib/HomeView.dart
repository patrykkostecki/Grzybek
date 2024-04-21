import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grzybek/main.dart';
import 'package:grzybek/mushroom_classifation.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print("Whole Page Built!");
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/background_menu.png"), // Zmień na odpowiednią ścieżkę do pliku tła
            fit: BoxFit.cover, // Możesz wybrać jak tło powinno być dopasowane
          ),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            print('Index Stack Built!');
            final currentIndex = ref.watch(bottomNavIndexProvider);
            return IndexedStack(
              index: currentIndex,
              children: [
                Center(child: Icon(Icons.home, size: 100)),
                Center(child: Icon(Icons.settings, size: 100)),
                ClassifierWidget(), // Tutaj umieszczasz widget rozpoznawania
                Center(child: Icon(Icons.account_box, size: 100)),
                // Możesz dodać więcej dzieci jeśli potrzebujesz
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return Container(
            margin: EdgeInsets.only(bottom: 16), // Doda margines na dole
            decoration: BoxDecoration(
              color: Colors.transparent, // Tło dla efektu cienia
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  backgroundColor: Color(0xFF795548),
                  indicatorColor: Color.fromARGB(255, 100, 77, 68),
                  labelTextStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  // Tutaj możesz dostosować dodatkowe style dla NavigationBarThemeData
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        1, // Ten padding podnosi NavigationBar do góry, ale pozostawia cień pod spodem
                  ),
                  child: NavigationBar(
                    height: 70, // Możesz kontrolować wysokość NavigationBar
                    selectedIndex: currentIndex,
                    destinations: const [
                      NavigationDestination(
                          icon: Icon(Icons.menu_book_outlined),
                          label: 'Katalog'),
                      NavigationDestination(
                          icon: Icon(Icons.forum_outlined), label: 'Forum'),
                      NavigationDestination(
                          icon: Icon(Icons.local_florist_outlined),
                          label: 'Rozpoznaj'),
                      NavigationDestination(
                          icon: Icon(Icons.notifications), label: 'Alerty'),
                      NavigationDestination(
                          icon: Icon(Icons.forest_outlined), label: 'Mapa'),
                    ],
                    onDestinationSelected: (value) {
                      ref
                          .read(bottomNavIndexProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
