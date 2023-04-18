import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  static const flutterSecureStorage = FlutterSecureStorage();

// Iniciar sesión con correo electrónico y contraseña
  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

// Registrar usuario con correo electrónico y contraseña
  static Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

// Cerrar sesión
  static Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
