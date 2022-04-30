import 'dart:ui';

import 'package:flutter/material.dart';

//виджет для нижнего экрана сортировки вина
class NoteSorting extends StatefulWidget {
  //принимаем тип сортировки, который выбран на данный момент
  //и функцию для изменения типа сортировки
  final TypeOfSotring currentType;
  final Function sortNotes;
  const NoteSorting({
    Key? key,
    required this.currentType,
    required this.sortNotes,
  }) : super(key: key);

  @override
  State<NoteSorting> createState() => _NoteSortingState();
}

class _NoteSortingState extends State<NoteSorting> {
  late ColorScheme _colors;
  //текущее значение сортировки
  late TypeOfSotring _currentType;

  //переменная для отслеживания инициализации
  bool _isInit = false;

  //инициализируем данные
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _colors = Theme.of(context).colorScheme;
      _currentType = widget.currentType;
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colors.surfaceVariant,
      ),

      //выводим все доступные методы сортировки
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //алфавит
          createItemType(
            'По алфавиту',
            TypeOfSotring.alphabet,
          ),
          const Divider(height: 3),

          //дата создания
          createItemType(
            'По дате создания',
            TypeOfSotring.creationDate,
          ),
          const Divider(height: 3),

          //год урожая
          createItemType(
            'По году урожая',
            TypeOfSotring.grapeYear,
          ),
          const Divider(height: 3),

          //кнокпа 'назад'
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Отмена',
                style: TextStyle(
                  color: _colors.tertiary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createItemType(String name, TypeOfSotring type) {
    return GestureDetector(
      //обработка нажатия на текст
      onTap: () {
        // если данный фильтр уже выбран, то снимаем фильтр и возвращаемся на экран
        if (_currentType == type) {
          setState(() {
            _currentType = TypeOfSotring.none;
            widget.sortNotes(_currentType);
          });
        }

        //если фильтр еще не выбран, то применяем фильтр и возвращаемся на экран
        else {
          setState(() {
            _currentType = type;
            widget.sortNotes(_currentType);
          });
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: TextStyle(
            color: _currentType == type
                ? _colors.primary
                : _colors.onSurfaceVariant,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//список констант для фильтрации
enum TypeOfSotring {
  creationDate,
  grapeYear,
  alphabet,
  none,
}
