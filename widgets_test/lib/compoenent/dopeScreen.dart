import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DopeScreen extends StatefulWidget {
  const DopeScreen({super.key});

  @override
  State<DopeScreen> createState() => _DopeScreenState();
}

class _DopeScreenState extends State<DopeScreen> {
  bool isScrollEnd = false;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int value) {
              setState(() {
                isScrollEnd = (value == 2);
              });
            },
            children: [
              _firstPage(),
              _secondPage(),
              _thirdPage(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _pageController.jumpToPage(2),
                  child: const Text("건너뛰기"),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.white.withOpacity(0.5),
                    activeDotColor: Colors.white,
                  ),
                ),
                isScrollEnd
                    ? GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          "ListScreenPage",
                          (_) => false,
                        ),
                        child: const Text("이동"),
                      )
                    : GestureDetector(
                        onTap: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        ),
                        child: const Text("다음"),
                      ),
              ],
            ),
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
