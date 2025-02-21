import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/supabaseAuth/homeScreen.dart';
import 'package:widgets_test/compoenent/supabaseAuth/loginAuth.dart';
import 'package:widgets_test/compoenent/supabaseAuth/registerAuth.dart';

class SupabaseAuthPage extends StatefulWidget {
  const SupabaseAuthPage({super.key});

  @override
  State<SupabaseAuthPage> createState() => _SupabaseAuthPageState();
}

class _SupabaseAuthPageState extends State<SupabaseAuthPage> {
  bool showLoginPage = true; // 로그인

  void toggleShowPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: null,
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
