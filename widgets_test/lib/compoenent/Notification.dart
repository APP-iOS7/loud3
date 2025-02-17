import 'package:flutter/material.dart';
import 'package:widgets_test/service/NotiService.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Notiservice().showNotification(
              title: "알림의 제목",
              body: "줄거리입니다",
            );
          },
          child: const Text("알림 전송"),
        ),
      ),
    );
  }
}
