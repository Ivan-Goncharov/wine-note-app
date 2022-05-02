import 'package:flutter/material.dart';

//виджет двух кнопок, который вызывается, если подсказка по вводу не помогла пользователю
class ButtonsInSearch extends StatelessWidget {
  //информация, которую надо передать на предыдущий экран
  final dynamic saveInfo;
  const ButtonsInSearch({
    Key? key,
    required this.saveInfo,
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
            onPressed: () => Navigator.pop(context),
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
            onPressed: () => Navigator.pop(context, [saveInfo]),
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
