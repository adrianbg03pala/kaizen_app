import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/exercises_provider.dart';
import '../../../core/theme/app_theme.dart';

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedTrainingTypeProvider);
    final selectedPlan = ref.watch(selectedPlanProvider);

    if (selectedType == null || selectedPlan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Entrenamiento')),
        body: Center(
          child: Text('Selecciona un tipo de entrenamiento primero'),
        ),
      );
    }

    // Seleccionar provider de ejercicios
    final exercisesProvider = switch (selectedType) {
      'general' => exercisesGeneralProvider,
      'running' => exercisesRunningProvider,
      'musculacion' => exercisesMusculacionProvider,
      _ => exercisesGeneralProvider,
    };

    final exercisesAsync = ref.watch(exercisesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlan.name),
        backgroundColor: AppTheme.darkGrey,
      ),
      body: Container(
        color: AppTheme.darkBg,
        child: exercisesAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
          ),
          error: (err, stack) => Center(
            child: Text('Error: $err'),
          ),
          data: (exercises) {
            if (exercises.isEmpty) {
              return const Center(
                child: Text('No hay ejercicios disponibles'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return _buildExerciseCard(context, exercise);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, Exercise exercise) {
    return Card(
      color: AppTheme.darkGrey,
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.primaryColor,
              ),
        ),
        subtitle: Text(
          exercise.description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Dificultad:', '${exercise.difficulty}/10'),
                _buildInfoRow('Series:', '${exercise.defaultSets}'),
                _buildInfoRow('Repeticiones:', '${exercise.defaultReps}'),
                _buildInfoRow('Duración:', '${exercise.durationMinutes} min'),
                _buildInfoRow('Equipamiento:', exercise.equipment),
                const SizedBox(height: 16),
                Text(
                  'Instrucciones:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                ),
                const SizedBox(height: 8),
                ...exercise.instructions.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${entry.key + 1}. ${entry.value}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
