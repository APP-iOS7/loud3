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

// 회고 
// 알림 설정이 13버젼부터 권한 요청이 따로 없음 그러므로 권한을 직접 주면 됨... ㅠ ㅠ ㅠ