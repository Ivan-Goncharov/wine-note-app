import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/wine_list_provider.dart';
import '../widgets/system_widget/custom_text_field.dart';
import '../widgets/system_widget/wine_note_item.dart';

//виджет для поиска винных заметок
class SearchWineNote extends StatefulWidget {
  static const routName = './searchWineNote';

  //принимаем функцию, которая будет вызываться при нажатии кнопки 'отмена'
  final Function function;
  const SearchWineNote({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  State<SearchWineNote> createState() => _SearchWineNoteState();
}

class _SearchWineNoteState extends State<SearchWineNote> {
  //контроллер
  late TextEditingController _controller;

  bool _isInit = false;
  late WineListProvider _provider;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_textListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //если приложение запущено впервые, то инициализируем данные
    if (!_isInit) {
      _provider = Provider.of<WineListProvider>(context);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  //слушатель для текстового поля
  void _textListener() {
    //если текстовое поле пустое, то очищаем поисковый список
    if (_controller.text.isEmpty) {
      _provider.clearList();
    }

    //иначе очищаем список найденных ранее элементов и ищем заново
    else {
      _provider.clearList();
      _provider.searchNotes(_controller.text);
    }
  }

  @override
  void dispose() {
    //очищаем список заметок (вызывая метод без notifyListener)
    _provider.clearDisposeList();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //поле для ввода текста для поиска
          CustomTextField(
            textHint: 'Поиск',
            prefixIcon: const Icon(Icons.search),
            controller: _controller,
            // isBack: true,
            isBack: false,
            function: widget.function,
          ),

          //выводим список найденных записей
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return WineNoteItem(
                  _provider.searchList[index],
                  isCanDelete: false,
                );
              },
              itemCount: _provider.searchList.length,
            ),
          ),
        ],
      ),
    );
  }
}
