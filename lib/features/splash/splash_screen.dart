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

  // Animaciones independientes para cada pieza
  late Animation<double> _shieldScale;
  late Animation<double> _elementsScale;
  late Animation<Offset> _capDrop;

  // Animación para los textos
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds:
              3000), // Animación un poco más larga para apreciar los detalles
    );

    // 1. El escudo aparece desde cero inflandose con un pequeño rebote
    _shieldScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack)),
    );

    // 2. Los elementos internos hacen un "Pop" elástico desde el centro
    _elementsScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.elasticOut)),
    );

    // 3. El birrete cae desde arriba y rebota al chocar con el escudo
    _capDrop =
        Tween<Offset>(begin: const Offset(0.0, -1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.bounceOut)),
    );

    // Animaciones del texto inferior (Aparece al final)
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeIn)),
    );
    _textSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic)),
    );

    // Iniciar la animación
    _controller.forward();

    // Navegación automática después de 4.5 segundos
    Timer(const Duration(milliseconds: 4500), () {
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
    // Como el logo ya tiene sus propios colores, oscurecemos un poco el fondo
    // para que los blancos, dorados y guindas del logo resalten al 100%.
    return Scaffold(
      backgroundColor:
          const Color(0xFF1A1A1A), // Un gris muy oscuro/casi negro elegante
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenedor fijo para que las piezas compartan la misma proporción
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Capa 1: El Escudo Base (sin colorFilter para mantener colores originales)
                  ScaleTransition(
                    scale: _shieldScale,
                    child: SvgPicture.asset(
                      'assets/icons/logo_pieces_shield.svg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Capa 2: Elementos Internos
                  ScaleTransition(
                    scale: _elementsScale,
                    child: SvgPicture.asset(
                      'assets/icons/logo_pieces_elements.svg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Capa 3: El Birrete
                  SlideTransition(
                    position: _capDrop,
                    child: SvgPicture.asset(
                      'assets/icons/logo_pieces_cap.svg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

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
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.burgundy.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Explora nuestras especialidades',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              letterSpacing: 1.0,
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
