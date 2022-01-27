import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/providers/wine_item_provider.dart';
import 'package:flutter_my_wine_app/providers/wine_notes_list_provider.dart';
import 'package:flutter_my_wine_app/screens/tabs_screen.dart';
import 'package:flutter_my_wine_app/screens/wine_overview_screen.dart';
import 'package:provider/provider.dart';

import 'wine_full_descrip_screen.dart';

//экран для добавления и редактирования записей о вине
class EditWineScreen extends StatefulWidget {
  const EditWineScreen({Key? key}) : super(key: key);

  //переменная для записи экрана в списке маршрутов навигации
  static const routName = './screen/edit_wine';

  @override
  State<EditWineScreen> createState() => _EditWineScreenState();
}

class _EditWineScreenState extends State<EditWineScreen> {
  // создаем заметку о вине с дефолтными значениями
  var _notes = WineItemProvider(
    id: null,
    name: '',
    manufacturer: '',
    country: '',
    region: '',
    year: '',
    aroma: '',
    grapeVariety: '',
    taste: '',
    wineColors: '',
  );
  //ключ для сохранения form
  final _key = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;

  //контроллер для TextField
  late TextEditingController _textFieldContoller;

  @override
  void initState() {
    _textFieldContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldContoller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final noteId = ModalRoute.of(context)?.settings.arguments;
      if (noteId != null) {
        _notes = Provider.of<WineNotesListProvider>(context, listen: false)
            .findById(noteId.toString());
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

//сохраняет заметку о вине
  Future<void> _savedNotes() async {
    //проверяем все ли обязательные пооя заполнены
    final isValid = _key.currentState!.validate();
    if (!isValid) return;
    _key.currentState!.save();

    //для вывода экрана загрузки, пока сохраняется
    setState(() {
      _isLoading = true;
    });

    //если заметка c таким id есть, то обновляем ее
    if (_notes.id != null) {
      await Provider.of<WineNotesListProvider>(context, listen: false)
          .updateProduct(_notes.id, _notes);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);

      //Если заметки такой еще нет, то добавляем ее
    } else {
      try {
        await Provider.of<WineNotesListProvider>(context, listen: false)
            .addNotes(_notes);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occured!'),
            content: const Text('Something went wrong'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.only(
      top: 15,
      left: 25,
      right: 25,
    );

    var containerHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить заметку'),
        actions: [
          IconButton(
            onPressed: () {
              _savedNotes();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Form(
                key: _key,
                child: ListView(
                  //вызываем поочередно поля ввода данных для заметки
                  children: [
                    //название вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Название вина', 'Введите название вина'),
                        initialValue: _notes.name,
                        // textInputAction: TextInputAction.next,

                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(name: value);
                        },
                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, введите название вина',
                          );
                        },
                      ),
                    ),

                    //Производитель вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Производитель вина', 'Введите производителя вина'),
                        initialValue: _notes.manufacturer,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(manufacturer: value);
                        },
                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, введите производителя вина',
                          );
                        },
                      ),
                    ),

                    // указываем цвета вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Цвет',
                          hintText: "Укажите цвет винограда",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: _notes.wineColors!.isEmpty
                            ? null
                            : _notes.wineColors,
                        onChanged: (String? value) {
                          setState(() {
                            _notes = _notes.copyWith(wineColors: value);
                          });
                        },
                        items: WineItemProvider.colorDopdownItems,
                      ),
                    ),

                    // указываем год вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Год урожая', 'Укажите, год урожая'),
                        initialValue: _notes.year,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(year: value);
                        },
                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, укажите год урожая',
                          );
                        },
                      ),
                    ),

                    //Страна вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Страна', 'Введите страну производителя'),
                        initialValue: _notes.country,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(country: value);
                        },
                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, введите страну производителя',
                          );
                        },
                      ),
                    ),

                    //Регион вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Регион', 'Укажите регион производителя'),
                        initialValue: _notes.region,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(region: value);
                        },
                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, укажите регион производителя',
                          );
                        },
                      ),
                    ),

                    //Сорт винограда
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Сорт', 'Укажите сорт винограда'),
                        initialValue: _notes.grapeVariety,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(grapeVariety: value);
                        },

                        // проверяем правильность ввода
                        validator: (value) {
                          return textValidator(
                            value,
                            'Пожалуйста, укажите сорт винограда',
                          );
                        },
                      ),
                    ),

                    //Аромат вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Аромат', 'Опишите аромат вина'),
                        initialValue: _notes.aroma,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(aroma: value);
                        },
                      ),
                    ),

                    //Вкус вина
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration:
                            createInputDecoration('Вкус', 'Опишите вкус вина'),
                        initialValue: _notes.taste,
                        // textInputAction: TextInputAction.next,
                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(taste: value);
                        },
                      ),
                    ),

                    //Комментарий о вине
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      padding: edgeInsets,
                      child: TextFormField(
                        decoration: createInputDecoration(
                            'Комментарий', 'Замечания о производителе'),
                        initialValue: _notes.comment,

                        //сохраняем ввод в переменную name  и пересоздаем объект
                        onSaved: (value) {
                          _notes = _notes.copyWith(comment: value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

// валидатор для проверки правильности ввода
  String? textValidator(String? value, String message) {
    if (value!.length <= 3) {
      return message;
    } else {
      return null;
    }
  }

// внешний вид поля для ввода информации о вине
  InputDecoration createInputDecoration(String dataLable, dataHint) {
    return InputDecoration(
      labelText: dataLable,
      hintText: dataHint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
