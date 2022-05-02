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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),

      //выводим все доступные методы сортировки
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //алфавит
          ItemSortTypeWidget(
            name: 'По алфавиту',
            type: TypeOfSotring.alphabet,
            currentType: widget.currentType,
            sortedNotes: widget.sortNotes,
          ),
          const Divider(height: 3),

          //дата создания
          ItemSortTypeWidget(
            name: 'По дате создания',
            type: TypeOfSotring.creationDate,
            currentType: widget.currentType,
            sortedNotes: widget.sortNotes,
          ),
          const Divider(height: 3),

          //год урожая
          ItemSortTypeWidget(
            name: 'По году урожая',
            type: TypeOfSotring.grapeYear,
            currentType: widget.currentType,
            sortedNotes: widget.sortNotes,
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
                  color: Theme.of(context).colorScheme.tertiary,
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
}

//список констант для фильтрации
enum TypeOfSotring {
  creationDate,
  grapeYear,
  alphabet,
  none,
}

//виджет для вывода одного типа сортировки
// ignore: must_be_immutable
class ItemSortTypeWidget extends StatefulWidget {
  //название сортировки
  final String name;
  //тип сортировки
  final TypeOfSotring type;
  //выбранный тип сортировки
  TypeOfSotring currentType;
  //функция для сортировки
  final Function sortedNotes;

  ItemSortTypeWidget(
      {Key? key,
      required this.name,
      required this.type,
      required this.currentType,
      required this.sortedNotes})
      : super(key: key);

  @override
  State<ItemSortTypeWidget> createState() => _ItemSortTypeWidgetState();
}

class _ItemSortTypeWidgetState extends State<ItemSortTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //обработка нажатия на текст
      onTap: () {
        // если данный фильтр уже выбран, то снимаем фильтр и возвращаемся на экран
        if (widget.currentType == widget.type) {
          setState(() {
            widget.currentType = TypeOfSotring.none;
            widget.sortedNotes(widget.currentType);
          });
        }

        //если фильтр еще не выбран, то применяем фильтр и возвращаемся на экран
        else {
          setState(() {
            widget.currentType = widget.type;
            widget.sortedNotes(widget.currentType);
          });
          Navigator.pop(context);
        }
      },

      //выводим название сортировки
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.name,
          style: TextStyle(
            //меняем цвет, взависимости от того - выбран ли тип или нет
            color: widget.currentType == widget.type
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
