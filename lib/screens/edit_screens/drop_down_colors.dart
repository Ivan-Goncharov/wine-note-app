import 'package:flutter/material.dart';

import '../../models/wine_item.dart';

//выпадающий список выбора цвета винограда
class DropDownColor extends StatelessWidget {
  //начальное значение цвета
  final String wineColor;
  //функция для сохранения выбранного цвета
  final Function saveColor;

  const DropDownColor(
      {Key? key, required this.wineColor, required this.saveColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.only(
        top: 15,
        left: 25,
        right: 25,
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Цвет',
          hintText: "Укажите цвет винограда",
          enabledBorder: _inputBorder(theme.colorScheme.onBackground),
          focusedBorder: _inputBorder(theme.colorScheme.primary),
          labelStyle: theme.textTheme.bodyMedium,
          hintStyle: TextStyle(
            color: theme.colorScheme.outline,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),

        //устанавливаем значение выбранного элемента
        value: wineColor.isEmpty ? null : wineColor,
        style: theme.textTheme.bodyLarge,

        //сохраняем выбор
        onChanged: (value) {
          saveColor(value);
        },
        items: WineItem.colorDopdownItems,
      ),
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
