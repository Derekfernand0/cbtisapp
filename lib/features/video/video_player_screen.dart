import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoAssetPath;
  final String title;
  final VoidCallback? onFinish;
  final bool allowSkip;
  final String? skipText;

  const VideoPlayerScreen({
    super.key,
    required this.videoAssetPath,
    required this.title,
    this.onFinish,
    this.allowSkip = true,
    this.skipText,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isReady = false;
  bool _handledFinish = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        if (!mounted) return;

        _controller.addListener(_videoListener);
        _controller.play();

        setState(() {
          _isReady = true;
        });
      });
  }

  void _videoListener() {
    if (!_controller.value.isInitialized || _handledFinish) return;

    final position = _controller.value.position;
    final duration = _controller.value.duration;

    if (duration.inMilliseconds > 0 &&
        position.inMilliseconds >= duration.inMilliseconds - 300) {
      _handledFinish = true;

      if (widget.onFinish != null) {
        widget.onFinish!();
      } else if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    if (_isReady) {
      _controller.removeListener(_videoListener);
    }
    _controller.dispose();
    super.dispose();
  }

  void _skip() {
    if (_handledFinish) return;
    _handledFinish = true;

    if (widget.onFinish != null) {
      widget.onFinish!();
    } else if (mounted && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _isReady
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
            if (widget.allowSkip)
              Positioned(
                top: 12,
                right: 12,
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.45),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(widget.skipText ?? 'Cerrar'),
                ),
              ),
            if (_isReady)
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        _controller.seekTo(Duration.zero);
                        _controller.play();
                      },
                      icon: const Icon(
                        Icons.replay_circle_filled,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}