import 'package:flutter/material.dart';
import 'video_player_screen.dart';

class IntroVideoScreen extends StatelessWidget {
  const IntroVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoPlayerScreen(
      videoAssetPath: 'assets/videos/intro.mp4',
      title: 'Bienvenido a CBTIS App',
      skipText: 'Entrar',
    );
  }
}