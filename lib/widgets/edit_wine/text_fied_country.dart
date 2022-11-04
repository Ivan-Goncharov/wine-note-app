import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../system_widget/button_container.dart';
import '../../string_resourses.dart';
import '../../widgets/edit_wine/bottom_sheet_input.dart';

//виджет для вывода элемента в экране изменения данных о вине
//выводит страну
class TextFieldCountry extends StatefulWidget {
  //принимаем название страны и функцию для изменения данных в заметке
  final String countryName;
  final Function func;
  const TextFieldCountry({
    Key? key,
    required this.countryName,
    required this.func,
  }) : super(key: key);

  @override
  State<TextFieldCountry> createState() => _TextFieldCountryState();
}

class _TextFieldCountryState extends State<TextFieldCountry> {
  //переменная для хранения флага и названия страны
  late String _imagePath;
  late String _countryName;

  @override
  void initState() {
    _countryName = widget.countryName;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldCountry oldWidget) {
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
    return InkWell(
      onTap: () {
        //вызываем нижний экран
        showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return BottomSheetInputGeneral(
                list: Country.countryList,
                data: _countryName,
                hintText: 'Введите название страны',
                isCountry: true,
              );
            }).then(
          //ожидаем результат действия пользователя
          (value) {
            //если пользователь нажал 'назад'
            if (value == null) {
              return;
            }

            //если пользователь ввел собственную страну без флага
            else if (value is String) {
              setState(() {
                _countryName = value;
                _imagePath = '';
              });
              widget.func(_countryName);
            }

            //если пользователь выбрал страну, которая есть уже в приложении
            else {
              setState(() {
                _countryName = value['country'];
                _imagePath = value['svg'];
              });
              widget.func(_countryName);
            }
          },
        );
      },
      child: InputButtonWidget(
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
