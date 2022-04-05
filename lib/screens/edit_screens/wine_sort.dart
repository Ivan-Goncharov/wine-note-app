import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';
import 'package:flutter_my_wine_app/widgets/custom_text_field.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/button_search.dart';

//экран для выбора сорта винограда
class WineSortScreen extends StatefulWidget {
  static const routName = './rout_name';
  const WineSortScreen({Key? key}) : super(key: key);

  @override
  State<WineSortScreen> createState() => _WineSortScreenState();
}

class _WineSortScreenState extends State<WineSortScreen> {
  //контроллер для текстового ввода
  late TextEditingController _controller;
  final _focus = FocusNode();

  //список сортов
  List<String> _listSorts = [];

  //список выбранных сортов
  List<String> _selectedItems = [];

  @override
  void didChangeDependencies() {
    setState(() {
      _selectedItems =
          ModalRoute.of(context)!.settings.arguments as List<String>;
    });
    super.didChangeDependencies();
  }

  //инициализируем данные
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_textInputListener);
    _listSorts = Country.grapeVariety;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  //слушатель ввода
  void _textInputListener() {
    //если пустой ввод, то выводим все сорта
    if (_controller.text.isEmpty) {
      setState(() => _listSorts = Country.grapeVariety);
    }
    //если текст введен, то ищем совпадения в списке сортов
    else {
      setState(() => _listSorts = _searchInList());
    }
  }

  //метод для поиска совпадений в списке сортов
  List<String> _searchInList() {
    return _listSorts
        .where((element) => element.toLowerCase().contains(
              _controller.text.toLowerCase(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    //переменные для пользовательского интерфейса
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //поле ввода названия винограда
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       hintText: 'Укажите сорт винограда',

              //       //кнопка удаления написанного текста
              //       suffixIcon: IconButton(
              //         icon: const Icon(Icons.clear_outlined),
              //         onPressed: () {
              //           _controller.clear();
              //         },
              //       ),
              //     ),
              //     focusNode: focus,
              //     controller: _controller,
              //     autofocus: true,
              //   ),
              // ),

              CustomTextField(
                textHint: 'Сорт винограда',
                controller: _controller,
                focusNode: _focus,
              ),

              //если в списке выбранных сортов есть элементы - выводим их
              _selectedItems.isNotEmpty

                  //прокручивающийся горизонтальный список выбранных сортов винограда
                  ? SizedBox(
                      height: size.height * 0.08,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            //обрабатываем нажатие, удаляя сорт из списка
                            onTap: () {
                              setState(() {
                                _selectedItems.remove(_selectedItems[index]);
                              });
                            },
                            child:
                                _selectItem(_selectedItems[index], colorScheme),
                          );
                        },
                        itemCount: _selectedItems.length,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),

              //скроллинг всех сортов винограда, которые нашлись по даннному текстовму вводу
              _listSorts.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          //если сорт еще не выбран, то выводим его на экран
                          if (!_selectedItems.contains(_listSorts[index])) {
                            return sortItem(_listSorts[index], context);
                          } else {
                            return const SizedBox();
                          }
                        },
                        itemCount: _listSorts.length,
                      ),
                    )

                  //если ничего не найдено, то выводим сообщение на экран
                  : const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Ничего не найдено',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

              //нижняя часть экрана
              //1. Если клавиатура показывается на экране
              _focus.hasFocus
                  ? _listSorts.isEmpty
                      //если список сортов пустой, то выводим кнопку назад
                      ? backButton(colorScheme, size, context)
                      //если список сортов не пустой, то ничего не выводим
                      : const SizedBox()

                  //2. клавиатура скрыта - выводим две кнопки - "назад" и "сохранить"
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonsInSearch(
                        //кнопка сохранить
                        //если выбраны элементы, то передаем список,
                        //если нет, то просто возвращаемся на предыдущий экран
                        onSave: () {
                          // if (_selectedItems.isEmpty) {
                          //   Navigator.pop(context);
                          // } else {
                          Navigator.pop(context, [_selectedItems]);
                          // }
                        },

                        //кнопка 'назад'
                        onBack: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  //кнопка 'назад' для случая, если клавиатура показана на экране
  Container backButton(
      ColorScheme colorScheme, Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.primary,
      ),
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: TextButton(
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
    );
  }

  //метод возвращает виджет с описанием одного сорта в поиске
  Widget sortItem(String sortName, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          //при нажатии добавляем сорт в список выбранных сортов
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            setState(() => _selectedItems.add(sortName));
            _controller.clear();
          },

          //название винограда
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              sortName,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(
          height: 5,
        ),
      ],
    );
  }

  //метод, который возвращаем один элемент в списке выбранных сортов
  Widget _selectItem(String selectItName, ColorScheme colors) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colors.primary,
      ),
      child: Row(
        children: [
          //название винограда
          Text(
            selectItName,
            style: TextStyle(
              color: colors.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),

          //иконка для удаления из списка
          const Icon(Icons.highlight_remove_outlined)
        ],
      ),
    );
  }
}
