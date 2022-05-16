import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/text_field_hint.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/toast_message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../models/wine_list_provider.dart';
import '../../models/wine_item.dart';
import '../../widgets/edit_wine/item_chapter_edit.dart';
import '../../widgets/edit_wine/text_field_container.dart';
import '../../screens/edit_screens/drop_down_colors.dart';
import '../../string_resourses.dart';
import '../../widgets/edit_wine/wine_year.dart';
import '../../widgets/edit_wine/text_fied_country.dart';
import '../../widgets/edit_wine/image_pick.dart';
import '../../widgets/edit_wine/search_sort.dart';
import '../tabs_screen.dart';

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
    price: 0.0,
    vendor: '',
    alcoPercent: 0.0,
    rating: 0.0,
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

  //переменная для инициализации
  var _isInit = true;

  // ввода страны и региона
  late String _countryName;
  late String _regionName;
  late String _imageUrl;

  //переменные для скрытия и расскрытия каждого раздела редкатирования
  bool _isVisGeneralInfo = false;
  bool _isVisMainFeatures = false;
  bool _isVisTasting = false;

  // тоаст
  late FToast _fToast;

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
      _imageUrl = _note.imageUrl;

      _fToast = FToast();
      _fToast.init(context);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => EditWineDialog(
              saveNote: _savedNote,
            ),
          ),
        ),
        title: const Text(
          'Добавить заметку',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _savedNote();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GestureDetector(
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                //вызываем поочередно поля ввода данных для заметки
                children: [
                  //выбор изображения для вина
                  WineImagePick(
                    // imagePath: _note.imageUrl,
                    imagePath: _imageUrl,
                    function: _changeImagePath,
                  ),

                  //общая информация о вине
                  ItemChapterEdit(
                    title: 'Общая информация о вине',
                    changeVisible: () {
                      setState(() => _isVisGeneralInfo = !_isVisGeneralInfo);
                    },
                  ),
                  Visibility(
                    visible: _isVisGeneralInfo,
                    child: Column(
                      children: [
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
                        TextInputWithHint(
                          fieldType: WineNoteFields.manufacturer,
                          changeData: _changeManufactor,
                          data: _note.manufacturer,
                          hintText: 'Введите название производителя',
                          title: 'Производитель',
                        ),

                        // указываем год вина
                        WineYear(
                          currentWineYear: _note.year,
                          changeDateNote: _changeWineDate,
                        ),

                        //Страна вина
                        TextFieldCountry(
                          countryName: _countryName,
                          func: _changeNoteCountry,
                        ),

                        //Регион вина
                        TextInputWithHint(
                          changeData: _changeNoteRegion,
                          fieldType: WineNoteFields.region,
                          data: _regionName,
                          hintText: 'Укажите регион',
                          countryName: _countryName,
                          title: 'Регион',
                        ),

                        //цена
                        TextFieldInput(
                          //если цена не указана, то передаем пустую строку
                          initialValue:
                              _note.price == 0.0 ? '' : _note.price.toString(),

                          //сохраняем данные
                          changeNote: (value) {
                            //преобразуем ввод в String
                            String winePrice = value.toString();

                            //если пользователь ввел вместо точки - запятую,
                            //меняем запятую на точку
                            if (winePrice.isEmpty) {
                              winePrice = '0.0';
                            } else if (winePrice.contains(',')) {
                              winePrice = winePrice.replaceAll(',', '.');
                            }

                            //парсимм значение в double и сохраняем в заметку
                            _note =
                                _note.copyWith(price: double.parse(winePrice));
                          },
                          fieldAction: TextInputAction.done,
                          hintText: 'Укажите стоимость вина',
                          lableText: 'Цена',
                          keyboardType: TextInputType.number,
                        ),

                        //поставщик
                        TextInputWithHint(
                          fieldType: WineNoteFields.vendor,
                          changeData: (vendor) {
                            _note = _note.copyWith(vendor: vendor);
                          },
                          data: _note.vendor,
                          hintText: 'Введите название поставщика',
                          title: 'Поставщик',
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  //Основные характеристики
                  ItemChapterEdit(
                    title: 'Основные характеристики',
                    changeVisible: () {
                      setState(() => _isVisMainFeatures = !_isVisMainFeatures);
                    },
                  ),
                  Visibility(
                    visible: _isVisMainFeatures,
                    child: Column(
                      children: [
                        // указываем цвета вина
                        DropDownColor(
                          wineColor: _note.wineColors,
                          saveColor: _changeWineColor,
                        ),

                        //Сорт винограда
                        // SearchGrapeSort(
                        //   sortName: _note.grapeVariety,
                        //   func: _changeGrapeSort,
                        // ),

                        TextInputWithHint(
                          fieldType: WineNoteFields.grapeVariety,
                          changeData: _changeGrapeSort,
                          data: _note.grapeVariety,
                          hintText: 'Выберите сорт винограда',
                          title: 'Сорт винограда',
                        ),

                        //алкоголь
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  //дегустационные впечатления
                  ItemChapterEdit(
                    title: 'Дегустационные впечатления',
                    changeVisible: () {
                      setState(() => _isVisTasting = !_isVisTasting);
                    },
                  ),
                  Visibility(
                    visible: _isVisTasting,
                    child: Column(
                      children: [
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

                        //рейтинг вина
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //сохраняет заметку о вине
  Future<void> _savedNote() async {
    //проверяем все ли обязательные пооя заполнены
    final isValid = _key.currentState!.validate();
    if (!isValid) return;
    _key.currentState!.save();

    // если id != null - значит мы редактировали заметку и должны ее обновить в списке
    // иначе создаем новую заметку
    if (_listProvider != null) {
      final date = DateTime.now();

      _note.creationDate = date;
      //если не присвоили изображение, то присваиваем дефолтное
      if (_note.imageUrl.isEmpty) {
        _note = _note.copyWith(imageUrl: 'assets/images/not_found_color.png');
      }
      if (_note.id != null) {
        //обновляем заметку и выводим соотвествующий тоаст
        _listProvider!.updateNote(_note);
        _fToast.showToast(
          child: const ToastMessage(
            message: 'Заметка обновлена',
            iconData: Icons.update_outlined,
          ),
        );
        //возвращаемся на экран с обзором заметки
        Navigator.pop(context);
      } else {
        //создаем новую заметку
        _listProvider!.addNote(_note);

        //выводим тоаст о том, что заметка создана
        _fToast.showToast(
          child: const ToastMessage(
            message: 'Заметка создана',
            iconData: Icons.check,
          ),
        );
        Navigator.of(context).popUntil(
          ModalRoute.withName(TabsScreen.routName),
        );
      }
    }
  }

  //метод для изменеия страны в заметке
  void _changeNoteCountry(String name) {
    setState(() {
      _note = _note.copyWith(country: name, region: '');
      _countryName = name;
      _regionName = '';
    });
  }

  //метод для изменения региона в заметке
  void _changeNoteRegion(String region) {
    _note = _note.copyWith(region: region);
    setState(() => _regionName = region);
    if (_note.country.isEmpty) {
      _countryName = Country.countryName(region);
      if (_countryName.isNotEmpty) {
        _note = _note.copyWith(country: _countryName);
      }
    }
  }

  //метод для изменения названия производителя
  void _changeManufactor(String newData) {
    setState(() {
      _note = _note.copyWith(manufacturer: newData);
    });
  }

  //метод для изменения даты в заметке
  void _changeWineDate(DateTime newDate) {
    _note = _note.copyWith(year: newDate);
  }

  //метод для изменения списка сортов винограда
  void _changeGrapeSort(String grapeName) {
    _note = _note.copyWith(grapeVariety: grapeName);
  }

  //метод для изменения пути изображения для вина
  void _changeImagePath(String path) {
    setState(() => _imageUrl = path);
    _note = _note.copyWith(imageUrl: path);
  }

  //метод для изменения цвета винограда
  //метод также меняет изображение, если оно не выбрано
  void _changeWineColor(String color) {
    _note = _note.copyWith(wineColors: color);
    if (_note.imageUrl.isEmpty || _note.imageUrl.contains('assets')) {
      _changeImagePath(_note.changeImage());
    }
  }
}

class EditWineDialog extends StatelessWidget {
  final Function saveNote;
  const EditWineDialog({Key? key, required this.saveNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выход'),
      content: const Text('Сохранить введенные данные?'),
      actions: [
        //Не сохранять
        TextButton(
          onPressed: (() {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
          child: const Text(
            'Нет',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //сохранять
        TextButton(
          onPressed: () => saveNote(),
          child: const Text(
            'Да',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
