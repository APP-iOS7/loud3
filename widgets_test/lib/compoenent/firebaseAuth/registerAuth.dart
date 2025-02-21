import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widgets_test/compoenent/firebaseAuth/passwordMismatch.dart';

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
  final TextEditingController confirmController = TextEditingController();
  String? userIdErrorMessage;
  String? passwordErrorMessage;
  String? confirmErrorMessage;

  // loading 뷰
  Future<void> loadingState() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  // 회원가입 함수
  void registerMethod() async {
    try {
      initializeErrorText();
      loadingState();
      if (passwordController.text != confirmController.text) {
        // 다르면 Error
        throw PasswordMismatchException(
            code: 'passwordMismatch', message: "비밀번호가 서로 다릅니다");
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userIdController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        userIdErrorMessage = '이메일 형식을 입력해주세요';
      } else if (e.code == 'weak-password') {
        passwordErrorMessage = '최소 6자리를 입력해주세요';
      } else if (e.code == 'email-already-in-use') {
        userIdErrorMessage = '이미 존재하는 이메일 입니다';
      }
    } on PasswordMismatchException catch (e) {
      confirmErrorMessage = e.toString();
    }
    Navigator.of(context).pop();
    setState(() {});
  }

  // 사용한 ErrorText를 초기화 합니다
  void initializeErrorText() {
    userIdErrorMessage = null;
    passwordErrorMessage = null;
    confirmErrorMessage = null;
    setState(() {});
  }

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
                      controller: userIdController,
                      obscureText: false,
                      hintText: "이메일을 입력해주세요",
                      errorText: userIdErrorMessage,
                    ),
                    const SizedBox(height: 10),
                    _CustomTextField(
                      controller: passwordController,
                      obscureText: true,
                      hintText: "비밀번호를 입력해주세요",
                      errorText: passwordErrorMessage,
                    ),
                    const SizedBox(height: 10),
                    _CustomTextField(
                      controller: confirmController,
                      obscureText: true,
                      hintText: "비밀번호 확인을 위해 입력해주세요",
                      errorText: confirmErrorMessage,
                    ),
                    const SizedBox(height: 20),
                    _CustomButton(
                      onTap: registerMethod,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Text(
          '회원가입',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Custom TextField
class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
    required this.errorText,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        filled: true,
        errorText: errorText,
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
