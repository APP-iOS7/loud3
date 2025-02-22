import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      body: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final session = snapshot.hasData ? snapshot.data!.session : null;
          print('session : $session');
          if (session != null) {
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
