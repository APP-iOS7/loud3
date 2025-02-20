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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return showLoginPage
              ? LoginAuthPage(onTap: toggleShowPage)
              : RegisterAuthPage(onTap: toggleShowPage);
        },
      ),
    );
  }
}
