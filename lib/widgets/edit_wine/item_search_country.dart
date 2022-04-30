import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//виджет для вывода одной страны в скроллинге стран при выборе страны
class ItemSearchCountry extends StatelessWidget {
  //информация о стране
  final Map<String, dynamic> element;
  const ItemSearchCountry({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      //по нажатию, возвращаемся на экран редактирования заметки
      //передаем страну
      onTap: () {
        Navigator.pop(context, [element]);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            //флаг страны
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.asset(
                element['svg']!,
                width: size.width * 0.05,
                height: size.height * 0.05,
              ),
            ),
            const SizedBox(width: 10),

            //название
            Text(
              element['country']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
