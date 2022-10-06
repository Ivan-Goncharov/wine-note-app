import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_filter_provider.dart';
import '../../models/wine_item.dart';
import '../../widgets/overview_widget/filter_button.dart';
import '../../widgets/overview_widget/notes_sorting.dart';
import '../../widgets/system_widget/app_bar.dart';
import '../../widgets/system_widget/wine_note_item.dart';

//экран для вывода всех заметок, связанных с одной страной/ производителем / сортом
class ItemFilterNotes extends StatefulWidget {
  const ItemFilterNotes({Key? key}) : super(key: key);

  @override
  State<ItemFilterNotes> createState() => _ItemFilterNotesState();
}

class _ItemFilterNotesState extends State<ItemFilterNotes> {
  //провайдер
  late WineFilterProvider _provider;

  // переменная для отслеживания - инициализированны данные или нет
  bool _isInit = false;

  // переменная для загрузочного экрана
  bool _isLoading = false;

  //переменная для отслеживания, по какой причине пустой экран заметок
  //если true - значит неудачный фильтр вин
  //если false - значит удалили последнюю заметку в списке
  bool _isFilterApply = false;

  //название
  late final String _dataTitle;
  //поле для фильтрации записей
  late final String _filterName;
  //необходим ли фильтр
  //принимаем значение в аргументах
  late final bool _isFilter;

  //переменная для сохранения выбранного фильтра
  String _selectData = '';

  //тип выбранной сортировки - по умолчанию никакого типа
  TypeOfSotring _typeOfSotring = TypeOfSotring.none;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      //подключаем провайдер
      _provider = Provider.of<WineFilterProvider>(context);
      //очищаем предыдущий список регионов
      _provider.clearRegions();

      //принимаем аргументы
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _dataTitle = arguments['dataTitle']!;
      _filterName = arguments['filterName']!;
      _isFilter = arguments['isFilter']!;

      setState(() => _isLoading = true);
      _provider
          .fetchCustomNotes(_filterName, _dataTitle)
          .then((_) => setState(() => _isLoading = false));

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
          //кнопка для вызова типа сортировок
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
          _isFilter
              ? FilterButton(
                  filterName: _filterName,
                  regions: _provider.regions,
                  selectData: _selectData,
                  changeData: _changeData,
                )
              : const SizedBox(),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),

              //проверяем, не пустой ли список после фильтрации
              child: _provider.filterList.isEmpty
                  //проверяем по какой причине - пустой список
                  ? _isFilterApply

                      //если список пустой по причине - отсутсвия вина из-за неправильного фильтра
                      ? UnsuccessfulFilter(
                          tapFunction: _changeData,
                          buttonName: 'Сбросить',
                          title: 'Нет заметок с данным цветом вина',
                        )

                      //если список пустой из-за удаления последней заметки
                      : UnsuccessfulFilter(
                          tapFunction: (String a, String b) {
                            Navigator.pop(context);
                          },
                          buttonName: 'Назад',
                          title: 'Список заметок пуст',
                        )

                  //если заметки есть, то выводим их
                  : ListView.builder(
                      //выводим список всех заметок по стране
                      itemBuilder: (context, index) {
                        return WineNoteItem(
                          _provider.filterList[index],
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
      _provider.clearFilter(_typeOfSotring);
      _isFilterApply = false;
    }

    //если выбран, то применяем фильтр к заметкам
    else {
      _provider.selectFilter(
        filterName: filterName,
        data: _selectData,
        typeOfSotring: _typeOfSotring,
      );
      _isFilterApply = true;
    }
  }

  //метод для сортировки списка заметок
  //принимает тип сортировки
  void _sortNotes(TypeOfSotring type) {
    _typeOfSotring = type;
    _isFilterApply = true;
    _provider.sortNotes(type);
  }
}

//сообщение об ошибке фильтрации
class UnsuccessfulFilter extends StatelessWidget {
  //функция, которая вызывается при нажатии на кнопку
  final Function tapFunction;
  //название кнопки
  final String buttonName;
  //заголовок
  final String title;

  const UnsuccessfulFilter(
      {Key? key,
      required this.tapFunction,
      required this.buttonName,
      required this.title})
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
              title,
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
                  buttonName,
                  style: TextStyle(
                    color: _colors.onPrimaryContainer,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  tapFunction(WineNoteFields.wineColors, '');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
