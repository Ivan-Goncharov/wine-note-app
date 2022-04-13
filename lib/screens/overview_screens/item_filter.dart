import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_item.dart';
import '../../models/wine_sorted_provider.dart';
import '../../widgets/overview_widget/region_botsheet.dart';
import '../../widgets/wine_note_item.dart';
import '../../widgets/overview_widget/colors_botsheet.dart';

//экран для вывода всех заметок, связанных с одной страной/ производителем / сортом
class ItemFilterNotes extends StatefulWidget {
  static const routName = ' ./itemFilter';
  const ItemFilterNotes({Key? key}) : super(key: key);

  @override
  State<ItemFilterNotes> createState() => _ItemFilterNotesState();
}

class _ItemFilterNotesState extends State<ItemFilterNotes> {
  //провайдер
  late WineSortProvider _provider;
  //название
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

      //запускаем метод с поиском всех заметок связынных с этим полем фильтрации
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
          IconButton(
            icon: const Icon(
              Icons.tune,
              size: 32,
            ),
            onPressed: () {
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

      // кнопка для сортировки
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.sort),
      ),
    );
  }

  //метод для смены региона
  //принимает тип фильтрации и данные для нового фильтра
  void _changeData(String filterName, String newData) {
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
}
