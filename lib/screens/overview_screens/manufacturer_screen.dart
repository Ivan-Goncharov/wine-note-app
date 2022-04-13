import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';

import 'package:flutter_my_wine_app/models/wine_overview_provider.dart';
import 'package:flutter_my_wine_app/screens/overview_screens/item_filter.dart';
import 'package:flutter_my_wine_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

//экран для вывода всех производителей вина, которые использовались в заметках
class ManufactOverviewScreen extends StatefulWidget {
  static const routName = './manufactScreen';
  const ManufactOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ManufactOverviewScreen> createState() => _ManufactOverviewScreenState();
}

class _ManufactOverviewScreenState extends State<ManufactOverviewScreen> {
  //переменная для инициализации
  bool _isInit = false;
  //переменная для вывода виджета поиска
  bool _isSearch = false;
  //провайдер для получения списка производителей
  late WineOverviewProvider _provider;
  //контроллер для отслеживания ввода текста
  late TextEditingController _controller;
  //цветовая схема
  late ColorScheme _colorScheme;
  //размерная сетка
  late Size _size;
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
      _colorScheme = Theme.of(context).colorScheme;
      _size = MediaQuery.of(context).size;
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
    // final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      //если была нажата кнопка "Поиск", то скрываем AppBar
      appBar: _isSearch
          ? PreferredSize(
              child: Container(),
              preferredSize: const Size(0.0, 0.0),
            )
          : AppBar(
              title: Text(_fieldType == WineNoteFields.manufacturer
                  ? 'Производители'
                  : 'Сорта винограда'),
              elevation: 0,
              backgroundColor: Colors.transparent,

              //кнопка для показа строки поиска производителя
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
                        'dataTitle': _provider.manufactSearch[index]['title'],
                        'filterName': _fieldType,
                      },
                    ),
                    child: itemManufactorer(
                      _provider.manufactSearch[index]['title'],
                      _provider.manufactSearch[index]['count'],
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

  Widget itemManufactorer(String title, int count) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      height: _size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colorScheme.surfaceVariant,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: _colorScheme.onSurfaceVariant,
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

  //метод для изменения экрана, после нажатия кнопки 'отменить' в виджете поиска
  //скрываем поисковую строку и выводим всех производителей
  void hideSearchBar() {
    _provider.addAllData();

    setState(() {
      _isSearch = false;
      _controller.clear();
    });
  }
}
