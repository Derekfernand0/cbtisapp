import 'package:flutter/material.dart';
import 'specialty_model.dart';
import 'specialty_detail_screen.dart';
import '../../core/theme/app_theme.dart';
import '../video/video_player_screen.dart';

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Imagen cbtis.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Oferta Educativa',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: AppTheme.white,
                                fontSize: 32,
                              ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VideoPlayerScreen(
                                videoAssetPath: 'assets/videos/intro.mp4',
                                title: 'Video de bienvenida',
                                skipText: 'Cerrar',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                            ),
                          ),
                          child: const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      // --- BOTÓN DE VIDEO INFORMATIVO CON PORTADA ---
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VideoPlayerScreen(
                                  videoAssetPath: 'assets/videos/video2.mp4',
                                  title: 'Video informativo',
                                  skipText: 'Cerrar',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 150, // Altura ajustada para que no estorbe
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                // ⚠️ ASEGÚRATE de que esta imagen exista en tus assets
                                image: AssetImage(
                                    'assets/images/portada_video.png'),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                                    .withOpacity(0.3), // Capa oscura sutil
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Ver video informativo',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        const Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...cbtisSpecialties.map((specialty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecialtyDetailScreen(
                                    specialty: specialty,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: specialty.id,
                              child: Container(
                                height: 180,
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
                      }),
                    ],
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
