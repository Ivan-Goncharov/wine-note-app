import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_list_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/detailed_expanded_notes.dart';

//Экран для полного описания вина
class WineFullDescripScreen extends StatefulWidget {
  static const routName = './wine_full_description';

  const WineFullDescripScreen({Key? key}) : super(key: key);

  @override
  State<WineFullDescripScreen> createState() => _WineFullDescripScreenState();
}

class _WineFullDescripScreenState extends State<WineFullDescripScreen> {
  @override
  Widget build(BuildContext context) {
    //в качестве аргумента - принимаем заметку о вине
    final wineNoteId = ModalRoute.of(context)?.settings.arguments as String;
    final wineNote = Provider.of<WineListProvider>(context, listen: true)
        .findById(wineNoteId);
    return Scaffold(
      appBar: AppBar(
        title: Text(wineNote.name),
        actions: [
          //кнопка "Удалить вино"
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return dialogCreate(context, wineNote.id!);
                },
              );
            },
            icon: const Icon(Icons.delete_forever),
          ),

          //кнопка "Изменить заметку"
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditWineScreen.routName,
                  arguments: wineNote.id);
            },
            icon: const Icon(Icons.create),
          ),
        ],
      ),
      body: Column(
        children: [
          //выводим изображение вина
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: wineNote.imageUrl.contains('asset')
                  ? Image(
                      image: AssetImage(
                        wineNote.imageUrl,
                      ),
                      width: MediaQuery.of(context).size.height * 0.35,
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Image.file(
                        File(wineNote.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),

          //выводим поочередно факты о вине
          DetailedExpanded(wineNote),
        ],
      ),
    );
  }

  //метод для создания диалога, который подтверждает удаление заметки
  //принимаем context и id удаляемой заметки
  Widget dialogCreate(BuildContext context, String id) {
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
                .deleteNote(id);

            Navigator.popUntil(
                context, ModalRoute.withName(TabsScreen.routName));
          },
          child: const Text('Да'),
        ),
      ],
    );
  }
}
