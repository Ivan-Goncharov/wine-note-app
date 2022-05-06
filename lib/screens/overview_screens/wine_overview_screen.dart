import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/toast_message.dart';

import '../../icons/my_custom_icons.dart';
import '../overview_screens/countries_overview.dart';
import '../../models/wine_item.dart';
import '../../screens/search_wine_note.dart';
import '../../screens/overview_screens/manufacturer_screen.dart';
import '../../widgets/system_widget/app_bar.dart';

//Экран со всеми записями о вине
class WineOverViewScreen extends StatefulWidget {
  const WineOverViewScreen({Key? key}) : super(key: key);

  static const routNamed = 'wineOver_view';

  @override
  State<WineOverViewScreen> createState() => _WineOverViewScreenState();
}

class _WineOverViewScreenState extends State<WineOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Все заметки',
        listOfAction: [
          //переход на экран с поиском заметок
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchWineNote.routName);
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // кнопка со страной, по тапу - переходим на экран со всеми странами,
            // которые представлены в заметках
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, CountriesOverview.routName),
              child: const ItemColumn(
                icon: MyCustomIcons.flag,
                title: 'Страны',
              ),
            ),

            //кнопка для перехода на экран с производителями
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                ManufactOverviewScreen.routName,
                arguments: WineNoteFields.manufacturer,
              ),
              child: const ItemColumn(
                icon: MyCustomIcons.manufacturer,
                title: 'Производители',
              ),
            ),

            //кнопка для перехода на экран с производителями
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                ManufactOverviewScreen.routName,
                arguments: WineNoteFields.grapeVariety,
              ),
              child: const ItemColumn(
                icon: MyCustomIcons.grape,
                title: 'Сорта винограда',
              ),
            ),
          ],
        ),
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
