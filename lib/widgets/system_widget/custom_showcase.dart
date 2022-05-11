import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

//кастомный showcase
//создает подсказки при первом запуске приложения
class CustomShowCaseWidget extends StatelessWidget {
  //принимаем виджет , который будет подсвечиваться
  final Widget widget;
  //ключ для вывода
  final GlobalKey<State<StatefulWidget>> showCaseKey;
  // описание виджета
  final String widgetDescription;
  const CustomShowCaseWidget(
      {Key? key,
      required this.widget,
      required this.showCaseKey,
      required this.widgetDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showCaseKey,
      radius: BorderRadius.circular(12),
      showcaseBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      descTextStyle: TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
      ),
      overlayPadding: const EdgeInsets.all(6.0),
      description: widgetDescription,
      child: widget,
    );
  }
}
