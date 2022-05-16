//виджет заголовка одного раздела
//по тапу на заголовок, открываются поля ввода
import 'package:flutter/material.dart';

class ItemChapterEdit extends StatefulWidget {
  //заголовок
  final String title;
  //функция  открытия списка
  final Function changeVisible;
  const ItemChapterEdit(
      {Key? key, required this.title, required this.changeVisible})
      : super(key: key);

  @override
  State<ItemChapterEdit> createState() => _ItemChapterEditState();
}

class _ItemChapterEditState extends State<ItemChapterEdit> {
  //переменная для отслеживания, открыт ли сейчас список
  bool _isOpen = false;
  //цветовая схема
  late ColorScheme _colors;

  @override
  void didChangeDependencies() {
    //инициализируем цвет
    _colors = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //по нажатию меняем переменную отслеживания состояния на противоположное значение
        setState(() => _isOpen = !_isOpen);
        //вызываем функцию открытия скрытого списка
        widget.changeVisible();
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        color: _colors.surface,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: _isOpen ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 20,
                  color:
                      _isOpen ? _colors.onPrimaryContainer : _colors.onSurface,
                ),
              ),
            ),
            Icon(
              _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 30,
              color: _isOpen ? _colors.onPrimaryContainer : _colors.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
