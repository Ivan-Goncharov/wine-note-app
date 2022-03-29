import 'package:flutter/material.dart';

class ButtonsInSearch extends StatelessWidget {
  final Function onSave;
  final Function onBack;
  const ButtonsInSearch({
    Key? key,
    required this.onSave,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //кнопка назад
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Назад',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),
            onPressed: () => onBack(),
          ),
        ),

        //кнопка "Сохранить"
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Сохранить',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),

            //по нажатию передаем введенный текст в поле ввода
            onPressed: () => onSave(),
          ),
        )
      ],
    );
  }

  //контейнер для стилизации кнопок
  Widget buttonContainer(
      {required ColorScheme colorScheme,
      required Size size,
      required Widget button}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.primary,
      ),
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: button,
    );
  }
}
