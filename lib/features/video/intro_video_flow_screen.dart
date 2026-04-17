import 'package:flutter/material.dart';
import '../home/main_screen.dart';
import 'video_player_screen.dart';

class IntroVideoFlowScreen extends StatelessWidget {
  const IntroVideoFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VideoPlayerScreen(
      videoAssetPath: 'assets/videos/intro.mp4',
      title: 'Bienvenido a CBTIS 66',
      skipText: 'Entrar',
      onFinish: () {
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(),
          ),
        );
      },
    );
  }
}