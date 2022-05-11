import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_overview_provider.dart';
import '../../models/wine_item.dart';
import '../../widgets/system_widget/custom_text_field.dart';
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
  //провайдер для работы с поиском совпадений в названии производителя
  late WineOverviewProvider _provider;

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
      _provider.searchData(_controller.text, true);
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
      _provider = Provider.of<WineOverviewProvider>(context);
      //запускаем метод, который создает список всех названий производителей в заметках
      _provider.createAllDataList(WineNoteFields.manufacturer);
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
                isBack: true,
                //передаем функцию, которая вызывается,
                //если пользователь нажал кнопку 'done' на клавиатуре
                saveInput: (value) {
                  Navigator.pop(context, [value]);
                },
              ),

              const SizedBox(height: 10),

              //если поле ввода пустое, то ничего не выводим на экран
              _controller.text.isEmpty
                  ? const SizedBox()

                  //проверка - пустой ли список поиска
                  : _provider.hintList.isEmpty
                      ? ButtonsInSearch(
                          saveInfo: _controller.text,
                        )

                      //если список не пустой, то выводим подсказку по вводу
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemHint(title: _provider.hintList[index]);
                            },
                            itemCount: _provider.hintList.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

//виджет для вывода одного элемента подсказки
class ItemHint extends StatelessWidget {
  //текст подсказки
  final String title;
  const ItemHint({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      child: GestureDetector(
        //при нажатии выбираем подсказку
        //и возвращаемся на экран редактирования заметки, передавая результат
        onTap: () => Navigator.pop(context, [title]),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
