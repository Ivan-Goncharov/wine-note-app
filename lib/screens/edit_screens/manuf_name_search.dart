import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/edit_wine/button_search.dart';

//экран для ввода названия производиля
class ManufSearchName extends StatefulWidget {
  static const routName = './manuf';
  const ManufSearchName({Key? key}) : super(key: key);

  @override
  State<ManufSearchName> createState() => _ManufSearchNameState();
}

class _ManufSearchNameState extends State<ManufSearchName> {
  //данные о производители, которые пользователь вводил до этого
  late String _oldData = '';
  //переменная для инициализации
  bool _isInit = false;
  //контроллер для отслеживания ввода текста
  late TextEditingController _controller;
  //список предыдущих производителей, для подсказки
  // List<String> _recentInput = [];
  //провайдер для работы с поиском совпадений в названии производителя
  late WineListProvider _provider;

  //инициализируем контроллер и подключаем слушатель
  @override
  void initState() {
    _controller = TextEditingController();

    _controller.addListener(listener);
    super.initState();
  }

  // слушатель для текстового поля
  void listener() {
    //если текстовое поле не пустое - ищем совпадения в заметках
    if (_controller.text.isNotEmpty) {
      _provider.searchManufact(_controller.text);
    }

    //иначе  - очищаем список регионов
    else {
      _provider.clearManufactList();
    }
  }

  //инициализируем наши данные
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _oldData = ModalRoute.of(context)!.settings.arguments as String;
      _controller.text = _oldData;
      _provider = Provider.of<WineListProvider>(context);
      //запускаем метод, который создает список всех названий производителей в заметках
      _provider.createManufactList();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //отключаем контроллер для текста
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //поле ввода названия производителя
              CustomTextField(
                textHint: 'Производитель',
                controller: _controller,
              ),

              const SizedBox(height: 10),

              //если поле ввода пустое, то ничего не выводим на экран
              _controller.text.isEmpty
                  ? const SizedBox()

                  //проверка - пустой ли список поиска
                  : _provider.manufactSearch.isEmpty
                      ? ButtonsInSearch(
                          onSave: () {
                            Navigator.pop(context, [_controller.text]);
                          },
                          onBack: () {
                            Navigator.pop(context);
                          },
                        )

                      //если список не пустой, то выводим подсказку по вводу
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Text(_provider.manufactSearch[index]);
                            },
                            itemCount: _provider.manufactSearch.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
