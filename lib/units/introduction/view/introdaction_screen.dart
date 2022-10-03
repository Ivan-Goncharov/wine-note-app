import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/string_resources.dart';
import 'package:flutter_my_wine_app/units/introduction/listeners/pages_intro_listener.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'pages_intro.dart';

//интро экран для первого запуска приложения
class IntroductionScreen extends StatelessWidget {
  static const routName = './introScreen';
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PagesIntroListener()..init(),
      child: const _IntroductionScreenBody(),
    );
  }
}

class _IntroductionScreenBody extends StatelessWidget {
  const _IntroductionScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: context.read<PagesIntroListener>().controller,
            children: [
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/monitoring.json',
                ),
                title: SResources.introCreateNotesTitle,
                subtitle: SResources.introCreateNotesSub,
              ),
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/notes_navigation.json',
                ),
                title: SResources.introNavigateTitle,
                subtitle: SResources.introCreateNotesSub,
              ),
              PagesIntro(
                lottieAnimation: Lottie.asset(
                  'assets/animation_lottie/search_notes.json',
                ),
                title: SResources.introSearchTitle,
                subtitle:  SResources.introSearchSub,
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: context.read<PagesIntroListener>().controller,
              count: 3,
            ),
          ),
        ],
      ),
    );
  }
}
