import 'package:flutter/material.dart';

import '../../screens/overview_screens/item_filter.dart';

//виджет, который вызывается при тапе на страну / производителя / сорт винограда
//предлагает перейти на экраны со всеми винами категории
class TransitionBottomSheet extends StatelessWidget {
  //данные для первого поля
  final String dataOne;
  //тип первого поля
  final String typeOne;

  //данные для второго поля
  final String? dataTwo;
  //тип второго поля
  final String? typeTwo;

  const TransitionBottomSheet({
    Key? key,
    required this.dataOne,
    required this.typeOne,
    this.dataTwo,
    this.typeTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //первый тип перехода
          TransitionItem(
            data: dataOne,
            type: typeOne,
          ),

          //если есть второй тип перехода
          dataTwo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Divider(height: 2),
                    const SizedBox(height: 10),
                    TransitionItem(
                      data: dataTwo!,
                      type: typeTwo!,
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

//виджет для вывода одного элемента в списке переходов
class TransitionItem extends StatelessWidget {
  final String data;
  final String type;
  const TransitionItem({Key? key, required this.data, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ItemFilterNotes.routName,
        arguments: <String, dynamic>{
          'dataTitle': data,
          'filterName': type,
          'isFilter': false,
        },
      ),
      child: Row(
        children: [
          Text(
            'Все заметки: ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
