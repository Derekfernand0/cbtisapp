// lib/features/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../../core/theme/app_theme.dart';
import '../home/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Animaciones para las 5 piezas
  late Animation<Offset> _slideS1;
  late Animation<double> _scaleS1;

  late Animation<Offset> _slideS2;
  late Animation<double> _scaleS2;

  late Animation<Offset> _slideS3;
  late Animation<double> _scaleS3;

  late Animation<Offset> _slideS4;
  late Animation<double> _scaleS4;

  late Animation<Offset> _slideS5;
  late Animation<double> _scaleS5;

  // Textos y fondo
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _glowScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // --- CONFIGURACIÓN DE LAS 5 PIEZAS ---
    // La idea es que cada pieza entre en un momento distinto, desde una dirección distinta

    // s1: Entra desde abajo a la izquierda, primero
    _slideS1 =
        Tween<Offset>(begin: const Offset(-1.5, 1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack)),
    );
    _scaleS1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic)),
    );

    // s2: Entra desde arriba a la derecha, un poco después
    _slideS2 =
        Tween<Offset>(begin: const Offset(1.5, -1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 0.5, curve: Curves.easeOutBack)),
    );
    _scaleS2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 0.5, curve: Curves.easeOutCubic)),
    );

    // s3: Entra desde abajo a la derecha
    _slideS3 =
        Tween<Offset>(begin: const Offset(1.5, 1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack)),
    );
    _scaleS3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic)),
    );

    // s4: Entra desde arriba a la izquierda
    _slideS4 = Tween<Offset>(begin: const Offset(-1.5, -1.5), end: Offset.zero)
        .animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOutBack)),
    );
    _scaleS4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic)),
    );

    // s5: Entra desde el centro (pop) al final, uniendo todo
    _slideS5 =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 0.8, curve: Curves.elasticOut)),
    );
    _scaleS5 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 0.8, curve: Curves.elasticOut)),
    );

    // --- EFECTOS EXTRAS ---
    // Brillo detrás del logo cuando se forma
    _glowScale = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeInOut)),
    );

    // Textos de Bienvenida
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeIn)),
    );
    _textSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic)),
    );

    _controller.forward();

    // Navegación Automática (5 segundos para apreciar todo)
    Timer(const Duration(milliseconds: 5000), () {
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
      backgroundColor: const Color(0xFF1A1A1A), // Fondo oscuro elegante
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenedor del Logo Animado
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Glow Effect (Brillo)
                  ScaleTransition(
                    scale: _glowScale,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.burgundy.withOpacity(0.3),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // PIEZA 1
                  SlideTransition(
                    position: _slideS1,
                    child: ScaleTransition(
                      scale: _scaleS1,
                      child: SvgPicture.asset(
                        'assets/icons/s1.svg',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // PIEZA 2
                  SlideTransition(
                    position: _slideS2,
                    child: ScaleTransition(
                      scale: _scaleS2,
                      child: SvgPicture.asset(
                        'assets/icons/s2.svg',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // PIEZA 3
                  SlideTransition(
                    position: _slideS3,
                    child: ScaleTransition(
                      scale: _scaleS3,
                      child: SvgPicture.asset(
                        'assets/icons/s3.svg',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // PIEZA 4
                  SlideTransition(
                    position: _slideS4,
                    child: ScaleTransition(
                      scale: _scaleS4,
                      child: SvgPicture.asset(
                        'assets/icons/s4.svg',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // PIEZA 5 (Centro)
                  SlideTransition(
                    position: _slideS5,
                    child: ScaleTransition(
                      scale: _scaleS5,
                      child: SvgPicture.asset(
                        'assets/icons/s5.svg',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // Textos de Bienvenida
            FadeTransition(
              opacity: _textOpacity,
              child: SlideTransition(
                position: _textSlide,
                child: Column(
                  children: [
                    Text(
                      'Bienvenido a',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.5,
                          ),
                    ),
                    Text(
                      'CBTIS 66',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: AppTheme.burgundy.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.burgundy.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]),
                      child: Text(
                        'Explora nuestras especialidades',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
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
