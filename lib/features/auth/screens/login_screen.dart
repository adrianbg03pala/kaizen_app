import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0A0A0A),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo KAIZEN
                Text(
                  'KAIZEN',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: const Color(0xFF00FF41),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Subtítulo
                Text(
                  'Tu viaje de mejora continua',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF9A9A9A),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),

                // Botón
                if (_isLoading)
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF00FF41),
                      ),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _isLoading = true);
                      // TODO: Agregar Google Sign-In aquí
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) {
                          setState(() => _isLoading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login en desarrollo')),
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Iniciar con Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF41),
                      foregroundColor: const Color(0xFF0A0A0A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
