import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/Notification.dart';
import 'package:widgets_test/compoenent/dopeScreen.dart';
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
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 17),
    title: "Notification 기능 테스트",
    subTitle: "로컬의 알림 설정 및 기능",
    route: {'NotificationScreen': (_) => const NotificationScreen()},
  ),
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Notiservice().initNotification();
  runApp(ListScreenPage(dataSet: dataSet));
}
