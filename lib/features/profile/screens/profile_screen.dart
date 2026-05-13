import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              _buildInfoCard(context, Icons.person_outline, 'Nombre', 'Bobi'),
              const SizedBox(height: 12),
              _buildInfoCard(context, Icons.email_outlined, 'Email', 'adrianbg03@gmail.com'),
              const SizedBox(height: 12),
              _buildInfoCard(context, Icons.track_changes, 'Objetivo', 'Fitness y nutrición'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
