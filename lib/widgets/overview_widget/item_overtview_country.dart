import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/wine_item.dart';

//виджет для вывода одного элемента в списке стран
class ItemOverviewCountry extends StatelessWidget {
  //принимаем информацию о стране в Map, размеры и цветовую схему
  final Map<String, dynamic> country;
  const ItemOverviewCountry({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //при нажатии на плитку со страной -
      //переходим на экран со всеми заметками этой страны
      //и передаем название страны и поле для фильтрации записей
      onTap: () => Navigator.pushNamed(
        context,
        itemFilterNotesRoute,
        arguments: <String, dynamic>{
          'dataTitle': country['country'],
          'filterName': WineNoteFields.country,
          'isFilter': true,
        },
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child:
                  // проверяем, есть ли у страны флаг (добавлен ли он в приложении)
                  (country['svg'] as String).isEmpty
                      ? const NoneFlag()
                      //выводим на экран флаг
                      : SvgPicture.asset(
                          country['svg'],
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
            ),
            const SizedBox(width: 10),

            //название страны
            Expanded(
              child: Text(
                getCountryName(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),

            //количество винных заметок
            Text(
              createCount(country['count'] as int),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
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

  String getCountryName() {
    return (country['country'] as String).isEmpty
        ? 'Страна не указана'
        : country['country'];
  }
}

//если нет флага, то выводим иконку страны
class NoneFlag extends StatelessWidget {
  const NoneFlag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: MediaQuery.of(context).size.width * 0.14,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Icon(
        Icons.flag,
        size: 30,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
