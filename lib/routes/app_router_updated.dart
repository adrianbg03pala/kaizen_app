import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen_updated.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/training/screens/training_selection_screen.dart';
import '../features/training/screens/training_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/smart_pantry/screens/smart_pantry_screen.dart';
import '../features/progress/screens/progress_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      // Autenticación
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Selección de plan
      GoRoute(
        path: '/training-selection',
        name: 'trainingSelection',
        builder: (context, state) => const TrainingSelectionScreen(),
      ),

      // Home con navegación bottom - Shell route
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/smart-pantry',
            name: 'smartPantry',
            builder: (context, state) => const SmartPantryScreen(),
          ),
          GoRoute(
            path: '/training',
            name: 'training',
            builder: (context, state) => const TrainingScreen(),
          ),
          GoRoute(
            path: '/progress',
            name: 'progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

class BottomNavShell extends ConsumerWidget {
  final Widget child;

  const BottomNavShell({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;

    // Mapear ruta a índice
    int currentIndex = 0;
    switch (location) {
      case '/':
        currentIndex = 0;
        break;
      case '/smart-pantry':
        currentIndex = 1;
        break;
      case '/training':
        currentIndex = 2;
        break;
      case '/progress':
        currentIndex = 3;
        break;
      case '/profile':
        currentIndex = 4;
        break;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/smart-pantry');
              break;
            case 2:
              context.go('/training');
              break;
            case 3:
              context.go('/progress');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Pantry'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progreso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
