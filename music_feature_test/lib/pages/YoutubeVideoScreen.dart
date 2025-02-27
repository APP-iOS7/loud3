import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeViewScreen extends StatefulWidget {
  const YoutubeViewScreen({super.key});

  @override
  State<YoutubeViewScreen> createState() => _YoutubeViewScreenState();
}

class _YoutubeViewScreenState extends State<YoutubeViewScreen> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'nvqj4yPSt0g',
    flags: YoutubePlayerFlags(autoPlay: true, mute: false),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
          progressIndicatorColor: Colors.blue,
          onReady: () {
            _controller.addListener(listener);
          },
        ),
      ),
    );
  }

  void listener() {}
}
