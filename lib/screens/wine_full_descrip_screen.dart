import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item.dart';
import 'package:flutter_my_wine_app/screens/tabs_screen.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/toast_message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/wine_list_provider.dart';
import '../screens/edit_screens/edit_wine_screen.dart';
// import '../screens/tabs_screen.dart';
import '../widgets/detailed_expanded_notes.dart';
import '../widgets/system_widget/app_bar.dart';

//Экран для полного описания вина
class WineFullDescripScreen extends StatefulWidget {
  static const routName = './wine_full_description';
  //принимаем id заметки
  final String wineNoteId;
  //тэг для hero анимации
  final String heroTag;
  // путь для обратной навигации при удалении заметки
  final String deleteRoutName;

  const WineFullDescripScreen({
    Key? key,
    required this.wineNoteId,
    required this.heroTag,
    required this.deleteRoutName,
  }) : super(key: key);

  @override
  State<WineFullDescripScreen> createState() => _WineFullDescripScreenState();
}

class _WineFullDescripScreenState extends State<WineFullDescripScreen> {
  //переменная для отслеживания - удалена ли заметка или нет
  bool _isInit = false;
  late final WineItem _wineNote;
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _wineNote = Provider.of<WineListProvider>(context, listen: true)
          .findById(widget.wineNoteId);
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _wineNote.name,
        listOfAction: [
          //кнопка "Удалить вино"
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteDialog(
                    id: _wineNote.id!,
                    deleteRoutName: widget.deleteRoutName,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete_forever,
              size: 30,
            ),
          ),

          //кнопка "Изменить заметку"
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditWineScreen.routName,
                arguments: _wineNote.id,
              );
            },
            icon: const Icon(
              Icons.create,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //выводим изображение вина
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                child: _wineNote.imageUrl.contains('assets')
                    ? Image(
                        image: AssetImage(
                          _wineNote.imageUrl,
                        ),
                        width: MediaQuery.of(context).size.height * 0.35,
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: LimitedBox(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                          child: Image.file(
                            File(_wineNote.imageUrl),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                tag: widget.heroTag,
              ),
            ),
          ),

          //выводим поочередно факты о вине
          DetailedExpanded(_wineNote),
        ],
      ),
    );
  }
}

//виджет диалога, который подтверждает удаление заметки
//принимаем  id удаляемой заметки
class DeleteDialog extends StatelessWidget {
  final String id;
  final String deleteRoutName;
  final FToast _fToast = FToast();
  DeleteDialog({Key? key, required this.id, required this.deleteRoutName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _fToast.init(context);
    return AlertDialog(
      title: const Text('Удаление заметки'),
      content: const Text('Желаете удалить заметку?'),
      actions: [
        //если пользователь не хочет удалят, возвращаемся на экран с обзором
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Нет'),
        ),

        //если подтверждает удаление, то удаляем заметку
        //и возвращаемся на экран с последними заметками
        TextButton(
          onPressed: () {
            Provider.of<WineListProvider>(context, listen: false)
                .deleteNote(id)
                .then((_) {
              _fToast.showToast(
                child: const ToastMessage(
                    message: 'Заметка удалена', iconData: Icons.delete),
              );

              Navigator.popUntil(
                  context, ModalRoute.withName(TabsScreen.routName));
            });
          },
          child: const Text('Да'),
        ),
      ],
    );
  }
}
