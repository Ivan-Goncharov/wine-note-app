import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/models/wine_database_provider.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/bottom_sheet_grape.dart';

import 'package:flutter_my_wine_app/widgets/system_widget/button_container.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../string_resourses.dart';
import 'bottom_sheet_input.dart';

// виджет для ввода текста с возможной подсказкой по вводу
// пользователь вводит название, и если оно уже использовалось до этого
// в каком-либо виде, то всплывет подсказка
class TextInputWithHint extends StatefulWidget {
  final String fieldType;
  final String hintText;
  final String title;
  final String data;
  final String? countryName;
  final Function changeData;
  const TextInputWithHint({
    Key? key,
    required this.fieldType,
    required this.data,
    required this.changeData,
    required this.hintText,
    required this.title,
    this.countryName,
  }) : super(key: key);

  @override
  State<TextInputWithHint> createState() => _TextInputWithHintState();
}

class _TextInputWithHintState extends State<TextInputWithHint> {
  List<String> _listOfItem = [];
  String _countryName = '';
  String _data = '';
  late final dynamic _provider;
  bool _isInit = false;

  @override
  void initState() {
    _countryName = widget.countryName ?? '';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _data = widget.data;

      // работаем c регионами
      if (widget.fieldType == WineNoteFields.region) {
        setState(
          () => _listOfItem = Country.regionsOfCountry(widget.countryName!),
        );
      }

      //работаем с сортом винограда
      else if (widget.fieldType == WineNoteFields.grapeVariety) {
        setState(
          () => _listOfItem = Country.grapeVariety,
        );
      }

      //либо производитель, либо поставщик
      else {
        _provider = Provider.of<WineDatabaseProvider>(context, listen: false);
        setState(
          () => _listOfItem = _provider.createHintList(widget.fieldType),
        );
      }

      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //вызываем проверку состояния страны
    // если пользователь сменил страну,
    //то сменяются и доступные для подсказки регионы
    checkCountryState();

    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              //проверяем с каким полем работаем
              return widget.fieldType == WineNoteFields.grapeVariety
                  //для выбора сорта винограда нужен экран с мультивыбором
                  ? BottomSheetGrape(
                      selectedItems: _createListSort(),
                    )

                  //для одиночной подсказки ввода
                  : BottomSheetInputGeneral(
                      list: _listOfItem,
                      data: _data,
                      hintText: widget.hintText,
                      isCountry: false,
                    );
            }).then(
          (value) {
            //если экран просто закрыт, то ничего не делаем
            if (value == null) return;

            //если передан список, значит, это список сортов
            if (value is List<dynamic>) {
              setState(
                () => _data = _parseListGrapeSort(value as List<String>),
              );
            }

            //иначе передана строка, значит это обычный ввода
            else {
              setState(() => _data = value);
            }
            widget.changeData(_data);
          },
        );
      },
      child: InputButtonWidget(
        child: Row(
          children: [
            Text(widget.title),

            //ввведенный элемент
            Expanded(
              child: Text(
                _data,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //проверка состояния страны
  void checkCountryState() {
    //если мы работаем со страной и страна изменилась, то вызываем метод поиска регионов
    if (widget.countryName != null && _countryName != widget.countryName) {
      setState(
        () => _listOfItem = Country.regionsOfCountry(widget.countryName!),
      );
    }
  }

  //метод для создания списка из названий выбранных сортов
  List<String> _createListSort() {
    //если еще не выбраны, то возвращаем пустой список
    if (_data.isEmpty) {
      return [];
    }

    //если в списке сортов больше одного элемента,
    //то делм ситроку на элементы и возвращаем список
    else if (_data.contains(', ')) {
      return _data.split(', ');
    }

    //если выбран один сорт, то возврщаем список с одним элементом
    else {
      return [_data];
    }
  }

  //метод для создания строки из списка
  //принимает список сортов
  String _parseListGrapeSort(List<String> list) {
    String grapeSorts = '';
    for (var sort in list) {
      grapeSorts += '$sort, ';
    }
    //убираем у последнего элемента запятую
    grapeSorts = grapeSorts.substring(0, grapeSorts.length - 2);
    return grapeSorts;
  }
}
