import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/firebaseAuth/loginAuth.dart';

class RegisterAuthPage extends StatefulWidget {
  const RegisterAuthPage({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  State<RegisterAuthPage> createState() => _RegisterAuthPage();
}

class _RegisterAuthPage extends State<RegisterAuthPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Icon(Icons.lock, size: 80),
                    const SizedBox(height: 40),
                    const Text(
                      "Firebase 회원가입을 해봐요!!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _CustomTextField(
                      userIdController: userIdController,
                      obscureText: false,
                      hintText: "이메일을 입력해주세요",
                    ),
                    const SizedBox(height: 10),
                    _CustomTextField(
                      userIdController: passwordController,
                      obscureText: true,
                      hintText: "비밀번호를 입력해주세요",
                    ),
                    _CustomTextField(
                      userIdController: passwordController,
                      obscureText: true,
                      hintText: "비밀번호 확인을 위해 입력해주세요",
                    ),
                    const SizedBox(height: 20),
                    _CustomButton(
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _customNavigation(
                      onTap: widget.onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// 로그인 이동 또는 회원가임
class _customNavigation extends StatelessWidget {
  const _customNavigation({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "이미 있다면!",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "로그인",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// 로그인 또는 회원가입 버튼
class _CustomButton extends StatelessWidget {
  const _CustomButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: const Text(
        '로그인',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// Custom TextField
class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    super.key,
    required this.userIdController,
    required this.obscureText,
    required this.hintText,
  });

  final TextEditingController userIdController;
  final bool obscureText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: userIdController,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
