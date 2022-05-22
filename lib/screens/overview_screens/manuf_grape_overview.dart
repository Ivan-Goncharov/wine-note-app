import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/overview_screens/item_filter.dart';
import '../../models/wine_item.dart';
import '../../models/wine_overview_provider.dart';
import '../../widgets/system_widget/custom_text_field.dart';

//экран для вывода всех производителей вина, которые использовались в заметках
class ManufGrapeOverviewScreen extends StatefulWidget {
  static const routName = './manufactScreen';
  const ManufGrapeOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ManufGrapeOverviewScreen> createState() =>
      _ManufGrapeOverviewScreenState();
}

class _ManufGrapeOverviewScreenState extends State<ManufGrapeOverviewScreen> {
  //переменная для инициализации
  bool _isInit = false;
  //переменная для вывода виджета поиска
  bool _isSearch = false;
  //провайдер для получения списка производителей
  late WineOverviewProvider _provider;
  //контроллер для отслеживания ввода текста
  late TextEditingController _controller;
  //полученный тип экрана: производители или сорт вина
  late String _fieldType;

  @override
  void initState() {
    // инициализируем контроллер и подключаем слушатель к нему
    _controller = TextEditingController();
    _controller.addListener(listener);
    super.initState();
  }

  // слушатель контроллера ввода
  void listener() {
    //если поле ввода не пустое,  ищем производителей
    if (_controller.text.isNotEmpty) {
      _provider.searchData(_controller.text, false);
    } else {
      //иначе поисковый список заполняем всеми производителями
      _provider.addAllData();
    }
  }

  @override
  void didChangeDependencies() {
    //инициализируем данные при первом запуске
    if (!_isInit) {
      //принимаем тип поиска
      _fieldType = ModalRoute.of(context)!.settings.arguments as String;
      _provider = Provider.of<WineOverviewProvider>(context, listen: true);
      //запускаем метод создания списка и передаем тип поля,
      //по которому необходимо производить поиск
      _provider.createAllDataList(_fieldType);
      //инициализация завершена
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //если была нажата кнопка "Поиск", то скрываем AppBar
      appBar: _isSearch
          ? PreferredSize(
              child: Container(),
              preferredSize: const Size(0.0, 0.0),
            )
          : AppBar(
              title: Text(
                _fieldType == WineNoteFields.manufacturer
                    ? 'Производители'
                    : 'Сорта винограда',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () => setState(() => _isSearch = true),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // если была нажата кнопка 'Поиск', то выводим на экран строку с поиском производителя
            _isSearch
                ? CustomTextField(
                    textHint: _fieldType == WineNoteFields.manufacturer
                        ? 'Поиск производителя'
                        : 'Поиск сорта винограда',
                    controller: _controller,
                    isBack: false,
                    function: hideSearchBar,
                  )
                : const SizedBox(),

            //список производителей
            Expanded(
              child: ListView.builder(
                itemCount: _provider.manufactSearch.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ItemFilterNotes.routName,
                      arguments: {
                        'dataTitle': _provider.manufactSearch[index]['title'] ==
                                WineOverviewProvider.notFoundGrape
                            ? ''
                            : _provider.manufactSearch[index]['title'],
                        'filterName': _fieldType,
                        'isFilter': true,
                      },
                    ),
                    child: ItemManufacturer(
                      title: createNameField(index),
                      count: _provider.manufactSearch[index]['count'],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //метод для изменения экрана, после нажатия кнопки 'отменить' в виджете поиска
  //скрываем поисковую строку и выводим всех производителей
  void hideSearchBar() {
    _provider.addAllData();

    setState(() {
      _isSearch = false;
      _controller.clear();
    });
  }

  //метод для создания названия поля (производителя или сорта винограда)
  String createNameField(int index) {
    //получаем название поле
    final String title = _provider.manufactSearch[index]['title'];

    //проверяем с каким типом полей мы работаем
    // и выясняем заполнил ли пользователь название производителя или сорта
    if (_fieldType == WineNoteFields.manufacturer) {
      return title.isEmpty ? 'Производитель не указан' : title;
    } else {
      return title.isEmpty ? 'Сорт не указан' : title;
    }
  }
}

//вывод одного производителя
class ItemManufacturer extends StatelessWidget {
  //название производителя
  final String title;
  //количество заметок
  final int count;

  const ItemManufacturer({Key? key, required this.title, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(createCount(count)),
        ],
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
