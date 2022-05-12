import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/wine_list_provider.dart';
import '../../screens/tabs_screen.dart';
import '../widgets/system_widget/app_bar.dart';
import '../widgets/system_widget/custom_showcase.dart';
import '../widgets/system_widget/wine_note_item.dart';
import '../widgets/system_widget/null_notes_message.dart';
import '../widgets/system_widget/switch_theme.dart';

//Экран для вывода последних 10 записей
class LastWineNote extends StatefulWidget {
  const LastWineNote({Key? key}) : super(key: key);

  @override
  State<LastWineNote> createState() => _LastWineNoteState();
}

class _LastWineNoteState extends State<LastWineNote> {
  //провайдер для получения списка заметок
  WineListProvider? _listProvider;
  //переменная для инициализации
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
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
        appBar: CustomAppBar(
          title: 'Последние заметки',
          listOfAction: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomShowCaseWidget(
                showCaseKey: TabsScreen.keySwitchTheme,
                widgetDescription: 'Смена темы приложения',
                widget: const SwitchThemeMode(),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),

          //выводим заметки на экран, если список пуст, то выводим сообщение
          child: _listProvider!.wineList.isEmpty
              ? const NullNotesMessage()
              : ListView.builder(
                  // возвращаем одну карту с кратким описанием заметки
                  itemBuilder: (context, index) {
                    return WineNoteItem(
                      _listProvider!.wineList[index],
                    );
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
