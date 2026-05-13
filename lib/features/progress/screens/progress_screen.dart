import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressLogs = [
      {'date': '12/05/2026', 'weight': 75.5, 'workouts': 3, 'calories': 2100},
      {'date': '11/05/2026', 'weight': 75.8, 'workouts': 2, 'calories': 2200},
      {'date': '10/05/2026', 'weight': 76.0, 'workouts': 3, 'calories': 2150},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Progreso')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Peso actual', style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 8),
                      Text('75.5 kg', style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(height: 8),
                      Text('-0.7 kg desde inicio',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Estadísticas', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(context, Icons.fitness_center, 'Entrenamientos', '10'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(context, Icons.local_fire_department, 'Calorías', '2150'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Historial', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: progressLogs.length,
                itemBuilder: (context, index) {
                  final log = progressLogs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(log['date'] as String, style: Theme.of(context).textTheme.titleSmall),
                              const SizedBox(height: 4),
                              Text('Peso: ${log['weight']} kg', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${log['workouts']} entrenamientos', style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Text('${log['calories']} cal', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
          ],
        ),
      ),
    );
  }
}
