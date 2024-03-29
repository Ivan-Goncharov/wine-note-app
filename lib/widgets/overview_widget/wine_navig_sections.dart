import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../icons/my_custom_icons.dart';
import '../../models/wine_item.dart';
import '../../models/wine_database_provider.dart';
import '../../units/overview_screens/countries_overview.dart';
import '../../units/overview_screens/manuf_grape_overview.dart';
import '../system_widget/null_notes_message.dart';

//виджет для вывода навигационных панелей по вину
//навигация по стране, производителю, сорту винограда
class WineNavigatSections extends StatelessWidget {
  const WineNavigatSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Provider.of<WineDatabaseProvider>(context).wineList.isEmpty
          ? const NullNotesMessage()
          : Column(
              children: [
                // кнопка со страной, по тапу - переходим на экран со всеми странами,
                // которые представлены в заметках
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, CountriesOverview.routName),
                    child: const ItemColumn(
                      icon: MyCustomIcons.flag,
                      title: 'Страны',
                    ),
                  ),
                ),

                //кнопка для перехода на экран с производителями
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ManufGrapeOverviewScreen.routName,
                      arguments: WineNoteFields.manufacturer,
                    ),
                    child: const ItemColumn(
                      icon: MyCustomIcons.manufacturer,
                      title: 'Производители',
                    ),
                  ),
                ),

                //кнопка для перехода на экран с производителями
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ManufGrapeOverviewScreen.routName,
                      arguments: WineNoteFields.grapeVariety,
                    ),
                    child: const ItemColumn(
                      icon: MyCustomIcons.grape,
                      title: 'Сорта винограда',
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// виджет для создания одного элемента выбора сортировки
// принимает название сортировки и иконку
class ItemColumn extends StatelessWidget {
  final IconData icon;
  final String title;

  const ItemColumn({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
