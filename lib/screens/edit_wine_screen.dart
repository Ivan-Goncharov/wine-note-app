import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/providers/wine_item_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'edit_screens/country_edit.dart';

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
  var _note = WineItemProvider(
    id: null,
    name: '',
    manufacturer: '',
    country: '',
    region: '',
    year: null,
    aroma: '',
    grapeVariety: '',
    taste: '',
    wineColors: '',
  );
  //ключ для сохранения form
  final _key = GlobalKey<FormState>();
  var _isLoading = false;

  String _countrySvgPath = '';

  //контроллер для TextField
  late TextEditingController _textFieldContoller;
  late double _containerHeight;

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
    _containerHeight = MediaQuery.of(context).size.height * 0.1;
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

    await DBProvider.instanse.create(_note);
    setState(() => _isLoading = false);
  }

  final _edgeInsets = const EdgeInsets.only(
    top: 15,
    left: 25,
    right: 25,
  );

  @override
  Widget build(BuildContext context) {
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
          : GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      //вызываем поочередно поля ввода данных для заметки
                      children: [
                        //название вина
                        inputContainer(textFormField: textFieldName()),

                        //Производитель вина
                        inputContainer(textFormField: textFieldManufacturer()),

                        // указываем цвета вина
                        inputContainer(textFormField: dropDownColorWine()),

                        // указываем год вина
                        yearPicker(context),

                        //Страна вина
                        searchDataContainer(context),

                        //Регион вина
                        inputContainer(textFormField: textFieldRegion()),

                        //Сорт винограда
                        inputContainer(textFormField: textFieldGrapeVariety()),

                        //Аромат вина
                        inputContainer(textFormField: textFieldAroma()),

                        //Вкус вина
                        inputContainer(textFormField: textFieldTaste()),

                        //Комментарий о вине
                        inputContainer(
                          textFormField: textFieldComment(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget yearPicker(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Выберите год"),
              content: Container(
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 50, 1),
                  lastDate: DateTime(DateTime.now().year, 1),
                  initialDate: DateTime.now(),
                  selectedDate: DateTime.now(),
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      _note = _note.copyWith(year: dateTime);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      }),
      child: buttonContainer(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Год урожая'),
            Text(_note.year?.year.toString() ?? ''),
          ],
        ),
      ),
    );
  }

  Container buttonContainer(BuildContext context, Widget child) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.08,
        margin: _edgeInsets,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        child: child);
  }

  Widget searchDataContainer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          CountryEdit.routName,
          arguments: _note.country,
        );
        if (result == null) {
          return;
        } else if (result is List<String>) {
          setState(() {
            _note = _note.copyWith(country: result[0]);
            _countrySvgPath = '';
          });
        } else {
          final map = (result as List)[0] as Map<String, String>;
          setState(() {
            _note = _note.copyWith(country: map['country']);
            _countrySvgPath = map['svg']!;
          });
        }
      },
      child: buttonContainer(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Страна'),
            Row(
              children: [
                Text(_note.country),
                _countrySvgPath.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SvgPicture.asset(
                            _countrySvgPath,
                            width: size.width * 0.05,
                            height: size.height * 0.05,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container inputContainer({required Widget textFormField}) {
    return Container(
      width: double.infinity,
      height: _containerHeight,
      padding: _edgeInsets,
      child: textFormField,
    );
  }

  TextFormField textFieldComment() {
    return TextFormField(
      decoration:
          createInputDecoration('Комментарий', 'Замечания о производителе'),
      initialValue: _note.comment,

      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(comment: value);
      },
    );
  }

  TextFormField textFieldTaste() {
    return TextFormField(
      decoration: createInputDecoration('Вкус', 'Опишите вкус вина'),
      initialValue: _note.taste,
      textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(taste: value);
      },
    );
  }

  TextFormField textFieldAroma() {
    return TextFormField(
      decoration: createInputDecoration('Аромат', 'Опишите аромат вина'),
      initialValue: _note.aroma,
      textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(aroma: value);
      },
    );
  }

  TextFormField textFieldGrapeVariety() {
    return TextFormField(
      decoration: createInputDecoration('Сорт', 'Укажите сорт винограда'),
      initialValue: _note.grapeVariety,
      textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(grapeVariety: value);
      },

      // проверяем правильность ввода
      validator: (value) {
        return textValidator(
          value,
          'Пожалуйста, укажите сорт винограда',
        );
      },
    );
  }

  TextFormField textFieldRegion() {
    return TextFormField(
      decoration:
          createInputDecoration('Регион', 'Укажите регион производителя'),
      initialValue: _note.region,
      textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(region: value);
      },
      // проверяем правильность ввода
      validator: (value) {
        return textValidator(
          value,
          'Пожалуйста, укажите регион производителя',
        );
      },
    );
  }

  TextFormField textFieldCountry() {
    return TextFormField(
      decoration:
          createInputDecoration('Страна', 'Введите страну производителя'),
      initialValue: _note.country,
      textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(country: value);
      },
      // проверяем правильность ввода
      validator: (value) {
        return textValidator(
          value,
          'Пожалуйста, введите страну производителя',
        );
      },
    );
  }

  DropdownButtonFormField<String> dropDownColorWine() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Цвет',
        hintText: "Укажите цвет винограда",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: _note.wineColors.isEmpty ? null : _note.wineColors,
      onChanged: (String? value) {
        setState(() {
          _note = _note.copyWith(wineColors: value);
        });
      },
      items: WineItemProvider.colorDopdownItems,
    );
  }

  TextFormField textFieldManufacturer() {
    return TextFormField(
      decoration: createInputDecoration(
          'Производитель вина', 'Введите производителя вина'),
      initialValue: _note.manufacturer,
      // textInputAction: TextInputAction.next,
      //сохраняем ввод в переменную name  и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(manufacturer: value);
      },
      // проверяем правильность ввода
      validator: (value) {
        return textValidator(
          value,
          'Пожалуйста, введите производителя вина',
        );
      },
    );
  }

  TextFormField textFieldName() {
    return TextFormField(
      decoration:
          createInputDecoration('Название вина', 'Введите название вина'),
      initialValue: _note.name,
      textInputAction: TextInputAction.next,

      //сохраняем ввод в переменную name и пересоздаем объект
      onSaved: (value) {
        _note = _note.copyWith(name: value);
      },
      // проверяем правильность ввода
      validator: (value) {
        return textValidator(
          value,
          'Пожалуйста, введите название вина',
        );
      },
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
