import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/widgets/overview_widget/colors_botsheet.dart';
import 'package:provider/provider.dart';

import '../../models/wine_sorted_provider.dart';
import '../../widgets/overview_widget/region_botsheet.dart';
import '../../widgets/wine_note_item.dart';

//экран для вывода всех заметок, связанных с одной страной/ производителем
class ItemFilterNotes extends StatefulWidget {
  static const routName = ' ./itemFilter';
  const ItemFilterNotes({Key? key}) : super(key: key);

  @override
  State<ItemFilterNotes> createState() => _ItemFilterNotesState();
}

class _ItemFilterNotesState extends State<ItemFilterNotes> {
  //провайдер
  late WineSortProvider _provider;
  //название страны
  String _dataTitle = '';
  //поле для фильтрации записей
  String _filterName = '';
  // переменная для отслеживания - инициализированны данные или нет
  bool _isInit = false;
  //цветовая схема
  late ColorScheme _colorScheme;
  //переменная для сохранения выбранного фильтра
  String _selectData = '';

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      //подключаем провайдер
      _provider = Provider.of<WineSortProvider>(context);
      //принимаем аргументы
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _dataTitle = arguments['dataTitle']!;
      _filterName = arguments['filterName']!;

      //запускаем метод с поиском всех заметок с этой страной
      _provider.fetchCustomNotes(_filterName, _dataTitle);
      //получаем цветовую схему
      _colorScheme = Theme.of(context).colorScheme;
      //отмечаем, что инициализация проведена
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dataTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          //кнопка для вывода меню с фильтром по регионам
          GestureDetector(
            child: _filterButton(context),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  //проверяем, какой тип фильтрации используем и вызываем соотвествующее меню фильтров
                  if (_filterName == WineNoteFields.country) {
                    return RegionBottomSheet(
                      regions: _provider.regions,
                      selectRegion: _selectData,
                      saveRegion: _changeData,
                    );
                  } else {
                    return ColorsBotoomsheet(
                      saveColor: _changeData,
                      selectColor: _selectData,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          //выводим список всех заметок по стране
          itemBuilder: (context, index) {
            return WineNoteItem(_provider.filterList[index]);
          },
          itemCount: _provider.filterList.length,
        ),
      ),
    );
  }

  //кнопка - фильтр для appbar
  Widget _filterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colorScheme.surfaceVariant,
      ),
      child: Row(
        children: [
          Text(
            'Фильтр',
            style: TextStyle(
              color: _colorScheme.onSurfaceVariant,
              fontSize: 15,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_outlined,
            color: _colorScheme.onSurfaceVariant,
          )
        ],
      ),
    );
  }

  //метод для смены региона
  //принимает тип фильтрации и данные для нового фильтра
  void _changeData(String filterName, String newData) {
    print(filterName);
    setState(() => _selectData = newData);
    //проверяем, выбран ли регион или нет
    //если фильтр не выбрае, то выводим все заметки по стране
    if (_selectData.isEmpty) {
      _provider.clearFilter();
    }

    //если выбран, то применяем фильтр к заметкам
    else {
      _provider.selectFilter(filterName: filterName, data: _selectData);
    }
  }

  //метод для смены цвета
  // void _changeColor(String newColor) {
  //   setState(() => _selectData = newColor);
  //   //проверяем, выбран ли регион или нет
  //   //если фильтр не выбрае, то выводим все заметки по стране
  //   if (_selectData.isEmpty) {
  //     _provider.clearFilter();
  //   }

  //   //если выбран, то применяем фильтр к заметкам
  //   else {
  //     _provider.selectFilter(
  //         filterName: WineNoteFields.region, data: _selectData);
  //   }
  // }
}
