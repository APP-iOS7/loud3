import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/DropAndDown.dart';
import 'package:widgets_test/compoenent/FireBaseCloud.dart';
import 'package:widgets_test/compoenent/Notification.dart';
import 'package:widgets_test/compoenent/dopeScreen.dart';
import 'package:widgets_test/compoenent/FutureBuilderView.dart';
import 'package:widgets_test/listScreen.dart';
import 'package:widgets_test/model/ListModel.dart';
import 'package:widgets_test/service/NotiService.dart';

// data setting
final List<Listmodel> dataSet = [
  Listmodel(
    createdAt: DateTime(2025, 2, 16),
    title: "Dope 스크린",
    subTitle: "소개 페이지 PageView",
    route: {'DopeScreen': (_) => const DopeScreen()},
    imagePath: "assets/images/dopeImage.webp",
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 17),
    title: "Notification 기능 테스트",
    subTitle: "로컬의 알림 설정 및 기능",
    route: {'NotificationScreen': (_) => const NotificationScreen()},
    imagePath: "assets/images/notificationImage.png",
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 17),
    title: "Drop & Down",
    subTitle: "드롭다운 메뉴 테스트",
    route: {'DropAndDownScreen': (_) => const DropAndDownScreen()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 18),
    title: "API 수신 Test",
    subTitle: "Json 데이터 받아와서 view 전환",
    route: {'FutureBuilderView': (_) => const FutureBuilderView()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 20),
    title: "Firebase 테스트",
    subTitle: "firestore에 doc 업데이트",
    route: {'FireBaseCloud': (_) => const FireBaseCloud()},
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Notiservice().initNotification();
  runApp(ListScreenPage(dataSet: dataSet));
}
