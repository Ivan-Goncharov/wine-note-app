import 'package:flutter/material.dart';

import '../models/wine_item.dart';
import '../icons/my_custom_icons.dart';

//виджет для вывода подробной информации о вине
class DetailedExpanded extends StatelessWidget {
  final WineItem wineNote;

  const DetailedExpanded(this.wineNote, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //выводим поочередно факты о вине
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            // название вина
            ItemColumnInfo(info: wineNote.name, icon: Icons.wine_bar),

            // производитель
            ItemColumnInfo(
                info: wineNote.manufacturer, icon: MyCustomIcons.manufacturer),

            // сорт
            ItemColumnInfo(
                info: wineNote.grapeVariety, icon: MyCustomIcons.grape),

            // год
            ItemColumnInfo(
              info: '${wineNote.year?.year ?? DateTime.now().year} г.',
              icon: MyCustomIcons.calendar,
            ),

            // Страна
            ItemColumnInfo(info: wineNote.country, icon: MyCustomIcons.flag),

            // регион
            ItemColumnInfo(info: wineNote.region, icon: Icons.map_outlined),

            // цвет вина
            ItemColumnInfo(info: wineNote.wineColors, icon: Icons.color_lens),

            // аромат
            ItemColumnInfo(info: wineNote.aroma, icon: MyCustomIcons.aroma),

            // вкус
            ItemColumnInfo(info: wineNote.taste, icon: MyCustomIcons.taste),

            // комментарий
            ItemColumnInfo(
              info: wineNote.comment,
              icon: Icons.comment_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

//виджет для вывода одного свойства заметки
class ItemColumnInfo extends StatelessWidget {
  //информация, заполненная пользователем
  final String info;

  //иконка свойства
  final IconData icon;
  const ItemColumnInfo({Key? key, required this.info, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //проверяем, заполнено ли свойство
    //если да, то выводим иконоку и информацию
    if (info.isNotEmpty) {
      return Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          child: LayoutBuilder(
            builder: (ctx, BoxConstraints constraints) {
              return Row(
                children: [
                  //иконка
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: constraints.maxWidth * 0.1,
                    child: Icon(
                      icon,
                      color: Theme.of(ctx).colorScheme.tertiary,
                    ),
                  ),

                  //информаця
                  SizedBox(
                    width: constraints.maxWidth * 0.9 - 5,
                    child: Text(
                      info,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );

      //если информация не заполнена, то ничего не выводим
    } else {
      return const SizedBox.shrink();
    }
  }
}
