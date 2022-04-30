import 'package:flutter/material.dart';

import '../../string_resourses.dart';
import '../../widgets/edit_wine/button_search.dart';
import '../../widgets/edit_wine/grape_item.dart';
import '../../widgets/edit_wine/grape_select_item.dart';
import '../../widgets/system_widget/custom_text_field.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextField(
                textHint: 'Сорт винограда',
                controller: _controller,
                focusNode: _focus,
                isBack: true,
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
                              child: GrapeSelectItem(
                                grapeName: _selectedItems[index],
                              ));
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
                            return GrapeItem(
                              grapeName: _listSorts[index],
                              addGrapeInList: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() =>
                                    _selectedItems.add(_listSorts[index]));
                                _controller.clear();
                              },
                            );
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
                      ? const BackButton()
                      //если список сортов не пустой, то ничего не выводим
                      : const SizedBox()

                  //2. клавиатура скрыта - выводим две кнопки - "назад" и "сохранить"
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonsInSearch(
                        saveInfo: _selectedItems,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

//кнопка 'назад' для случая, если список пустой
class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextButton(
        child: Text(
          'Назад',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
