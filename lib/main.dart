import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';

void main() {
  runApp(const ProviderScope(child: KaizenApp()));
}

class KaizenApp extends StatelessWidget {
  const KaizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KAIZEN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
