import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widgets_test/compoenent/DropAndDown.dart';
import 'package:widgets_test/compoenent/FireBaseAuthPage.dart';
import 'package:widgets_test/compoenent/Notification.dart';
import 'package:widgets_test/compoenent/SupabaseAuthPage.dart';
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
    title: "Firebase Auth",
    subTitle: "firebase 로그인 & 회원가입",
    route: {'FireBaseAuthPage': (_) => const FireBaseAuthPage()},
  ),
  Listmodel(
    createdAt: DateTime(2025, 2, 21),
    title: "Supabase Auth",
    subTitle: "Supabase 로그인 & 회원가입",
    route: {'SupabaseAuthPage': (_) => const SupabaseAuthPage()},
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  String supaProjectURL = 'https://zkxbduvlkjbyhmardefo.supabase.co';
  String supaApiKey = dotenv.get("SUPABASE_APIKEY");
  await Firebase.initializeApp();
  await Supabase.initialize(url: supaProjectURL, anonKey: supaApiKey);

  Notiservice().initNotification();
  runApp(ListScreenPage(dataSet: dataSet));
}
