import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grzybek/main.dart';
import 'package:grzybek/mushroom_classifation.dart';
import 'package:grzybek/providers.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class HomeView extends ConsumerWidget {
  // Change StatelessWidget to ConsumerWidget
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).asData?.value;
    final isLoggedIn = user != null;

    print("Whole Page Built!");
    return Scaffold(
      appBar: CustomAppBar(),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_menu.png"),
            fit: BoxFit.cover,
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
                ClassifierWidget(),
                Center(child: Icon(Icons.account_box, size: 100)),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
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
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 1,
                    ),
                    child: NavigationBar(
                      height: 70,
                      selectedIndex: currentIndex,
                      destinations: [
                        NavigationDestination(
                          icon: isLoggedIn
                              ? Icon(Icons.menu_book_outlined)
                              : Icon(Icons.close, color: Colors.red),
                          label: 'Katalog',
                        ),
                        NavigationDestination(
                          icon: isLoggedIn
                              ? Icon(Icons.forum_outlined)
                              : Icon(Icons.close, color: Colors.red),
                          label: 'Forum',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.local_florist_outlined),
                          label: 'Rozpoznaj',
                        ),
                        NavigationDestination(
                          icon: isLoggedIn
                              ? Icon(Icons.notifications)
                              : Icon(Icons.close, color: Colors.red),
                          label: 'Alerty',
                        ),
                        NavigationDestination(
                          icon: isLoggedIn
                              ? Icon(Icons.forest_outlined)
                              : Icon(Icons.close, color: Colors.red),
                          label: 'Mapa',
                        ),
                      ],
                      onDestinationSelected: (int index) {
                        if (isLoggedIn || index == 2) {
                          ref
                              .read(bottomNavIndexProvider.notifier)
                              .update((state) => index);
                        }
                      },
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
