import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/firebaseAuth/homeScreen.dart';
import 'package:widgets_test/compoenent/firebaseAuth/loginAuth.dart';
import 'package:widgets_test/compoenent/firebaseAuth/registerAuth.dart';
import 'package:widgets_test/listScreen.dart';

class FireBaseAuthPage extends StatefulWidget {
  const FireBaseAuthPage({super.key});

  @override
  State<FireBaseAuthPage> createState() => _FireBaseAuthPageState();
}

class _FireBaseAuthPageState extends State<FireBaseAuthPage> {
  bool showLoginPage = true; // 로그인

  void toggleShowPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return const HomeScreen();
          } else {
            return showLoginPage
                ? LoginAuthPage(onTap: toggleShowPage)
                : RegisterAuthPage(onTap: toggleShowPage);
          }
        },
      ),
    );
  }
}


// 회고 음 로그인과 회원가입을 분리해서 페이지간 이동이 자연스럽고 다 좋지만 
// firebase는 로그인 및 회원가입이 성공하면 둘 다 User의 상태를 변화 시키고 homeScreen으로 가게 됨...
// 이것 빼고는 ErrorException이 잘 되어있어서 e.code를 통해 각각의 에러를 분리 할 수 있단 점이 좋았습니다.