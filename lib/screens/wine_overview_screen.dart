import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/providers/wine_item_provider.dart';
import 'package:provider/provider.dart';

import '../providers/wine_notes_list_provider.dart';
import '../widgets/wine_note_item.dart';

//Экран со всеми записями о вине

class WineOverViewScreen extends StatefulWidget {
  const WineOverViewScreen({Key? key}) : super(key: key);

  static const routNamed = 'wineOver_view';

  @override
  State<WineOverViewScreen> createState() => _WineOverViewScreenState();
}

class _WineOverViewScreenState extends State<WineOverViewScreen> {
  List<WineItemProvider> wineList = [];

  //для определения запущено ли приложение
  var _isInt = true;
  //для загрузочного спиннера
  var _isLoading = false;

  ///переопредялем именно этот метод для доступа к контексту
  ///при первой инициализации приложения - извлекаем данные с сервера
  @override
  void didChangeDependencies() {
    if (_isInt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<WineNotesListProvider>(context).getAndFetchNotes().then(
        (_) {
          setState(
            () {
              _isLoading = false;
            },
          );
        },
      );
    }
    _isInt = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    wineList = Provider.of<WineNotesListProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все винные заметки'),
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
}
