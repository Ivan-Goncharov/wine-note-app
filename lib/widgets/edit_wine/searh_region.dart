import 'package:flutter/material.dart';

import '../../string_resourses.dart';
import '../../screens/edit_screens/search_screen.dart';
import 'button_container.dart';

//виджет для вывода кнопки выбора региона
class SearchRegion extends StatefulWidget {
  //принимает данные о выбранном регионе и стране и функцию для сохранения выбора
  final String regionName;
  final String countryName;
  final Function function;
  const SearchRegion(
      {Key? key,
      required this.regionName,
      required this.countryName,
      required this.function})
      : super(key: key);

  @override
  State<SearchRegion> createState() => _SearchRegionState();
}

class _SearchRegionState extends State<SearchRegion> {
  //список регионов данной страны
  late List<String> _listRegions;
  late String _regionName;

  @override
  Widget build(BuildContext context) {
    _regionName = widget.regionName;
    final _colors = Theme.of(context).colorScheme;
    return GestureDetector(
      //при нажатии  - происходит переход на страницу с выбором региона
      //запускаем метод, который создает список регионов, если уже выбрана страна
      onTap: () async {
        _listRegions = Country.regionsOfCountry(widget.countryName);
        //переход на страницу
        //передаем список регионов, тип поиска и выбранный на данный момент регион
        //сохраняем результат выбора в переменную
        final result = await Navigator.pushNamed(
          context,
          SearchScreen.routName,
          arguments: {
            'list': _listRegions,
            'type': SearchType.regionType,
            'text': _regionName
          },
        );

        //обрабатываем выбор пользователя и вызываем функцию для сохранения выбора
        if (result == null) {
          return;
        } else if (result is List<String>) {
          setState(() {
            _regionName = result[0];
            widget.function(_regionName);
          });
        }
      },

      //данные для кнопки
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //заголовок
            Text(
              'Регион',
              style: TextStyle(
                color: _colors.onBackground,
                fontSize: 16,
              ),
            ),

            //выбранный регион
            Row(
              children: [
                Text(
                  _regionName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
