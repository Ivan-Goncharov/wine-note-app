import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../screens/edit_screens/search_screen.dart';
import '../../string_resourses.dart';
import 'button_container.dart';

//виджет для вывода элемента в экране изменения данных о вине
//выводит страну
class SearchCountry extends StatefulWidget {
  //принимаем название страны и функцию для изменения данных в заметке
  final String countryName;
  final Function func;
  const SearchCountry({
    Key? key,
    required this.countryName,
    required this.func,
  }) : super(key: key);

  @override
  State<SearchCountry> createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  //переменная для хранения флага и названия страны
  late String _imagePath;
  late String _countryName;

  @override
  void initState() {
    _countryName = widget.countryName;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchCountry oldWidget) {
    if (widget.countryName.isNotEmpty) {
      _countryName = widget.countryName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //если у страны есть есть флаг,
    //то присваиваем путь к нему, если нет, то путь пустой
    if (_countryName.isNotEmpty) {
      _imagePath = Country.fetchSvgPath(_countryName);
    } else {
      _imagePath = '';
    }

    final size = MediaQuery.of(context).size;
    //по тапу переходим на экран с вводом текста
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          SearchScreen.routName,
          arguments: {
            'list': Country.countryList,
            'type': SearchType.countryType,
            'text': _countryName
          },
        );

        //ожидаем результат ввода
        if (result == null) {
          return;
        }

        //если была введена страна, которой нет в базе данных,
        //то она без флага и мы ожидаем, что вернется просто название
        else if ((result as List)[0] is String) {
          setState(() {
            _countryName = result[0];
            widget.func(_countryName);
            _imagePath = '';
          });
        }

        //если была выбрана страна, которая есть в базе,
        //то ожидаем получить Map с флагом и названием страны
        else {
          final map = (result)[0] as Map<String, dynamic>;
          setState(() {
            _countryName = map['country']!;
            widget.func(_countryName);
            _imagePath = map['svg']!;
          });
        }
      },
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Cтрана'),
            Row(
              children: [
                Text(
                  _countryName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _imagePath.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SvgPicture.asset(
                            _imagePath,
                            width: size.width * 0.05,
                            height: size.height * 0.05,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
