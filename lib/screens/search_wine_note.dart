import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:flutter_my_wine_app/widgets/wine_note_item.dart';
import 'package:provider/provider.dart';

//экран для поиска винных заметок
class SearchWineNote extends StatefulWidget {
  static const routName = './searchWineNote';
  const SearchWineNote({Key? key}) : super(key: key);

  @override
  State<SearchWineNote> createState() => _SearchWineNoteState();
}

class _SearchWineNoteState extends State<SearchWineNote> {
  //контроллер
  late TextEditingController _controller;
  bool _isInit = false;
  late ColorScheme _colorScheme;
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
      _colorScheme = Theme.of(context).colorScheme;
      _provider = Provider.of<WineListProvider>(context);

      _isInit = true;
    }
    super.didChangeDependencies();
  }

  //слушатель для текстового поля
  void _textListener() {
    if (_controller.text.isEmpty) {
      _provider.clearList();
    } else {
      _provider.clearList();
      _provider.searchNotes(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_provider.searchList.length);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  //поле ввода текста для поиска
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 15),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Поиск',

                          prefixIcon: const Icon(Icons.search_rounded),

                          //кнопка удаления написанного текста
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear_outlined),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                        ),
                        controller: _controller,
                        autofocus: true,
                      ),
                    ),
                  ),

                  //кнопка для возврата на предыдущий экран
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отменить',
                      style: TextStyle(
                        fontSize: 15,
                        color: _colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return WineNoteItem(_provider.searchList[index]);
                  },
                  itemCount: _provider.searchList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
