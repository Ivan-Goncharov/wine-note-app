import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../screens/wine_full_descrip_screen.dart';
import '../../models/wine_list_provider.dart';
import '../../models/wine_item.dart';
import '../../widgets/system_widget/note_item_detail_container.dart';
import '../../widgets/system_widget/toast_message.dart';

//виджет для отображения одного элемента в списке вин
class WineNoteItem extends StatelessWidget {
  //принимаем через конструктор нашу заметку о вине
  final WineItem wineNote;
  // путь для возврата, после удаления заметки
  final String routName;

  const WineNoteItem(this.wineNote, this.routName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fToast = FToast();
    fToast.init(context);

    //тэг для анимированного перехода на экран с описанием заметки
    final heroTag = '${wineNote.id} ${DateTime.now().toIso8601String()}';
    if (wineNote.imageUrl.isEmpty) {
      wineNote.imageUrl = wineNote.changeImage();
    }

    //карточка со слайдом влево для удаления заметки
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: const ErrorContainer(),

      //если пользователь выбирает в диалоге удаление элемента,
      //то удаляем заметку и показываем соотвествующее сообщение
      onDismissed: (_) {
        Provider.of<WineListProvider>(context, listen: false).deleteNote(
          wineNote.id!,
        );
        fToast.showToast(
          child: const ToastMessage(
              message: 'Заметка удалена', iconData: Icons.delete),
        );
      },

      //открывается даилог при слайде от конца к началу карточки
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Удаление заметки'),
              content: const Text('Желаете удалить заметку ?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Нет'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Да'),
                ),
              ],
            );
          },
        );
      },
      child: GestureDetector(
        //переходим на экран с подробным описанием заметки
        //передаем id заметки и тэг для hero анимации
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) {
              return WineFullDescripScreen(
                deleteRoutName: routName,
                heroTag: heroTag,
                wineNoteId: wineNote.id!,
              );
            }),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        ),
        //выводим детальные данные о заметке
        child: WineNoteItemDetail(heroTag: heroTag, wineNote: wineNote),
      ),
    );
  }
}

//Контейнер для фона Dissmisable
class ErrorContainer extends StatelessWidget {
  const ErrorContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.onError,
        size: 30,
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(8.0),
    );
  }
}
