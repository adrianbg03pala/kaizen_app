import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Obtener el usuario actual
  static User? get currentUser => _auth.currentUser;

  /// Stream de cambios de autenticación
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Iniciar sesión con Google
  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Guardar usuario en Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.displayName ?? 'Usuario',
          'email': user.email,
          'photoUrl': user.photoURL,
          'createdAt': DateTime.now().toIso8601String(),
        }, SetOptions(merge: true));
      }

      return user;
    } catch (e) {
      print('Error en Google Sign-In: $e');
      rethrow;
    }
  }

  /// Cerrar sesión
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
      rethrow;
    }
  }
}
