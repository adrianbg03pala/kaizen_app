import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Modelos simples
class Exercise {
  final String id;
  final String name;
  final String description;
  final List<String> muscleGroups;
  final int difficulty;
  final int defaultSets;
  final int defaultReps;
  final int durationMinutes;
  final List<String> instructions;
  final String equipment;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleGroups,
    required this.difficulty,
    required this.defaultSets,
    required this.defaultReps,
    required this.durationMinutes,
    required this.instructions,
    required this.equipment,
  });

  factory Exercise.fromFirestore(Map<String, dynamic> data, String id) {
    return Exercise(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      muscleGroups: List<String>.from(data['muscle_groups'] ?? []),
      difficulty: data['difficulty'] ?? 5,
      defaultSets: data['default_sets'] ?? 3,
      defaultReps: data['default_reps'] ?? 10,
      durationMinutes: data['duration_minutes'] ?? 15,
      instructions: List<String>.from(data['instructions'] ?? []),
      equipment: data['equipment_needed'] ?? 'ninguno',
    );
  }
}

class TrainingPlan {
  final String id;
  final String name;
  final String description;
  final String level;
  final int daysPerWeek;
  final int durationWeeks;

  TrainingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.daysPerWeek,
    required this.durationWeeks,
  });

  factory TrainingPlan.fromFirestore(Map<String, dynamic> data, String id) {
    return TrainingPlan(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      level: data['level'] ?? 'principiante',
      daysPerWeek: data['days_per_week'] ?? 3,
      durationWeeks: data['duration_weeks'] ?? 12,
    );
  }
}

// Providers
final exercisesGeneralProvider = StreamProvider<List<Exercise>>((ref) {
  return FirebaseFirestore.instance
      .collection('exercises')
      .doc('general')
      .collection('exercises_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Exercise.fromFirestore(doc.data(), doc.id))
          .toList());
});

final exercisesRunningProvider = StreamProvider<List<Exercise>>((ref) {
  return FirebaseFirestore.instance
      .collection('exercises')
      .doc('running')
      .collection('exercises_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Exercise.fromFirestore(doc.data(), doc.id))
          .toList());
});

final exercisesMusculacionProvider = StreamProvider<List<Exercise>>((ref) {
  return FirebaseFirestore.instance
      .collection('exercises')
      .doc('musculacion')
      .collection('exercises_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Exercise.fromFirestore(doc.data(), doc.id))
          .toList());
});

final plansGeneralProvider = StreamProvider<List<TrainingPlan>>((ref) {
  return FirebaseFirestore.instance
      .collection('training_plans')
      .doc('general')
      .collection('plans_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => TrainingPlan.fromFirestore(doc.data(), doc.id))
          .toList());
});

final plansRunningProvider = StreamProvider<List<TrainingPlan>>((ref) {
  return FirebaseFirestore.instance
      .collection('training_plans')
      .doc('running')
      .collection('plans_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => TrainingPlan.fromFirestore(doc.data(), doc.id))
          .toList());
});

final plansMusculacionProvider = StreamProvider<List<TrainingPlan>>((ref) {
  return FirebaseFirestore.instance
      .collection('training_plans')
      .doc('musculacion')
      .collection('plans_data')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => TrainingPlan.fromFirestore(doc.data(), doc.id))
          .toList());
});

// Provider para tipo de entrenamiento seleccionado
final selectedTrainingTypeProvider = StateProvider<String?>((ref) {
  return null;
});

// Provider para plan seleccionado
final selectedPlanProvider = StateProvider<TrainingPlan?>((ref) {
  return null;
});
