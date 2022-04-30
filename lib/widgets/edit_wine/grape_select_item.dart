import 'package:flutter/material.dart';

//виджет для вывода одного сорта винограда в списке выбранных сортов
class GrapeSelectItem extends StatelessWidget {
  //сорт винограда
  final String grapeName;
  const GrapeSelectItem({Key? key, required this.grapeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          //название винограда
          Text(
            grapeName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),

          //иконка для удаления из списка
          const Icon(Icons.highlight_remove_outlined)
        ],
      ),
    );
  }
}
