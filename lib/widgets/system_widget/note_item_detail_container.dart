import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/wine_item.dart';

//виджет для вывода основных данных о заметке в обзорной карточке о вине
// (на экране со всеми винными  карточками)
class WineNoteItemDetail extends StatelessWidget {
  final String heroTag;
  final WineItem wineNote;
  const WineNoteItemDetail(
      {Key? key, required this.heroTag, required this.wineNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: size.height * 0.1,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          //изображение заметки
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: heroTag,
                child: wineNote.imageUrl.contains('assets')
                    ? Image.asset(
                        wineNote.imageUrl,
                      )
                    : Image.file(
                        File(wineNote.imageUrl),
                      ),
              ),
            ),
          ),

          //текстовые данные
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //название и год
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LimitedBox(
                      maxWidth: size.width * 0.34,
                      child: Text(
                        wineNote.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '${wineNote.year!.year} г. ',
                        style: TextStyle(
                            color: colors.onSecondaryContainer,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),

                //производитель и регион
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    wineNote.manufacturer.isNotEmpty
                        ? LimitedBox(
                            maxWidth: size.width * 0.4,
                            child: Text(
                              '${wineNote.manufacturer}, ',
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  color: colors.onSecondaryContainer,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          )
                        : const SizedBox(),
                    wineNote.region.isNotEmpty
                        ? Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                wineNote.region,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                style: TextStyle(
                                    color: colors.onSecondaryContainer,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),

          //цвет вина в виде круга с соотвествующим цветом
          //проверяем - указал ли пользователь цвет
          wineNote.wineColors.isEmpty
              ? const SizedBox()
              : Container(
                  width: size.width * 0.09,
                  decoration: BoxDecoration(
                    color: getColor(wineNote.wineColors),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.onSecondaryContainer,
                      width: 0.7,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // фоновый цвет вкладки, взависимости от вина
  Color getColor(String? wineColor) {
    switch (wineColor) {
      case 'Красное':
        return Colors.red;
      case 'Оранжевое':
        return Colors.orange;
      case 'Розовое':
        return const Color.fromRGBO(255, 192, 203, 1);
      default:
        return Colors.white70;
    }
  }
}
