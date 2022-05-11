import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'pages_intro.dart';

class IntroductionScreen extends StatefulWidget {
  static const routName = './introScreen';
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      }
      _controller.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/monitoring.json',
                ),
                title: 'Создание заметок',
                subtitle: 'Создавайте заметки для любимых вин',
              ),
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/notes_navigation.json',
                ),
                title: 'Навигация по винам',
                subtitle:
                    'Удобно перемещайтесь по самым разным разделам с винами',
              ),
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/search_notes.json',
                ),
                title: 'Поиск заметок',
                subtitle: 'Быстрый поиск по вашему собранию вин',
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
            ),
          ),
        ],
      ),
    );
  }
}
