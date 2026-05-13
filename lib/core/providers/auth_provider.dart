import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

// =============================================================================
// PROVIDERS DE AUTENTICACIÓN
// =============================================================================

/// StreamProvider que monitorea los cambios de autenticación de Firebase
/// Devuelve null si no hay usuario autenticado
/// Devuelve User? si hay usuario autenticado
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// StreamProvider que devuelve los datos del usuario actual desde Firestore
/// Solo emite datos si hay un usuario autenticado
/// Se actualiza en tiempo real cuando los datos del usuario cambian en Firestore
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    // Si la autenticación se está cargando
    loading: () => Stream.value(null),
    // Si hay error en autenticación
    error: (err, stack) => Stream.error(err),
    // Si hay datos de autenticación
    data: (user) {
      // Si no hay usuario autenticado, retornar null
      if (user == null) {
        return Stream.value(null);
      }

      // Si hay usuario, obtener sus datos desde Firestore
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snap) {
        if (!snap.exists) {
          return null;
        }
        return UserModel.fromFirestore(snap.data()!, snap.id);
      });
    },
  );
});

/// Provider que devuelve una instancia de FirebaseAuth
/// Útil para inyectar dependencias
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provider que devuelve una instancia de FirebaseFirestore
/// Útil para inyectar dependencias
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provider que devuelve una instancia de GoogleSignIn
/// Necesario para el login con Google
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);
});

// =============================================================================
// NOTIFIER PARA OPERACIONES DE AUTENTICACIÓN
// =============================================================================

/// Notifier para manejar operaciones de login/logout
/// Usa Riverpod para state management de autenticación
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

/// Clase que maneja todas las operaciones de autenticación
class AuthService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthService({
    required this.auth,
    required this.firestore,
    required this.googleSignIn,
  });

  /// Inicia sesión con Google
  /// Crea un nuevo documento en Firestore si el usuario no existe
  /// Devuelve el User de Firebase si es exitoso
  /// Lanza excepción si falla
  Future<User?> signInWithGoogle() async {
    try {
      // Iniciar flujo de Google Sign-In
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In cancelado');
      }

      // Obtener credenciales de autenticación
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase con credenciales de Google
      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Crear/actualizar documento en Firestore
        await _createOrUpdateUserInFirestore(user, googleUser);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error de Firebase Auth: ${e.message}');
    } catch (e) {
      throw Exception('Error al iniciar sesión con Google: $e');
    }
  }

  /// Cierra la sesión actual
  /// Desconecta de Google Sign-In y Firebase Auth
  Future<void> signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  /// Crea o actualiza el documento del usuario en Firestore
  Future<void> _createOrUpdateUserInFirestore(
    User firebaseUser,
    GoogleSignInAccount googleUser,
  ) async {
    try {
      final userRef = firestore.collection('users').doc(firebaseUser.uid);
      final docSnapshot = await userRef.get();

      if (!docSnapshot.exists) {
        // Crear nuevo documento
        final newUser = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? googleUser.displayName ?? 'Usuario',
          email: firebaseUser.email ?? googleUser.email,
          photoUrl: firebaseUser.photoURL ?? googleUser.photoUrl,
          createdAt: DateTime.now(),
        );

        await userRef.set(newUser.toFirestore());
      } else {
        // Actualizar documento existente con nuevos datos de Google
        await userRef.update({
          'name': firebaseUser.displayName ?? googleUser.displayName,
          'photoUrl': firebaseUser.photoURL ?? googleUser.photoUrl,
        });
      }
    } catch (e) {
      print('Error al crear/actualizar usuario en Firestore: $e');
      // No lanzar excepción aquí para que el login no falle
    }
  }

  /// Obtiene el usuario actual desde Firestore
  /// Devuelve null si no hay usuario autenticado
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user == null) return null;

      final docSnapshot =
          await firestore.collection('users').doc(user.uid).get();
      if (!docSnapshot.exists) return null;

      return UserModel.fromFirestore(docSnapshot.data()!, docSnapshot.id);
    } catch (e) {
      print('Error al obtener usuario actual: $e');
      return null;
    }
  }
}
