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

  // Animaciones para la fusión de las piezas
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimationShield;
  late Animation<Offset> _slideAnimationCap;
  late Animation<Offset> _slideAnimationElements;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 2500), // Duración total de la fusión
    );

    // 1. Escala y Opacidad base para la aparición suave
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );

    // 2. Deslizamiento de las piezas principales para la "fusión"
    // El escudo central se desliza ligeramente hacia arriba
    _slideAnimationShield =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.8, curve: Curves.easeInOutCubic)),
    );

    // El birrete baja desde arriba
    _slideAnimationCap =
        Tween<Offset>(begin: const Offset(0.0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 0.9, curve: Curves.easeInOutCubic)),
    );

    // Los elementos internos (libro, manos, etc.) convergen desde los lados
    _slideAnimationElements =
        Tween<Offset>(begin: const Offset(0.3, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubic)),
    );

    // Iniciar la animación
    _controller.forward();

    // Navegación automática después de que la fusión termina y se mantiene un momento
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
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Contenedor del logo con animaciones de fusión
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Capa 1: El Escudo Base (se fusiona desde abajo)
                    SlideTransition(
                      position: _slideAnimationShield,
                      child: SvgPicture.asset(
                        'assets/icons/logo_pieces_shield.svg', // Reemplaza con tu SVG vectorizado
                        height: 180,
                        colorFilter: const ColorFilter.mode(
                            AppTheme.white, BlendMode.srcIn),
                      ),
                    ),

                    // Capa 2: El Birrete (baja desde arriba)
                    SlideTransition(
                      position: _slideAnimationCap,
                      child: SvgPicture.asset(
                        'assets/icons/logo_pieces_cap.svg', // Reemplaza con tu SVG vectorizado
                        height: 180,
                        colorFilter: const ColorFilter.mode(
                            AppTheme.white, BlendMode.srcIn),
                      ),
                    ),

                    // Capa 3: Elementos Internos (convergen desde los lados)
                    SlideTransition(
                      position: _slideAnimationElements,
                      child: SvgPicture.asset(
                        'assets/icons/logo_pieces_elements.svg', // Reemplaza con tu SVG vectorizado
                        height: 180,
                        colorFilter: const ColorFilter.mode(
                            AppTheme.white, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Texto de bienvenida animado
                _buildAnimatedText(
                  'Bienvenido a',
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.5,
                      ),
                  startInterval: 0.6,
                ),
                _buildAnimatedText(
                  'CBTIS 66',
                  Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppTheme.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                  startInterval: 0.7,
                ),
                const SizedBox(height: 10),
                _buildAnimatedText(
                  'Explora nuestras especialidades',
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.white.withOpacity(0.8),
                        letterSpacing: 1.2,
                      ),
                  startInterval: 0.8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para animar la aparición del texto en cascada
  Widget _buildAnimatedText(String text, TextStyle? style,
      {required double startInterval}) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            Interval(startInterval, startInterval + 0.2, curve: Curves.easeIn),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
            .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(startInterval, startInterval + 0.2,
                curve: Curves.easeOutCubic),
          ),
        ),
        child: Text(text, style: style),
      ),
    );
  }
}
