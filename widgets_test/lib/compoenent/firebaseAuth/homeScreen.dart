import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void lougoutMethod() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          ElevatedButton(onPressed: lougoutMethod, child: const Text("로그 아웃")),
    );
  }
}
