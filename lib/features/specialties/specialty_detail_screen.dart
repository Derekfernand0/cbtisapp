// lib/features/specialties/specialty_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_theme.dart';
import 'specialty_model.dart';

class SpecialtyDetailScreen extends StatefulWidget {
  final Specialty specialty;

  const SpecialtyDetailScreen({super.key, required this.specialty});

  @override
  State<SpecialtyDetailScreen> createState() => _SpecialtyDetailScreenState();
}

class _SpecialtyDetailScreenState extends State<SpecialtyDetailScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.specialty.videoUrl)
      ..initialize().then((_) {
        // Asegura que el primer frame se muestre cuando el video esté inicializado
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(widget.specialty.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Animación Hero: La imagen se reduce a "foto de perfil"
            Center(
              child: Hero(
                tag: widget.specialty.id,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(widget.specialty.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Cuadro de información
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  widget.specialty.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- NUEVO REPRODUCTOR LOCAL ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(_videoController),
                            // Pasamos la imagen de la especialidad para que sirva de portada
                            _ControlsOverlay(
                              controller: _videoController,
                              coverImagePath: widget.specialty.imagePath,
                            ),
                            VideoProgressIndicator(
                              _videoController,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: AppTheme.burgundy,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.black12,
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.burgundy),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Control táctil para pausar/reproducir
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({
    required this.controller,
    required this.coverImagePath, // Recibimos la ruta de la portada
  });

  final VideoPlayerController controller;
  final String coverImagePath;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        // Solo mostramos la portada si el video NO se está reproduciendo
        // y está exactamente en el inicio (posición 0)
        bool isAtBeginning =
            !value.isPlaying && value.position == Duration.zero;

        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // 1. La Portada del video
            if (isAtBeginning)
              Image.asset(
                coverImagePath,
                fit: BoxFit.cover,
              ),

            // 2. El cuadro oscuro y el botón de Play que desaparecen al reproducir
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: value.isPlaying
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.black45,
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 70.0,
                        ),
                      ),
                    ),
            ),

            // 3. El detector de toques
            GestureDetector(
              onTap: () {
                value.isPlaying ? controller.pause() : controller.play();
              },
            ),
          ],
        );
      },
    );
  }
}
