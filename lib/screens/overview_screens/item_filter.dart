import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:provider/provider.dart';

import '../../models/wine_sorted_provider.dart';
import '../../widgets/overview_widget/filter_button.dart';
import '../../widgets/overview_widget/notes_sorting.dart';
import '../../widgets/system_widget/app_bar.dart';
import '../../widgets/system_widget/wine_note_item.dart';

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

  // переменная для отслеживания - инициализированны данные или нет
  bool _isInit = false;

  //название
  String _dataTitle = '';
  //поле для фильтрации записей
  String _filterName = '';
  //переменная для сохранения выбранного фильтра
  String _selectData = '';
  //тип выбранной сортировки - по умолчанию никакого типа
  TypeOfSotring _typeOfSotring = TypeOfSotring.none;

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
      //отмечаем, что инициализация проведена
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _dataTitle,
        listOfAction: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return NoteSorting(
                    currentType: _typeOfSotring,
                    sortNotes: _sortNotes,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.sort,
              size: 32,
            ),
          ),
          //кнопка для вывода меню с фильтром по регионам
          FilterButton(
            filterName: _filterName,
            regions: _provider.regions,
            selectData: _selectData,
            changeData: _changeData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        //проверяем, не пустой ли список после фильтрации
        child: _provider.filterList.isEmpty

            //если пустой, то выводим соощение с ошибкой фильтрации
            ? UnsuccessfulFilter(clearFilter: _changeData)

            //если заметки есть, то выводим их
            : ListView.builder(
                //выводим список всех заметок по стране
                itemBuilder: (context, index) {
                  return WineNoteItem(
                    _provider.filterList[index],
                    ItemFilterNotes.routName,
                  );
                },
                itemCount: _provider.filterList.length,
              ),
      ),

      // кнопка для сортировки
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

  //метод для сортировки списка заметок
  //принимает тип сортировки
  void _sortNotes(TypeOfSotring type) {
    _typeOfSotring = type;
    _provider.sortNotes(type);
  }
}

//сообщение об ошибке фильтрации
class UnsuccessfulFilter extends StatelessWidget {
  final Function clearFilter;
  const UnsuccessfulFilter({Key? key, required this.clearFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //цветовая тема
    late ColorScheme _colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //иконка
            Icon(
              Icons.search_off,
              size: 60,
              color: _colors.secondary,
            ),
            const SizedBox(height: 10),

            //сообщение
            Text(
              'Нет заметок с данным цветом вина',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _colors.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            //кнопка сброса
            Container(
              decoration: BoxDecoration(
                color: _colors.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                child: Text(
                  'Сбросить',
                  style: TextStyle(
                    color: _colors.onPrimaryContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  clearFilter(WineNoteFields.wineColors, '');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
