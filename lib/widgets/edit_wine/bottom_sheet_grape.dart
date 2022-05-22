import 'package:flutter/material.dart';

import '../../string_resourses.dart';
import '../system_widget/custom_text_field.dart';
import 'button_search.dart';

//виджет для выбора сорта винограда
class BottomSheetGrape extends StatefulWidget {
  //выбранные сорта
  final List<String> selectedItems;
  static const routName = './rout_name';
  const BottomSheetGrape({Key? key, required this.selectedItems})
      : super(key: key);

  @override
  State<BottomSheetGrape> createState() => _BottomSheetGrapeState();
}

class _BottomSheetGrapeState extends State<BottomSheetGrape> {
  //контроллер для текстового ввода
  late TextEditingController _controller;
  final _focus = FocusNode();

  //список сортов
  List<String> _listSorts = [];

  //список выбранных сортов
  List<String> _selectedItems = [];

  //инициализируем данные
  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_textInputListener);
    _listSorts = Country.grapeVariety;
    _selectedItems = widget.selectedItems;
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
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
                            setState(
                                () => _selectedItems.add(_listSorts[index]));
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
                  //если список сортов пустой, то предлагаем пользователю
                  //либо добавить его сорт в список, либо сохранить ввод
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonsInSearch(
                        saveInfo: _controller.text,
                        leftButtonTitle: 'Добавить в список',
                        leftButtonFunc: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() => _selectedItems.add(_controller.text));
                          _controller.clear();
                        },
                        rightButtonTitle: 'Сохранить',
                        rightButtonFunc: () =>
                            Navigator.pop(context, _controller.text),
                      ),
                    )
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

//виджет для вывода одного сорта винограда в списке выбранных сортов
class GrapeSelectItem extends StatelessWidget {
  //сорт винограда
  final String grapeName;
  const GrapeSelectItem({Key? key, required this.grapeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          //название винограда
          Text(
            grapeName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
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

//виджет для вывода одного элемента в поиске сортов винограда
class GrapeItem extends StatelessWidget {
  //название сорта
  final String grapeName;
  // функция для добавления сорта виногарада в список выбранных сортов
  final Function addGrapeInList;

  const GrapeItem(
      {Key? key, required this.grapeName, required this.addGrapeInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          //при нажатии добавляем сорт в список выбранных сортов
          onTap: () => addGrapeInList(),

          //название винограда
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              grapeName,
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
}
