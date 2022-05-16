import 'package:flutter/material.dart';

//виджет для вывода одного текстового поля ввода
class TextFieldInput extends StatelessWidget {
  //начальное значение
  final String initialValue;
  //функция для изменения заметки
  final Function changeNote;
  //тип функциональной кнопки на клавиатуре
  final TextInputAction fieldAction;
  //тип клавиатуры
  final TextInputType? keyboardType;
  //заголовок текстового поля
  final String lableText;
  //подсказка ввода
  final String hintText;

  const TextFieldInput({
    Key? key,
    required this.initialValue,
    required this.changeNote,
    required this.fieldAction,
    required this.hintText,
    required this.lableText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //получаем тему для стилизации виджета
    final ThemeData theme = Theme.of(context);

    //оборачиваем в контейнер для определенных размеров и отступов
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.only(
        top: 15,
        left: 16,
        right: 16,
      ),

      //текстовое поле
      child: TextFormField(
          decoration: InputDecoration(
            labelText: lableText,
            hintText: hintText,
            enabledBorder: _inputBorder(theme.colorScheme.onBackground),
            focusedBorder: _inputBorder(theme.colorScheme.primary),
            labelStyle: theme.textTheme.bodyMedium,
            hintStyle: TextStyle(
              color: theme.colorScheme.outline,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          initialValue: initialValue,
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: fieldAction,
          style: theme.textTheme.bodyLarge,

          //сохраняем ввод в переменную name  и пересоздаем объект
          onSaved: (value) {
            changeNote(value);
          }),
    );
  }

  //метод для создания рамки для ввода
  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
