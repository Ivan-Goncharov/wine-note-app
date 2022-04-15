import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/manuf_name_search.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/image_pick.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/search_manufactor.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/search_sort.dart';
import 'package:provider/provider.dart';

import '../../widgets/edit_wine/wine_year.dart';
import '../../models/wine_item.dart';
import '../../widgets/edit_wine/search_country.dart';
import '../../widgets/edit_wine/searh_region.dart';

//экран для добавления и редактирования записей о вине
class EditWineScreen extends StatefulWidget {
  const EditWineScreen({Key? key}) : super(key: key);

  //переменная для записи экрана в списке маршрутов навигации
  static const routName = './screen/edit_wine';

  @override
  State<EditWineScreen> createState() => _EditWineScreenState();
}

class _EditWineScreenState extends State<EditWineScreen> {
  // создаем заметку о вине с пустыми значениями
  WineItem _note = WineItem(
    id: null,
    name: '',
    manufacturer: '',
    country: '',
    region: '',
    year: DateTime.now(),
    creationDate: DateTime.now(),
    aroma: '',
    grapeVariety: '',
    taste: '',
    wineColors: '',
    imageUrl: '',
    comment: '',
  );

  //ключ для сохранения form
  final _key = GlobalKey<FormState>();

  //переменная для экрана загрузки
  var _isLoading = false;
  //переменная для инициализации
  var _isInit = true;

  //контроллер для TextField
  late TextEditingController _textManufactuerContr;
  late double _containerHeight;

  //переменные для изменения состояния виджетов
  // ввода страны и региона
  late String _countryName;
  late String _regionName;

  //провайдер для сохранения заметки
  WineListProvider? _listProvider;

  //передаем значение размера переменной для размера контейнера
  //инициализируем провайдер
  @override
  void didChangeDependencies() {
    //если еще не инициализировали заметку
    //то принимаем id заметки, если id передан - нам необходимо изменить существующую заметк
    // если id = null, то создаем новую заметку
    if (_isInit) {
      _containerHeight = MediaQuery.of(context).size.height * 0.1;
      _listProvider = Provider.of<WineListProvider>(context, listen: false);
      final String? noteId =
          ModalRoute.of(context)!.settings.arguments as String?;
      if (noteId != null) {
        _note = _listProvider!.findById(noteId);
      }

      //инициализируем переменные страны и региона, для вывода в поиске
      _countryName = _note.country;
      _regionName = _note.region;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  //сохраняет заметку о вине
  Future<void> _savedNotes() async {
    //проверяем все ли обязательные пооя заполнены
    final isValid = _key.currentState!.validate();
    if (!isValid) return;
    _key.currentState!.save();

    //для вывода экрана загрузки
    setState(() => _isLoading = true);

    // если id != null - значит мы редактировали заметку и должны ее обновить в списке
    // иначе создаем новую заметку
    if (_listProvider != null) {
      final date = DateTime.now();

      _note.creationDate = date;
      if (_note.id != null) {
        _listProvider!.updateNote(_note);
      } else {
        _listProvider!.addNote(_note);
      }
    }
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  //значения отсутпа для полей
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
              child: Container(
                padding: const EdgeInsets.only(bottom: 16.0),
                width: double.infinity,
                height: double.infinity,

                //используем Form для общей валидации
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    //при прокручивании полей убираем клавиатуру
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      //вызываем поочередно поля ввода данных для заметки
                      children: [
                        //выбор изображения для вина
                        WineImagePick(
                          imagePath: _note.imageUrl,
                          function: changeImagePath,
                        ),

                        //название вина
                        inputContainer(textFormField: textFieldName()),

                        //Производитель вина
                        SearchManufacturer(
                          manufName: _note.manufacturer,
                          changeName: changeManufactor,
                        ),

                        // указываем цвета вина
                        inputContainer(textFormField: dropDownColorWine()),

                        // указываем год вина
                        WineYear(
                          currentWineYear: _note.year,
                          changeDateNote: changeWineDate,
                        ),

                        //Страна вина
                        SearchCountry(
                          countryName: _countryName,
                          func: changeNoteCountry,
                        ),

                        //Регион вина
                        SearchRegion(
                          regionName: _regionName,
                          countryName: _countryName,
                          function: changeNoteRegion,
                        ),

                        //Сорт винограда
                        SearchGrapeSort(
                          sortName: _note.grapeVariety,
                          func: changeGrapeSort,
                        ),

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

  //метод для изменеия страны в заметке
  void changeNoteCountry(String name) {
    setState(() {
      _note = _note.copyWith(country: name, region: '');
      _countryName = name;
      _regionName = '';
    });
  }

  //метод для изменения региона в заметке
  void changeNoteRegion(String region) {
    _note = _note.copyWith(region: region);
    setState(() => _regionName = region);
    if (_note.country.isEmpty) {
      _countryName = Country.countryName(region);
      if (_countryName.isNotEmpty) {
        setState(() {
          _note = _note.copyWith(country: _countryName);
        });
      }
    }
  }

  //метод для изменения названия производителя
  void changeManufactor(String newData) {
    setState(() {
      _note = _note.copyWith(manufacturer: newData);
    });
  }

  //метод для изменения даты в заметке
  void changeWineDate(DateTime newDate) {
    _note = _note.copyWith(year: newDate);
  }

  //метод для изменения списка сортов винограда
  void changeGrapeSort(String grapeName) {
    _note = _note.copyWith(grapeVariety: grapeName);
  }

  //метод для изменения пути изображения для вина
  void changeImagePath(String path) {
    _note = _note.copyWith(imageUrl: path);
  }

  //контейнер для стилизации полей ввода
  //принимает поле ввода
  Container inputContainer({required Widget textFormField}) {
    return Container(
      width: double.infinity,
      height: _containerHeight,
      padding: _edgeInsets,
      child: textFormField,
    );
  }

  //поле ввода комментария
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

  //поле ввода вкуса
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

  //поле ввода аромата
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

  //раскрывающийся список цвета винограда
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
      items: WineItem.colorDopdownItems,
    );
  }

  //поле ввода названия производителя
  TextFormField textFieldManufacturer() {
    return TextFormField(
      decoration: createInputDecoration(
          'Производитель вина', 'Введите производителя вина'),
      controller: _textManufactuerContr,
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

  //поле ввода названия вина
  TextFormField textFieldName() {
    return TextFormField(
      decoration:
          createInputDecoration('Название вина', 'Введите название вина'),
      initialValue: _note.name,

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
    if (value!.length <= 2) {
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
