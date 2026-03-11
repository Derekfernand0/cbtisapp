// lib/features/specialties/specialties_screen.dart
import 'package:flutter/material.dart';
import 'specialty_model.dart';
import 'specialty_detail_screen.dart';
import '../../core/theme/app_theme.dart';

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo del CBTIS
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Imagen cbtis.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            // Capa oscura para que las tarjetas resalten y se lea bien
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Lista vertical de especialidades
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Oferta Educativa',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppTheme.white,
                          fontSize: 32,
                        ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: cbtisSpecialties.length,
                    itemBuilder: (context, index) {
                      final specialty = cbtisSpecialties[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            // Navegación a los detalles al tocar la imagen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpecialtyDetailScreen(
                                  specialty: specialty,
                                ),
                              ),
                            );
                          },
                          // El mismo Hero tag enlaza la imagen de aquí con la del detalle
                          child: Hero(
                            tag: specialty.id,
                            child: Container(
                              height: 180, // Imágenes grandes
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(specialty.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(20),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.8),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  specialty.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
