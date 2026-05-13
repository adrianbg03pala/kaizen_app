import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KAIZEN')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¡Hola, Bobi!', style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 8),
              Text('Tu viaje de mejora continua comienza aquí', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 32),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCard(context, Icons.shopping_cart, 'Smart Pantry', () => context.go('/smart-pantry')),
                  _buildCard(context, Icons.fitness_center, 'Training', () => context.go('/training')),
                  _buildCard(context, Icons.show_chart, 'Progress', () => context.go('/progress')),
                  _buildCard(context, Icons.person, 'Profile', () => context.go('/profile')),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0: context.go('/'); break;
            case 1: context.go('/smart-pantry'); break;
            case 2: context.go('/training'); break;
            case 3: context.go('/progress'); break;
            case 4: context.go('/profile'); break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Pantry'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
