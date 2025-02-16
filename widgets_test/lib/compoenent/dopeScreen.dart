import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DopeScreen extends StatefulWidget {
  const DopeScreen({super.key});

  @override
  State<DopeScreen> createState() => _DopeScreenState();
}

class _DopeScreenState extends State<DopeScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _firstPage(),
              _secondPage(),
              _thirdPage(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(controller: _pageController, count: 3),
          )
        ],
      ),
    );
  }

  // 첫번째 스크롤 페이지
  Container _firstPage() {
    return Container(
      width: double.infinity,
      color: Colors.blue,
    );
  }

  // 두번째 스크롤 페이지
  Container _secondPage() {
    return Container(
      width: double.infinity,
      color: Colors.yellow,
    );
  }

  // 세번째 스크롤 페이지
  Container _thirdPage() {
    return Container(
      width: double.infinity,
      color: Colors.green,
    );
  }
}
