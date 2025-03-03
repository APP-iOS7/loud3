import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_feature_test/listScreen.dart';
import 'package:music_feature_test/model/ListModel.dart';
import 'package:music_feature_test/pages/YoutubeAudioScreen.dart';
import 'package:music_feature_test/pages/YoutubeJustAudio.dart';
import 'package:music_feature_test/pages/YoutubeSearchScreen.dart';
import 'package:music_feature_test/pages/YoutubeVideoScreen.dart';

// data setting
final List<Listmodel> dataSet = [
  Listmodel(
    createdAt: DateTime(2025, 2, 27),
    title: "Youtube 비디오 테스트",
    subTitle: "프로젝트 Video PreView 및 정보",
    route: {'YoutubeViewScreen': (_) => const YoutubeViewScreen()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 27),
    title: "Youtube 비디오 검색 기능",
    subTitle: "youtube 검색 및 정보 가져오기",
    route: {'YoutubeSearchScreen': (_) => const YoutubeSearchScreen()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 27),
    title: "Youtube 오디오 기능",
    subTitle: "youtube 오디오 정보 및 다운로드",
    route: {'YoutubeAudioScreen': (_) => const YoutubeAudioScreen()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 27),
    title: "저장한 audio 파일 실행해보기",
    subTitle: "byte 타입 just_audio 로 실행",
    route: {'YoutubeJustAudio': (_) => const YoutubeJustAudio()},
  ),
];

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ListScreenPage(dataSet: dataSet));
}
