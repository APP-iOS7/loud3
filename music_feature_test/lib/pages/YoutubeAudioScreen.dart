import 'package:flutter/material.dart';
import 'package:music_feature_test/services/DownloadService.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// 이 페이지에서는 videoID를 통해 audio를 stream으로 가져와서 just_audio로 플레이 해보는 테스트 코드

class AudioModel {
  final String title;
  final String author;
  final Duration duration;
  final String thumbnails;
  AudioModel({
    required this.title,
    required this.author,
    required this.duration,
    required this.thumbnails,
  });
}

class YoutubeAudioScreen extends StatefulWidget {
  const YoutubeAudioScreen({super.key});

  @override
  State<YoutubeAudioScreen> createState() => _YoutubeAudioScreenState();
}

class _YoutubeAudioScreenState extends State<YoutubeAudioScreen> {
  bool isPlaying = false;
  AudioModel? audioModel;
  YoutubeExplode? yt;
  AudioOnlyStreamInfo? downloadStream;

  @override
  void initState() {
    super.initState();
    fetchAudioStream(url: 'https://www.youtube.com/watch?v=2A8G_VsQqDI');
    futureAudioLoading();
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

      // 2. 오디오 스트림만 필터링 하기
      var audioStream = manifest.audioOnly.first;
      print('------------------------------------------');
      debugPrint('오디오 URL : ${audioStream.url}', wrapWidth: 1024);
      downloadStream = audioStream;
    } catch (e) {
      print(e);
    }
  }

  Future<AudioModel?> futureAudioLoading() async {
    try {
      var video = await yt!.videos.get(
        'https://www.youtube.com/watch?v=2A8G_VsQqDI',
      );
      setState(() {
        audioModel = AudioModel(
          title: video.title,
          author: video.author,
          thumbnails: video.thumbnails.highResUrl,
          duration: video.duration ?? Duration(seconds: 0),
        );
      });
      return audioModel!;
    } catch (err) {
      print(err);
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    yt!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: audioModel == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Image.network(audioModel!.thumbnails),
                Text(audioModel!.title),
                Text(audioModel!.author),
                Text('${audioModel!.duration}'),
                ElevatedButton(
                  onPressed: () => downloadMethod(
                    url: "https://www.youtube.com/watch?v=2A8G_VsQqDI",
                  ),
                  child: Text("다운로드"),
                ),
              ],
            ),
    );
  }

  // REMARK : 다운로드 함수
  void downloadMethod({required String url}) {
    downloadVideo(url, yt!);
  }
}
