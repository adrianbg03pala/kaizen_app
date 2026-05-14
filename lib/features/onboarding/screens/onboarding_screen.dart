import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/exercises_provider.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: AppTheme.darkBg,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Column(
                  children: [
                    Text(
                      'KAIZEN',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tu viaje de mejora continua',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                // Contenido principal
                Column(
                  children: [
                    Text(
                      '¿Cuál es tu tipo de entrenamiento?',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Opción 1: General
                    _buildTrainingOption(
                      context,
                      icon: Icons.favorite,
                      title: '🏃 General Fitness',
                      subtitle: 'Mantente en forma sin musculación',
                      onTap: () {
                        ref.read(selectedTrainingTypeProvider.notifier).state = 'general';
                        context.go('/training-selection');
                      },
                    ),
                    const SizedBox(height: 16),
                    // Opción 2: Running
                    _buildTrainingOption(
                      context,
                      icon: Icons.directions_run,
                      title: '🏃‍♂️ Running',
                      subtitle: 'Planificación de carreras',
                      onTap: () {
                        ref.read(selectedTrainingTypeProvider.notifier).state = 'running';
                        context.go('/training-selection');
                      },
                    ),
                    const SizedBox(height: 16),
                    // Opción 3: Musculación
                    _buildTrainingOption(
                      context,
                      icon: Icons.fitness_center,
                      title: '💪 Musculación',
                      subtitle: 'Levantamiento de pesas',
                      onTap: () {
                        ref.read(selectedTrainingTypeProvider.notifier).state = 'musculacion';
                        context.go('/training-selection');
                      },
                    ),
                  ],
                ),

                // Footer
                Text(
                  'Puedes cambiar esto después en configuración',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrainingOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
