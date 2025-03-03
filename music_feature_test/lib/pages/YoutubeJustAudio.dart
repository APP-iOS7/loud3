import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_feature_test/services/DownloadService.dart';

class YoutubeJustAudio extends StatefulWidget {
  const YoutubeJustAudio({super.key});

  @override
  State<YoutubeJustAudio> createState() => _YoutubeJustAudioState();
}

class _YoutubeJustAudioState extends State<YoutubeJustAudio> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: readAudioFile, child: Text("파일 읽기")),
            ElevatedButton(
              onPressed: () => playSoundinFile(audioPlayer),
              child: Text("오디오 재생"),
            ),
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.play();
              },
              child: Text("시작"),
            ),
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.pause();
              },
              child: Text("정지"),
            ),
          ],
        ),
      ),
    );
  }
}
