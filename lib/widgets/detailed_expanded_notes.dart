import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/wine_item_provider.dart';
import '../icons/my_custom_icons.dart';

//виджет для вывода подробной информации о вине
class DetailedExpanded extends StatelessWidget {
  final WineItemProvider wineNote;

  DetailedExpanded(
    this.wineNote,
  );

// виджет - для одного элемента column с информацией
  Widget rowItemWidget(IconData icon, String? info, BuildContext ctx) {
    if (info!.isNotEmpty) {
      return Card(
        elevation: 6,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            child: LayoutBuilder(builder: (ctx, BoxConstraints constraints) {
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: constraints.maxWidth * 0.1,
                    child: Icon(icon),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.9 - 5,
                    child: Text(
                      info,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              );
            })),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    //выводим поочередно факты о вине
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            // название вина
            rowItemWidget(Icons.wine_bar, wineNote.name, context),
            // производитель
            rowItemWidget(
                MyCustomIcons.manufacturer, wineNote.manufacturer, context),
            // сорт
            rowItemWidget(MyCustomIcons.grape, wineNote.grapeVariety, context),
            // год
            rowItemWidget(MyCustomIcons.calendar, '${wineNote.year}', context),
            // Страна
            rowItemWidget(MyCustomIcons.flag, wineNote.country, context),
            // регион
            rowItemWidget(Icons.map_outlined, wineNote.region, context),
            // цвет вина
            rowItemWidget(Icons.color_lens, wineNote.wineColors, context),
            // аромат
            rowItemWidget(MyCustomIcons.aroma, wineNote.aroma, context),
            // вкус
            rowItemWidget(MyCustomIcons.taste, wineNote.taste, context),
            // комментарий
            rowItemWidget(Icons.comment_outlined, wineNote.comment, context),
          ],
        ),
      ),
    );
  }
}
