import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/TestScreen.dart';
import 'package:widgets_test/compoenent/dopeScreen.dart';
import 'package:widgets_test/listScreen.dart';
import 'package:widgets_test/model/ListModel.dart';

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
    title: "Test 스크린",
    subTitle: "test 페이지 PageView",
    route: {'TestScreen': (_) => const TestScreen()},
  ),
];

void main() {
  runApp(
    ListScreenPage(
      dataSet: dataSet,
    ),
  );
}
