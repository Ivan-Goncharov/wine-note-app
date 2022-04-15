import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/app_bar.dart';
import 'package:flutter_my_wine_app/widgets/wine_note_item.dart';
import 'package:provider/provider.dart';

//Экран для вывода последних 10 записей
class LastWineNote extends StatefulWidget {
  const LastWineNote({Key? key}) : super(key: key);

  @override
  State<LastWineNote> createState() => _LastWineNoteState();
}

class _LastWineNoteState extends State<LastWineNote> {
  //провайдер для получения списка заметок
  WineListProvider? _listProvider;
  late ColorScheme _colorScheme;
  //переменная для инициализации
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _colorScheme = Theme.of(context).colorScheme;
      createNoteList(context);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  //создаем экземпляр провайдера и получаем все заметки из базы данных
  void createNoteList(BuildContext context) async {
    _listProvider = Provider.of<WineListProvider>(context);
    _listProvider!.fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Последние заметки'),
        backgroundColor: _colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

          //выводим заметки на экран, если список пуст, то выводим сообщение
          child: _listProvider!.wineList.isEmpty
              ? const Center(
                  child: Text('Вы не добавили ни одной заметки'),
                )
              : ListView.builder(
                  // возвращаем одну карту с кратким описанием заметки
                  itemBuilder: (context, index) {
                    return WineNoteItem(_listProvider!.wineList[index]);
                  },

                  // длина списка должна быть не больше 10
                  itemCount: _listProvider!.wineList.length > 10
                      ? 10
                      : _listProvider!.wineList.length,
                ),
        ),
      ),
    );
  }
}
