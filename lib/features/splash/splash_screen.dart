// lib/features/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../home/main_screen.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Aumentamos un poco la duración para apreciar el rebote
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Animación de rebote para el logo (ocurre del 0% al 60% del tiempo)
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    // 2. Deslizamiento hacia arriba para el texto (ocurre del 40% al 100% del tiempo)
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // 3. Aparición (Fade) para el texto sincronizado con el deslizamiento
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Navegación automática a los 3.5 segundos
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const MainScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.burgundy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación del ícono
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                // Aquí usamos un ícono, pero si quieres usar tu logo en PNG,
                // comenta el Icon y descomenta la línea de Image.asset
                child: const Icon(Icons.school,
                    size: 80, color: AppTheme.burgundy),
                // child: Image.asset('assets/icons/logo.png', width: 80, height: 80),
              ),
            ),

            const SizedBox(height: 30),

            // Animación en cascada de los textos
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      'Bienvenido a',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.white.withOpacity(0.9),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.5,
                          ),
                    ),
                    Text(
                      'CBTIS 66',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppTheme.white,
                            fontSize: 52,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Explora nuestras especialidades',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.white,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
