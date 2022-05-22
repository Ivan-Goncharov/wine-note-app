import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/wine_item.dart';
import '../../widgets/system_widget/toast_message.dart';

//виджет нижней панели с фильтрами по цвету вина в заметке
class ColorsBotoomsheet extends StatefulWidget {
  //принимает функцию для сохранения выбора и переменную, которая хранит выбранное значение
  final Function saveColor;
  final String selectColor;
  const ColorsBotoomsheet(
      {Key? key, required this.saveColor, required this.selectColor})
      : super(key: key);

  @override
  State<ColorsBotoomsheet> createState() => _ColorsBotoomsheetState();
}

class _ColorsBotoomsheetState extends State<ColorsBotoomsheet> {
  //переменная для изменения текущего значения переменной
  late String _selectColor = '';
  late Size _size;
  late ColorScheme _colorScheme;
  late FToast _fToast;
  bool _isInit = false;

  @override
  void initState() {
    _selectColor = widget.selectColor;
    _fToast = FToast();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _colorScheme = Theme.of(context).colorScheme;
      _size = MediaQuery.of(context).size;
      _fToast.init(context);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //получаем размеры и цветовую схему

    return Container(
      height: _size.height * 0.25,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colorScheme.surfaceVariant,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(child: Container()),
                //заголовок
                Expanded(
                  child: Text(
                    'Цвет вина',
                    style: TextStyle(
                      color: _colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),

                //кнопка для сброса выбора фильтра
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectColor = '';
                        widget.saveColor(
                            WineNoteFields.wineColors, _selectColor);
                      });
                    },
                    child: Text(
                      'Очистить',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: _colorScheme.tertiary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //выводим все цвета вина
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: [
                createTextWidget(title: 'Красное'),
                createTextWidget(title: 'Белое'),
                createTextWidget(title: 'Оранжевое'),
                createTextWidget(title: 'Розовое'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //один контейнер для вывода цвета
  Widget createTextWidget({required String title}) {
    return GestureDetector(
      onTap: () {
        //если цвет уже выбран, то снимаем выбор
        if (_selectColor == title) {
          setState(() => _selectColor = '');
          widget.saveColor(WineNoteFields.wineColors, _selectColor);
        }
        //если цвет еще не выбран, то выбираем
        else {
          setState(() => _selectColor = title);
          //вызываем функцию для изменения замток на экране
          widget.saveColor(WineNoteFields.wineColors, _selectColor);
          Navigator.pop(context);

          //показываем сообщение о том, что фильтрация успешна
          _fToast.showToast(
            child: ToastMessage(
                message:
                    'На экране заметки с \n ${_createToastMessage(_selectColor)} вином',
                iconData: Icons.tune),
          );
        }
      },
      child: Container(
        height: _size.height * 0.05,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          //цвет рамки зависит от того, выбран ли этот цвет вина
          border: Border.all(
            color: title == _selectColor
                ? _colorScheme.primary
                : _colorScheme.onSurfaceVariant,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            //цвет текст зависит от того - выбрана ли этот цвет вина или нет
            color: title == _selectColor
                ? _colorScheme.primary
                : _colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  //метод для создания сообщения тоста
  //принимает цвет винограда
  String _createToastMessage(String wineColor) {
    switch (wineColor) {
      case 'Белое':
        return 'белым';
      case 'Розовое':
        return 'розовым';
      case 'Оранжевое':
        return 'оранжевым';
      default:
        return 'красным';
    }
  }
}
