import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo para productos en la despensa
class PantryProduct {
  final String id;
  final String userId; // UID del usuario propietario
  final String name;
  final double price;
  final String category; // "Proteínas", "Carbohidratos", "Verduras", etc.
  final int quantity;
  final String? unit; // "kg", "L", "unidades", etc.
  final DateTime expiryDate;
  final DateTime createdAt;
  final bool isChecked; // Para listas de compra

  PantryProduct({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.category,
    this.quantity = 1,
    this.unit,
    required this.expiryDate,
    required this.createdAt,
    this.isChecked = false,
  });

  /// Crear desde Firestore
  factory PantryProduct.fromFirestore(
    DocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    return PantryProduct(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? 'Sin categoría',
      quantity: data['quantity'] ?? 1,
      unit: data['unit'],
      expiryDate: data['expiryDate'] != null
          ? DateTime.parse(data['expiryDate'])
          : DateTime.now().add(const Duration(days: 30)),
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      isChecked: data['isChecked'] ?? false,
    );
  }

  /// Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'name': name,
      'price': price,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'expiryDate': expiryDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isChecked': isChecked,
    };
  }

  /// Copiar con cambios
  PantryProduct copyWith({
    String? id,
    String? userId,
    String? name,
    double? price,
    String? category,
    int? quantity,
    String? unit,
    DateTime? expiryDate,
    DateTime? createdAt,
    bool? isChecked,
  }) {
    return PantryProduct(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt ?? this.createdAt,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
