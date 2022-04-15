import 'package:flutter/material.dart';

//поле для ввода текста пользователем
//приимает текст подсказки, контроллер для работы
//также некоторые экраны передают иконку префикс и focus
class CustomTextField extends StatelessWidget {
  final String textHint;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;

  //эти данные передают экран, для того,
  //чтобы вернуться не на предыдущую страницу, а изменить поведение текущей
  final Function? function;
  final bool isBack;
  const CustomTextField(
      {Key? key,
      required this.textHint,
      this.prefixIcon,
      this.focusNode,
      this.function,
      required this.isBack,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        //поле ввода текста для поиска
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 15),
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: textHint,
                prefixIcon: prefixIcon,

                //кнопка удаления написанного текста
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_outlined),
                  onPressed: () {
                    controller.clear();
                  },
                ),
              ),
              controller: controller,
              autofocus: true,
              focusNode: focusNode,
            ),
          ),
        ),

        //кнопка для возврата на предыдущий экран
        TextButton(
          onPressed: () {
            if (isBack) {
              Navigator.pop(context);
            } else {
              function!();
            }
          },
          child: Text(
            'Отменить',
            style: TextStyle(
              fontSize: 15,
              color: _colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
