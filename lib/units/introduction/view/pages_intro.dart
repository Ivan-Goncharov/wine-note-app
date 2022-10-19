import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_my_wine_app/units/introduction/listeners/pages_intro_listener.dart';
import 'package:provider/provider.dart';

//виджет для одного интро экрана
class PagesIntro extends StatelessWidget {
  //анимационный виджет
  final Widget lottieAnimation;
  //заголовок
  final String title;
  //описание
  final String subtitle;
  const PagesIntro({
    required this.lottieAnimation,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF6750A4),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //выводим анимацию
          Expanded(child: lottieAnimation),

          //заголовок
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //описание
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),

          //кнопка переход на главный экран приложения
          GestureDetector(
            onTap: () async {
              await context.read<PagesIntroListener>().saveFirstLaunchApp();
              Navigator.pushReplacementNamed(context, tabsScreenRoute);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 85, top: 60),
              alignment: Alignment.center,
              child: const Text(
                'Начать',
                style: TextStyle(
                    color: Color(0xFF21005D),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              width: size.width * 0.5,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xFFEADDFF),
              ),
            ),
          )
        ],
      ),
    );
  }
}
