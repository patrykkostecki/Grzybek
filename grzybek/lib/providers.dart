// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final authStateProvider = StateProvider<bool>((ref) {
  final user = ref.watch(authStateChangesProvider).asData?.value;
  return user != null;
});

// final authStateChangesProvider = StreamProvider<User?>((ref) {
//   return FirebaseAuth.instance.authStateChanges();
// });

final usernameProvider = StateProvider<String>((ref) {
  return '';
});
