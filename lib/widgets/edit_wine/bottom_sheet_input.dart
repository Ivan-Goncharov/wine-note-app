import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/edit_wine/button_search.dart';

//виджет, который открывается при вызове bottomSheet
//когда пользователь хочет ввести данные производителя, поставщика и так далее
class BottomSheetInputGeneral extends StatefulWidget {
  //список данных для подсказки
  final List<dynamic> list;
  //подсказка для текстового ввода
  final String hintText;
  //введенные до этого данные пользователем
  final String data;
  //переменная для отслеживания с каким поиском работаем
  //если поиск страны - то true
  //иначе - false
  final bool isCountry;

  const BottomSheetInputGeneral({
    Key? key,
    required this.list,
    required this.data,
    required this.hintText,
    required this.isCountry,
  }) : super(key: key);

  @override
  State<BottomSheetInputGeneral> createState() =>
      _BottomSheetInputGeneralState();
}

class _BottomSheetInputGeneralState extends State<BottomSheetInputGeneral> {
  //список, который заполняется при поиске
  List<dynamic> _searchList = [];
  //контроллер для ввода
  late final TextEditingController _controller;
  //данные по теме
  late final ThemeData _theme;
  //переменная для единоразовой загрузки данных
  bool _isInit = false;

  @override
  void initState() {
    //при первом создании выводятся все подсказки ввода
    _searchList.addAll(widget.list);
    _controller = TextEditingController();
    //инициализируем данные контроллера предыдущим вводом пользователя
    _controller.text = widget.data;

    //проверяем, с каким типом поиска работаем,
    //и добавляем слушатель, который соотвествует своему типа поиска
    if (widget.isCountry) {
      _controller.addListener(_listenerCountry);
    } else {
      _controller.addListener(_listenerNotCountry);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _theme = Theme.of(context);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  //слушатель, если рабоатем со страной
  void _listenerCountry() {
    // если поле пустое, то выводим все страны на экран
    if (_controller.text.isEmpty) {
      _searchList.clear();
      setState(() => _searchList.addAll(widget.list));
    }

    //если текст введен, то выполняем поиск
    else {
      _searchList.clear();
      List<dynamic> countriesList = [];
      //проходим по списку всех стран и если элемент содержит введенный текст,
      // то добавляем в список найденных элементов
      for (var country in widget.list) {
        if (country['country']!
            .toLowerCase()
            .contains(_controller.text.toLowerCase())) {
          countriesList.add(country);
        }
      }
      setState(() => _searchList = countriesList);
    }
  }

  //слушатель для текстового контроллера, если мы рабоатем не со страной
  void _listenerNotCountry() {
    //если слушатель пустой,
    //то очищаем предыдущий поиск и добавляем все данные в список
    if (_controller.text.isEmpty) {
      _searchList.clear();
      setState(() => _searchList.addAll(widget.list));
    }

    //если в текстовом поле есть данные
    else {
      _searchList.clear();
      final List<String> textSearch = [];

      //проходимся по списку данных и ищем совпадения
      for (var item in widget.list) {
        //если совпадение есть, то добавляем
        if (item.toLowerCase().contains(_controller.text.toLowerCase())) {
          textSearch.add(item);
        }
      }
      //заполняем поисковый список данными
      setState(() => _searchList = textSearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //при нажатии на экран - уюираем клавиатуру
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //поле для ввода текста
            TextField(
              controller: _controller,
              autofocus: true,
              //при сохранении через клавиатуру, отправляем данные на предыдущий экран
              onSubmitted: (value) {
                Navigator.pop(context, value);
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                enabledBorder: _inputBorder(_theme.colorScheme.onBackground),
                focusedBorder: _inputBorder(_theme.colorScheme.primary),
                labelStyle: _theme.textTheme.bodyMedium,
                hintStyle: TextStyle(
                  color: _theme.colorScheme.outline,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                //кнопка для удаления ввода
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _controller.clear(),
                ),
              ),
            ),

            //часть под полем для ввода

            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
                child: _searchList.isEmpty

                    //если список поиска пустой, то выводим кнопки для сохранения ввода
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ButtonsInSearch(saveInfo: _controller.text),
                      )

                    //если в списке есть данные, то выводим на экран
                    : ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) {
                          return InkWell(
                            //при нажатии на элемент, возвращаем его
                            onTap: () {
                              Navigator.pop(context, _searchList[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //провеярем с каким типом работаем и выводим подсказку на экран
                                widget.isCountry
                                    ? ItemHintCountry(
                                        element: _searchList[index])
                                    : ItemHintElement(
                                        element: _searchList[index],
                                      ),

                                const SizedBox(height: 8),
                                const Divider(height: 1),
                              ],
                            ),
                          );
                        },
                        itemCount: _searchList.length,
                      ),
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  //метод для создания рамки для ввода
  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}

//виджет для вывода одной подсказки
//подсказка является просто текстовым элементом
class ItemHintElement extends StatelessWidget {
  final String element;
  const ItemHintElement({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      element,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class ItemHintCountry extends StatelessWidget {
  //информация о стране
  final Map<String, dynamic> element;
  const ItemHintCountry({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      //по нажатию, возвращаемся на экран редактирования заметки
      //передаем страну
      onTap: () {
        Navigator.pop(context, element);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            //флаг страны
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.asset(
                element['svg']!,
                width: size.width * 0.05,
                height: size.height * 0.05,
              ),
            ),
            const SizedBox(width: 10),

            //название
            Text(
              element['country']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
