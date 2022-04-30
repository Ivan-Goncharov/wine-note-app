import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_list_provider.dart';
import '../../models/wine_item.dart';
import '../../screens/edit_screens/text_field_container.dart';
import '../../screens/edit_screens/drop_down_colors.dart';
import '../../string_resourses.dart';
import '../../widgets/edit_wine/wine_year.dart';
import '../../widgets/edit_wine/search_country.dart';
import '../../widgets/edit_wine/searh_region.dart';
import '../../widgets/edit_wine/image_pick.dart';
import '../../widgets/edit_wine/search_manufactor.dart';
import '../../widgets/edit_wine/search_sort.dart';
import '../../widgets/system_widget/app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Добавить заметку',
        listOfAction: [
          IconButton(
            onPressed: () {
              _savedNotes();
            },
            icon: const Icon(Icons.save),
          ),
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
                        TextFieldInput(
                          initialValue: _note.name,
                          lableText: 'Название вина',
                          hintText: 'Введите название вина',
                          changeNote: (value) {
                            _note = _note.copyWith(name: value);
                          },
                          fieldAction: TextInputAction.next,
                        ),

                        //Производитель вина
                        SearchManufacturer(
                          manufName: _note.manufacturer,
                          changeName: changeManufactor,
                        ),

                        // указываем цвета вина
                        DropDownColor(
                          wineColor: _note.wineColors,
                          saveColor: (value) {
                            _note = _note.copyWith(wineColors: value);
                          },
                        ),

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
                        TextFieldInput(
                          initialValue: _note.aroma,
                          lableText: 'Аромат',
                          hintText: 'Опишите аромат вина',
                          changeNote: (value) {
                            _note = _note.copyWith(aroma: value);
                          },
                          fieldAction: TextInputAction.next,
                        ),

                        //Вкус вина
                        TextFieldInput(
                          initialValue: _note.taste,
                          lableText: 'Вкус',
                          hintText: 'Опишите вкус вина',
                          changeNote: (value) {
                            _note = _note.copyWith(taste: value);
                          },
                          fieldAction: TextInputAction.next,
                        ),

                        //Комментарий по заметке
                        TextFieldInput(
                          initialValue: _note.comment,
                          lableText: 'Комментарий',
                          hintText: 'Заметки о вине',
                          changeNote: (value) {
                            _note = _note.copyWith(comment: value);
                          },
                          fieldAction: TextInputAction.done,
                        ),
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
}
