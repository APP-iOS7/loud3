import 'package:flutter/material.dart';
import 'package:music_feature_test/listScreen.dart';
import 'package:music_feature_test/model/ListModel.dart';
import 'package:music_feature_test/pages/YoutubeAudioScreen.dart';
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
    subTitle: "youtube 오디오 및 정보 가져오기",
    route: {'YoutubeAudioScreen': (_) => const YoutubeAudioScreen()},
  ),
];

void main() async {
  runApp(ListScreenPage(dataSet: dataSet));
}
