/// Modelo para representar un usuario de KAIZEN
/// Almacena información del usuario autenticado en Firebase
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? fitnessGoal; // "Perder peso", "Ganar músculo", etc.
  final String? level; // "Principiante", "Intermedio", "Avanzado"
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.fitnessGoal,
    this.level,
    required this.createdAt,
  });

  /// Crear UserModel desde datos de Firestore
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? 'Usuario',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      fitnessGoal: data['fitnessGoal'],
      level: data['level'],
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }

  /// Convertir a Map para guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'fitnessGoal': fitnessGoal,
      'level': level,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Crear copia con cambios
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? fitnessGoal,
    String? level,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
