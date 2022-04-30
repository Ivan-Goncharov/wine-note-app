import 'package:flutter/material.dart';

//один элемент в списке регионов при поиске регионов
class ItemSearchRegion extends StatelessWidget {
  //название региона
  final String region;
  const ItemSearchRegion({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //по нажатию возвращаемся на предыдущий экран и передаем регион
      onTap: () {
        Navigator.pop(context, [region]);
      },

      // название региона
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          region,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
