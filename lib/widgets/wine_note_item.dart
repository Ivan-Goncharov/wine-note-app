import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/providers/wine_notes_list_provider.dart';
import 'package:flutter_my_wine_app/screens/wine_full_descrip_screen.dart';
import 'package:provider/provider.dart';

import '../providers/wine_item_provider.dart';

//виджет для отображения одного элемента в списке вин
class WineNoteItem extends StatelessWidget {
  //принимаем через конструктор нашу заметку о вине
  final WineItemProvider wineNote;
  WineNoteItem(this.wineNote);

// фоновый цвет вкладки, взависимости от вина
  Color getColor(String? wineColor) {
    switch (wineColor) {
      case 'Красное':
        return Colors.red.shade400;
      case 'Оранжевое':
        return Colors.orange.shade400;
      case 'Розовое':
        return Colors.red.shade200;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    //если пользователь не задал изображение для заметки,
    //то добавляем автоматически, взаивисимости от цвета вина
    if (wineNote.imageUrl.isEmpty) {
      Provider.of<WineNotesListProvider>(context)
          .changeImage(wineNote.id, wineNote.wineColors);
    }

    //SnackBAr на случай ошибки соединения с сервером
    final _scaffoldMessange = ScaffoldMessenger.of(context);

    return Dismissible(
      key: ValueKey(wineNote.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Вы уверены?"),
            content: const Text("Вы хотите удалить данную запись"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      //удаляем заметку, если подтвердили удаление,
      //но обрабатываем ошибку, которая может возникнуть из-за связи с сервером
      //если связи нет, то отменяем удаление и выводим snackbar
      onDismissed: (direction) async {
        try {
          await Provider.of<WineNotesListProvider>(context, listen: false)
              .removeNote(wineNote.id);
        } catch (_) {
          _scaffoldMessange.showSnackBar(
            const SnackBar(
              content: Text("Не удалось удалить заметку"),
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        //меняем цвет карты, в зависимости от вина
        color: getColor(wineNote.wineColors),
        child: ListTile(
          //по нажатию на карточку, открырвается полное описание
          onTap: () {
            Navigator.of(context)
                .pushNamed(WineFullDescripScreen.routname, arguments: wineNote);
          },

          leading: SizedBox(
            width: 50,
            height: 100,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                wineNote.imageUrl,
              ),
            ),
          ),
          title: Text(
            '${wineNote.name}, ${wineNote.year}г.',
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            '${wineNote.manufacturer}, ${wineNote.region}',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
