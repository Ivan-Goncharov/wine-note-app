import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/screens/overview_screens/item_country.dart';
import 'package:flutter_svg/flutter_svg.dart';

//виджет для вывода одного элемента в списке стран
class ItemOverviewCountry extends StatelessWidget {
  //принимаем информацию о стране в Map, размеры и цветовую схему
  final Map<String, dynamic> country;
  final Size size;
  final ColorScheme colorScheme;
  const ItemOverviewCountry({
    Key? key,
    required this.country,
    required this.size,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //при нажатии на плитку со страной -
      //переходим на экран со всеми заметками этой страны
      //и передаем название страны
      onTap: () => Navigator.pushNamed(
        context,
        ItemCountryNotes.routName,
        arguments: country['country'],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colorScheme.surfaceVariant,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child:
                  // проверяем, есть ли у страны флаг (добавлен ли он в приложении)
                  (country['svg'] as String).isEmpty
                      ? const SizedBox()
                      //выводим на экран флаг
                      : SvgPicture.asset(
                          country['svg'],
                          width: size.width * 0.05,
                          height: size.height * 0.05,
                        ),
            ),
            const SizedBox(width: 10),

            //название страны
            Expanded(
              child: Text(
                country['country'],
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),

            //количество винных заметок
            Text(createCount(country['count'] as int)),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  //метод для форматирования числа количества вин
  String createCount(int count) {
    String title = '';
    //остаток от деления для правильного склонения существительного
    int remains = count % 10;
    if (remains == 1 && count != 11) {
      title = '$count вино';
    } else if (count < 10 && (remains == 2 || remains == 3 || remains == 4)) {
      title = '$count вина';
    } else {
      title = '$count вин';
    }
    return title;
  }
}
