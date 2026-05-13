import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/providers/auth_provider.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/smart_pantry/screens/smart_pantry_screen.dart';
import '../features/training/screens/training_screen.dart';
import '../features/progress/screens/progress_screen.dart';

/// Provider de GoRouter sin redirección (simplificado)
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
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
    ],
  );
});
