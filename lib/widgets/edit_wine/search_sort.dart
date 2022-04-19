import 'package:flutter/material.dart';

import '../../screens/edit_screens/wine_sort.dart';
import 'button_container.dart';

//виджет для вывода элемента в экране изменения данных о вине
//выводит cорт винограда
class SearchGrapeSort extends StatefulWidget {
  //принимаем названия сортов и функцию для изменения данных в заметке
  final String sortName;
  final Function func;
  const SearchGrapeSort({
    Key? key,
    required this.sortName,
    required this.func,
  }) : super(key: key);

  @override
  State<SearchGrapeSort> createState() => _SearchGrapeSortState();
}

class _SearchGrapeSortState extends State<SearchGrapeSort> {
  //переменная для хранения полученных данных о выбранных сортах винограда
  String _sortName = '';

  @override
  void initState() {
    _sortName = widget.sortName;
    super.initState();
  }

  //метод для создания списка из названий выбранных сортов
  List<String> _createListSort() {
    //если еще не выбраны, то возвращаем пустой список
    if (_sortName.isEmpty) {
      return [];
    }

    //если в списке сортов больше одного элемента,
    //то делим строку на элементы и возвращаем список
    else if (_sortName.contains(', ')) {
      return _sortName.split(', ');
    }

    //если выбран один сорт, то возврщаем список с одним элементом
    else {
      return [_sortName];
    }
  }

  //метод для создания строки из списка
  //принимает список сортов
  String parseListGrapeSort(List<String> list) {
    String grapeSorts = '';
    for (var sort in list) {
      grapeSorts += '$sort, ';
    }
    //убираем у последнего элемента запятую
    grapeSorts = grapeSorts.substring(0, grapeSorts.length - 2);
    return grapeSorts;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //при нажатии - открываем страницу с сортами винограда
        //передаем список сортов, если пользователь их выбрал до этого
        final result = await Navigator.pushNamed(
            context, WineSortScreen.routName,
            arguments: _createListSort());

        //принимаем результат возврата на экран
        if (result == null) {
          return;
        } else {
          final List<String> listSorts = (result as List)[0] as List<String>;

          //если список сортов не пустой, то создаем строку из списка
          if (listSorts.isNotEmpty) {
            setState(() => _sortName = parseListGrapeSort(listSorts));
          }
          //если пользователь решил удалить выбранные сорта и вернуться на экран ввода,
          //то назначаем переменной пустое значение
          else {
            setState(() => _sortName = '');
          }

          //меняем сорт в заметке
          widget.func(_sortName);
        }
      },

      //выводим информацию о сорте на экран
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Сорт винограда'),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _sortName,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
