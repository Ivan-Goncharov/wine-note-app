import 'package:flutter/material.dart';

import '../../widgets/edit_wine/item_search_country.dart';
import '../../widgets/edit_wine/item_search_region.dart';
import '../../string_resourses.dart';
import '../../widgets/system_widget/custom_text_field.dart';
import '../../widgets/edit_wine/button_search.dart';

// экран для текстового ввода стран и регионов, с возможностью подсказки ввода
class SearchScreen extends StatefulWidget {
  static const routName = '/countryEdit';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //контроллер для текстового поля
  late TextEditingController _textController;

  //переменные, которые будем инициализировать через аргументы навигатора
  //список всех элементов поиска,
  List<dynamic> _elementsOfRes = [];

  //тип поиска
  SearchType _searchType = SearchType.regionType;

  //текст, который был введен до открытия экрана, в предыдущий раз
  String _text = '';

  //список для сохранения результатов поиска
  List<dynamic> _searchList = [];

  //инициализируем контроллер и прикрепляем слушатель
  @override
  void initState() {
    _textController = TextEditingController();
    _textController.addListener(_inputListener);

    super.initState();
  }

  //слушатель контроллера для ввода
  void _inputListener() {
    //если текст введен
    if (_textController.text.isNotEmpty) {
      //если тип - поиск стран, то вызываем метод для поиска стран
      //заполняем список элементами поиска
      if (_searchType == SearchType.countryType) {
        setState(() {
          _searchList = _searchCountry(_textController.text);
        });
      }

      //если тип - поиск регионов, вызываем метод для поиска регионов
      else if (_searchType == SearchType.regionType) {
        setState(() {
          _searchList = _searchRegion(_textController.text);
        });
      }
    } else {
      setState(() {
        _searchList = [];
      });
    }
  }

  //принимаем аргументы навигации
  @override
  void didChangeDependencies() {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _elementsOfRes = arg['list'];
    _searchType = arg['type'];
    _text = arg['text'];

    //меняем текст в поле ввода на текст, который вводили до этого
    setState(() {
      _textController.text = _text;
    });
    super.didChangeDependencies();
  }

  //метод для поиска страны в списке стран
  List<Map<String, dynamic>> _searchCountry(String item) {
    List<Map<String, dynamic>> list = [];

    //проходим по списку всех стран и если элемент содержит введенный текст,
    // то добавляем в список найденных элементов
    for (var element in _elementsOfRes) {
      if (element['country']!.toLowerCase().contains(item.toLowerCase())) {
        list.add(element);
      }
    }
    return list;
  }

  //метод для поиск региона в списке регионов
  List<String> _searchRegion(String item) {
    List<String> list = [];
    for (var element in _elementsOfRes) {
      if ((element as String).toLowerCase().contains(item.toLowerCase())) {
        list.add(element);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //поле ввода, подсказка ввода зависит от типа поиска
              CustomTextField(
                textHint: _searchType == SearchType.countryType
                    ? 'Введите страну производителя'
                    : 'Введите регион производителя',
                controller: _textController,
                isBack: true,
                saveInput: (value) {
                  Navigator.pop(context, [value]);
                },
              ),

              const SizedBox(height: 10),

              //если поле ввода пустое, то ничего не выводим на экран
              _textController.text.isEmpty
                  ? const SizedBox()

                  //проверка - пустой ли список поиска
                  : _searchList.isEmpty
                      // ? rowButtons(colorScheme, size, context)
                      ? ButtonsInSearch(
                          saveInfo: _textController.text,
                        )

                      //если список не пустой, то выводим список элементов
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              //выводим на экран либо страну, либо регион
                              final element = _searchList[index];
                              if (_searchType == SearchType.countryType) {
                                return ItemSearchCountry(element: element);
                              } else {
                                return ItemSearchRegion(region: element);
                              }
                            },
                            itemCount: _searchList.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
