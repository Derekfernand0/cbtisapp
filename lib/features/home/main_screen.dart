import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

// Importaremos los placeholders (asegúrate de crear archivos vacíos básicos para estos o usa Containers por ahora)
// import '../specialties/specialties_screen.dart';
// import '../info/info_screen.dart';
// import '../test/test_screen.dart';
// import '../requirements/requirements_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de las 4 pantallas principales
  final List<Widget> _screens = [
    const Center(
        child: Text(
            "Pantalla 1: Especialidades (En construcción)")), // EspecialidadesScreen()
    const Center(
        child: Text(
            "Pantalla 2: Info CBTIS 66 (En construcción)")), // InfoScreen()
    const Center(
        child: Text(
            "Pantalla 3: Test Vocacional (En construcción)")), // TestScreen()
    const Center(
        child: Text(
            "Pantalla 4: Requisitos (En construcción)")), // RequirementsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageTransitionSwitcher de la librería animations para cambios suaves
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Especialidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'CBTIS 66',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Requisitos',
          ),
        ],
      ),
    );
  }
}
