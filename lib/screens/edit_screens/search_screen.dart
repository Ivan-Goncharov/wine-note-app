import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/custom_text_field.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/button_search.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../string_resourses.dart';

// экра для текстового ввода стран и регионов, с возможностью подсказки ввода
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
    final size = MediaQuery.of(context).size;

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
              ),

              const SizedBox(height: 10),

              //если поле ввода пустое, то ничего не выводим на экран
              _textController.text.isEmpty
                  ? const SizedBox()

                  //проверка - пустой ли список поиска
                  : _searchList.isEmpty
                      // ? rowButtons(colorScheme, size, context)
                      ? ButtonsInSearch(
                          onSave: () {
                            Navigator.pop(context, [_textController.text]);
                          },
                          onBack: () {
                            Navigator.pop(context);
                          },
                        )

                      //если список не пустой, то выводим список элементов
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              //выводим на экран либо страну, либо регион
                              final element = _searchList[index];
                              if (_searchType == SearchType.countryType) {
                                return itemCountry(context, element, size);
                              } else {
                                return itemRegion(context, element, size);
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

  //метод для вывода одного элемента поиска стран
  //принимает контекст, карту со значениями страны и размеры экрана
  Widget itemCountry(
      BuildContext context, Map<String, dynamic> element, Size size) {
    //обрабатываем нажатие на элемент
    return GestureDetector(
      //по нажатию, возвращаемся на экран редактирования заметки
      //передаем страну
      onTap: () {
        Navigator.pop(context, [element]);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            //флаг страны
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.asset(
                element['svg']!,
                width: size.width * 0.05,
                height: size.height * 0.05,
              ),
            ),
            const SizedBox(width: 10),

            //название
            Text(
              element['country']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

//один элемент поиска региона
//принимает контекст, регион и размеры экрана
  Widget itemRegion(BuildContext context, String element, Size size) {
    return GestureDetector(
      //по нажатию возвращаемся на предыдущий экран и передаем регион
      onTap: () {
        Navigator.pop(context, [element]);
      },

      // название региона
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          element,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  //метод, который возвращат кнопки 'Назад' и 'Cохранить'
  //принимает цветовую схему, размер и контекст
  Widget rowButtons(ColorScheme colorScheme, Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //кнопка назад
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Назад',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        //кнопка "Сохранить"
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Сохранить',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),

            //по нажатию передаем введенный текст в поле ввода
            onPressed: () {
              Navigator.pop(context, [_textController.text]);
            },
          ),
        )
      ],
    );
  }

  //контейнер для стилизации кнопок
  Widget buttonContainer(
      {required ColorScheme colorScheme,
      required Size size,
      required Widget button}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.primary,
      ),
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: button,
    );
  }
}
