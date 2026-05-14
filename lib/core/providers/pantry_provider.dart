import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pantry_model.dart';
import '../services/pantry_service.dart';
import 'auth_provider.dart';

/// Provider para obtener el UID del usuario autenticado
final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.whenData((user) => user?.uid).value;
});

/// Provider para stream de productos de la pantry del usuario
final pantryProductsProvider = StreamProvider<List<PantryProduct>>((ref) {
  final userId = ref.watch(userIdProvider);

  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  return PantryService.getProductsStream(userId);
});

/// Provider para productos por categoría
final pantryByCategoryProvider =
    StreamProvider.family<List<PantryProduct>, String>(
  (ref, category) {
    final userId = ref.watch(userIdProvider);

    if (userId == null || userId.isEmpty) {
      return Stream.value([]);
    }

    return PantryService.getProductsByCategory(userId, category);
  },
);

/// Provider para total de precio estimado
final totalPriceProvider = StreamProvider<double>((ref) async* {
  final userId = ref.watch(userIdProvider);

  if (userId == null || userId.isEmpty) {
    yield 0;
    return;
  }

  // Escuchar cambios en los productos
  await for (final products in PantryService.getProductsStream(userId)) {
    double total = 0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    yield total;
  }
}.asBroadcastStream());

/// Provider para categorías disponibles
final categoriesProvider = Provider<List<String>>((ref) {
  return [
    'Proteínas',
    'Carbohidratos',
    'Verduras',
    'Frutas',
    'Lácteos',
    'Condimentos',
    'Otros',
  ];
});

/// StateNotifier para agregar producto
class AddProductNotifier extends StateNotifier<AsyncValue<void>> {
  AddProductNotifier() : super(const AsyncValue.data(null));

  Future<void> addProduct(PantryProduct product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => PantryService.addProduct(product),
    );
  }
}

final addProductProvider =
    StateNotifierProvider<AddProductNotifier, AsyncValue<void>>((ref) {
  return AddProductNotifier();
});

/// StateNotifier para actualizar producto
class UpdateProductNotifier extends StateNotifier<AsyncValue<void>> {
  UpdateProductNotifier() : super(const AsyncValue.data(null));

  Future<void> updateProduct(
    String userId,
    String productId,
    Map<String, dynamic> updates,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => PantryService.updateProduct(userId, productId, updates),
    );
  }
}

final updateProductProvider =
    StateNotifierProvider<UpdateProductNotifier, AsyncValue<void>>((ref) {
  return UpdateProductNotifier();
});

/// StateNotifier para eliminar producto
class DeleteProductNotifier extends StateNotifier<AsyncValue<void>> {
  DeleteProductNotifier() : super(const AsyncValue.data(null));

  Future<void> deleteProduct(String userId, String productId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => PantryService.deleteProduct(userId, productId),
    );
  }
}

final deleteProductProvider =
    StateNotifierProvider<DeleteProductNotifier, AsyncValue<void>>((ref) {
  return DeleteProductNotifier();
});
