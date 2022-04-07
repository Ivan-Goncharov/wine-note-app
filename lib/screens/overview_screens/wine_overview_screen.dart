import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/icons/my_custom_icons.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/screens/overview_screens/countries_overview.dart';
import 'package:flutter_my_wine_app/screens/search_wine_note.dart';

import '../../widgets/wine_note_item.dart';
import '../edit_screens/edit_wine_screen.dart';

//Экран со всеми записями о вине
class WineOverViewScreen extends StatefulWidget {
  const WineOverViewScreen({Key? key}) : super(key: key);

  static const routNamed = 'wineOver_view';

  @override
  State<WineOverViewScreen> createState() => _WineOverViewScreenState();
}

class _WineOverViewScreenState extends State<WineOverViewScreen> {
  late Size _size;
  late ColorScheme _colorScheme;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _size = MediaQuery.of(context).size;
      _colorScheme = Theme.of(context).colorScheme;
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все винные заметки'),

        //кнопка для перехода на экран с поиском винограда
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchWineNote.routName);
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, CountriesOverview.routName),
              child: _itemColumn(
                'Страны',
                MyCustomIcons.flag,
              ),
            ),
            _itemColumn(
              'Производители',
              MyCustomIcons.manufacturer,
            ),
            _itemColumn(
              'Сорта винограда',
              MyCustomIcons.grape,
            ),
            _itemColumn(
              'Год урожая',
              MyCustomIcons.calendar,
            ),
          ],
        ),
      ),
    );
  }

  // метод для создания одного элемента выбора сортировки
  // принимает название сортировки и иконку
  Widget _itemColumn(String title, IconData icon) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _colorScheme.secondaryContainer,
      ),
      width: double.infinity,
      height: _size.height * 0.17,
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: _colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: _colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
