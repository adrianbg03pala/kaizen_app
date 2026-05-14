import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pantry_model.dart';

class PantryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Agregar producto a la despensa
  static Future<String> addProduct(PantryProduct product) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc(product.userId)
          .collection('pantry')
          .add(product.toFirestore());
      return docRef.id;
    } catch (e) {
      print('Error al agregar producto: $e');
      rethrow;
    }
  }

  /// Obtener todos los productos del usuario
  static Stream<List<PantryProduct>> getProductsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('pantry')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PantryProduct.fromFirestore(doc))
            .toList());
  }

  /// Obtener productos por categoría
  static Stream<List<PantryProduct>> getProductsByCategory(
    String userId,
    String category,
  ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('pantry')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PantryProduct.fromFirestore(doc))
            .toList());
  }

  /// Actualizar producto
  static Future<void> updateProduct(
    String userId,
    String productId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('pantry')
          .doc(productId)
          .update(updates);
    } catch (e) {
      print('Error al actualizar producto: $e');
      rethrow;
    }
  }

  /// Eliminar producto
  static Future<void> deleteProduct(String userId, String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('pantry')
          .doc(productId)
          .delete();
    } catch (e) {
      print('Error al eliminar producto: $e');
      rethrow;
    }
  }

  /// Toggle checked state
  static Future<void> toggleChecked(
    String userId,
    String productId,
    bool isChecked,
  ) async {
    try {
      await updateProduct(userId, productId, {'isChecked': isChecked});
    } catch (e) {
      print('Error al actualizar estado: $e');
      rethrow;
    }
  }

  /// Obtener total estimado
  static Future<double> getTotalPrice(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('pantry')
          .get();

      double total = 0;
      for (var doc in snapshot.docs) {
        final product = PantryProduct.fromFirestore(doc);
        total += product.price * product.quantity;
      }
      return total;
    } catch (e) {
      print('Error al obtener total: $e');
      return 0;
    }
  }

  /// Limpiar lista de compra (eliminar checkeados)
  static Future<void> clearCheckedItems(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('pantry')
          .where('isChecked', isEqualTo: true)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error al limpiar items: $e');
      rethrow;
    }
  }
}
