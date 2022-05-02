import 'package:flutter/material.dart';

import 'button_container.dart';
import '../../screens/edit_screens/manuf_name_search.dart';

//виджет для ввода открытия страницы - ввода названия производителя
class SearchManufacturer extends StatefulWidget {
  final String manufName;
  final Function changeName;
  const SearchManufacturer({
    Key? key,
    required this.manufName,
    required this.changeName,
  }) : super(key: key);

  @override
  State<SearchManufacturer> createState() => _SearchManufacturerState();
}

class _SearchManufacturerState extends State<SearchManufacturer> {
  //переменная для хранения полученных данных о названии производителя
  String _manufName = '';

  @override
  void initState() {
    _manufName = widget.manufName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        //при нажатии - переходим на экран с вводом названия производителя
        final result = await Navigator.pushNamed(
            context, ManufSearchName.routName,
            arguments: _manufName);

        //принимаем результат возврата на экран
        if (result == null) {
          return;
        } else {
          setState(() {
            _manufName = (result as List<dynamic>)[0];
            widget.changeName(_manufName);
          });
        }
      },

      //выводим информацию о производителе
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Производитель',
              style: _theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 10),

            //производитель
            Expanded(
              child: Text(
                _manufName,
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
