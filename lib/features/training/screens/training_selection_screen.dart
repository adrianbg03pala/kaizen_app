import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/exercises_provider.dart';
import '../../../core/theme/app_theme.dart';

class TrainingSelectionScreen extends ConsumerWidget {
  const TrainingSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingType = ref.watch(selectedTrainingTypeProvider);

    if (trainingType == null) {
      return Scaffold(
        body: Center(
          child: Text('Error: No training type selected'),
        ),
      );
    }

    // Seleccionar el provider basado en el tipo
    final plansProvider = switch (trainingType) {
      'general' => plansGeneralProvider,
      'running' => plansRunningProvider,
      'musculacion' => plansMusculacionProvider,
      _ => plansGeneralProvider,
    };

    final plansAsync = ref.watch(plansProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tu plan'),
        backgroundColor: AppTheme.darkGrey,
      ),
      body: Container(
        color: AppTheme.darkBg,
        child: plansAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
          ),
          error: (err, stack) => Center(
            child: Text('Error: $err'),
          ),
          data: (plans) {
            if (plans.isEmpty) {
              return const Center(
                child: Text('No planes disponibles'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return _buildPlanCard(context, ref, plan);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, WidgetRef ref, TrainingPlan plan) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedPlanProvider.notifier).state = plan;
        context.go('/');
      },
      child: Card(
        color: AppTheme.darkGrey,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          plan.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      plan.level,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        '${plan.daysPerWeek} días/semana',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        '${plan.durationWeeks} semanas',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
