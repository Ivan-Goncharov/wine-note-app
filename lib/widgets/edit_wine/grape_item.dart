import 'package:flutter/material.dart';

//виджет для вывода одного элемента в поиске сортов винограда
class GrapeItem extends StatelessWidget {
  //название сорта
  final String grapeName;
  // функция для добавления сорта виногарада в список выбранных сортов
  final Function addGrapeInList;

  const GrapeItem(
      {Key? key, required this.grapeName, required this.addGrapeInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          //при нажатии добавляем сорт в список выбранных сортов
          onTap: () => addGrapeInList(),

          //название винограда
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              grapeName,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          height: 5,
        ),
      ],
    );
  }
}
