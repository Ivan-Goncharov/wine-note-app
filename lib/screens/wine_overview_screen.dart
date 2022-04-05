import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/screens/search_wine_note.dart';

import '../widgets/wine_note_item.dart';
import 'edit_screens/edit_wine_screen.dart';

//Экран со всеми записями о вине

class WineOverViewScreen extends StatefulWidget {
  const WineOverViewScreen({Key? key}) : super(key: key);

  static const routNamed = 'wineOver_view';

  @override
  State<WineOverViewScreen> createState() => _WineOverViewScreenState();
}

class _WineOverViewScreenState extends State<WineOverViewScreen> {
  List<WineItem> wineList = [];

  //для определения запущено ли приложение
  var _isInt = true;
  //для загрузочного спиннера
  var _isLoading = false;

  ///переопредялем именно этот метод для доступа к контексту
  ///при первой инициализации приложения - извлекаем данные с сервера
  @override
  void didChangeDependencies() {
    _isInt = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все винные заметки'),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: wineList.length,
                    itemBuilder: (context, index) {
                      return WineNoteItem(wineList[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  ///вызов окна для создания новой заметки по нажатию плавающей кнопки
  Widget buildFloatingActionButton() => FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(EditWineScreen.routName),
      );
}
