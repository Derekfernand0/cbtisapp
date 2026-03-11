// lib/features/home/main_screen.dart
import 'package:flutter/material.dart';
import '../specialties/specialties_screen.dart';
import '../info/info_screen.dart';
import '../test/test_screen.dart';
import '../requirements/requirements_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  // Agregamos el PageController para manejar el scroll horizontal
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // Es muy importante liberar el controlador de la memoria
    _pageController.dispose();
    super.dispose();
  }

  // Nuestras pantallas
  final List<Widget> _screens = [
    const SpecialtiesScreen(),
    const InfoScreen(),
    const TestScreen(),
    const RequirementsScreen(),
  ];

  // Se ejecuta cuando el usuario desliza la pantalla con el dedo
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Se ejecuta cuando el usuario toca un icono de la barra inferior
  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Reemplazamos el PageTransitionSwitcher por el PageView
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        // BouncingScrollPhysics le da ese efecto de rebote elástico al llegar a los bordes
        physics: const BouncingScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
