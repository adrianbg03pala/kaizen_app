import 'package:flutter/material.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final List<Map<String, dynamic>> _workouts = [
    {'exercise': 'Flexiones', 'series': 3, 'reps': 12, 'weight': '-', 'completed': false},
    {'exercise': 'Sentadillas', 'series': 4, 'reps': 15, 'weight': '20kg', 'completed': false},
    {'exercise': 'Dominadas', 'series': 3, 'reps': 8, 'weight': '-', 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamientos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          final workout = _workouts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(workout['exercise'] as String, style: Theme.of(context).textTheme.titleMedium),
                      Checkbox(
                        value: workout['completed'] as bool,
                        onChanged: (value) {
                          setState(() => _workouts[index]['completed'] = value ?? false);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat(context, 'Series', '${workout['series']}'),
                      _buildStat(context, 'Reps', '${workout['reps']}'),
                      _buildStat(context, 'Peso', workout['weight'] as String),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )),
      ],
    );
  }
}
