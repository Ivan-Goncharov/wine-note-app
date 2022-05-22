import 'package:flutter/material.dart';

//виджет двух кнопок, который вызывается, если подсказка по вводу не помогла пользователю
class ButtonsInSearch extends StatelessWidget {
  //информация, которую надо передать на предыдущий экран
  final dynamic saveInfo;
  final String? leftButtonTitle;
  final String? rightButtonTitle;
  final Function? leftButtonFunc;
  final Function? rightButtonFunc;
  const ButtonsInSearch({
    Key? key,
    required this.saveInfo,
    this.leftButtonTitle,
    this.rightButtonTitle,
    this.leftButtonFunc,
    this.rightButtonFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //кнопка назад
        ButtonContainer(
          button: TextButton(
              child: Text(
                leftButtonTitle ?? 'Назад',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: leftButtonTitle == null ? 18 : 16,
                ),
              ),
              onPressed: () {
                leftButtonFunc != null
                    ? leftButtonFunc!()
                    : Navigator.pop(context);
              }),
        ),

        //кнопка "Сохранить"
        ButtonContainer(
          button: TextButton(
              child: Text(
                rightButtonTitle ?? 'Сохранить',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                ),
              ),

              //по нажатию передаем введенный текст в поле ввода
              onPressed: () {
                rightButtonFunc != null
                    ? rightButtonFunc!()
                    : Navigator.pop(context, saveInfo);
              }),
        )
      ],
    );
  }
}

//контейнер для стилизации кнопок
class ButtonContainer extends StatelessWidget {
  final Widget button;
  const ButtonContainer({Key? key, required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.08,
      alignment: Alignment.center,
      child: button,
    );
  }
}
