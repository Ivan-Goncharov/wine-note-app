import 'package:flutter/material.dart';

//виджет для стилизации кнопок - перехода на экраны ввода региона/страны и т.д
class ButtonContainer extends StatelessWidget {
  final Widget child;
  const ButtonContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      margin: const EdgeInsets.only(top: 15, left: 16, right: 16),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      child: child,
    );
  }
}
