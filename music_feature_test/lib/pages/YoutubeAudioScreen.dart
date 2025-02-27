import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// 이 페이지에서는 videoID를 통해 audio를 stream으로 가져와서 just_audio로 플레이 해보는 테스트 코드

class YoutubeAudioScreen extends StatefulWidget {
  const YoutubeAudioScreen({super.key});

  @override
  State<YoutubeAudioScreen> createState() => _YoutubeAudioScreenState();
}

class _YoutubeAudioScreenState extends State<YoutubeAudioScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  YoutubeExplode? yt;
  @override
  void initState() {
    super.initState();
    fetchAudioStream(url: 'https://www.youtube.com/watch?v=2A8G_VsQqDI');
  }

  Future<void> fetchAudioStream({required String url}) async {
    yt = YoutubeExplode();
    try {
      // 1. 영상 정보 가져오기
      final manifest = await yt!.videos.streams.getManifest(
        VideoId(url),
        // You can also pass a list of preferred clients, otherwise the library will handle it:
        ytClients: [YoutubeApiClient.ios, YoutubeApiClient.androidVr],
      );

      // 2. 오디오 스트림만 필터링 하기 (높은 음질)
      var audioStream = manifest.audioOnly.first;
      print('------------------------------------------');
      debugPrint('오디오 URL : ${audioStream.url}', wrapWidth: 1024);
      await audioPlayer.setUrl(audioStream.url.toString(), preload: false);
      await audioPlayer.play(); // 시작
      print("실행이 되었음");
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    yt!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("hello world")));
  }
}
