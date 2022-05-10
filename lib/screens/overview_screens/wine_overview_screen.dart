import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/widgets/overview_widget/wine_navig_sections.dart';
import 'package:provider/provider.dart';

import 'manuf_grape_screen.dart';
import '../overview_screens/countries_overview.dart';
import '../../icons/my_custom_icons.dart';
import '../../models/wine_item.dart';
import '../../models/wine_list_provider.dart';
import '../../screens/search_wine_note.dart';
import '../../widgets/system_widget/null_notes_message.dart';

//Экран со всеми записями о вине
class WineOverViewScreen extends StatefulWidget {
  const WineOverViewScreen({Key? key, required this.hideBottomBar})
      : super(key: key);

  //принимает функцию, которая вызывается при нажатии кнопки поиска
  //скрывает bottomBar
  final Function hideBottomBar;
  static const routNamed = 'wineOver_view';

  @override
  State<WineOverViewScreen> createState() => _WineOverViewScreenState();
}

class _WineOverViewScreenState extends State<WineOverViewScreen> {
  //переменная для отслеживания - какой виджет на экране
  // true - виджет поиска заметок
  // false - виджет навигации по заметкам
  bool _isSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          //проверяем какой виджет открыт на данный момент
          appBar: _isSearch

              //если поиск, то скрываем appBar
              ? const PreferredSize(
                  child: SizedBox(), preferredSize: Size(0.0, 0.0))

              //если виджет навигации по разделам
              : AppBar(
                  title: const Text(
                    'Все заметки',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  actions: [
                    //кнопка поиска заметок - скрывает bottomBar и меняет виджет на экране
                    IconButton(
                      onPressed: () {
                        widget.hideBottomBar(true);
                        setState(
                          () => _isSearch = true,
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                  ],
                ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: _isSearch

              //виджет поиска
              //передаем функцию, которая вызывется при нажатии кнопки отмена
              ? SearchWineNote(
                  function: () {
                    setState(() {
                      //показываем обратно bottomBar
                      widget.hideBottomBar(false);
                      //меняем виджет на экране
                      _isSearch = false;
                    });
                  },
                )

              //виджет панелей навигации
              : const WineNavigatSections()
          // Container(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Provider.of<WineListProvider>(context).wineList.isEmpty
          //         ? const NullNotesMessage()
          //         : Column(
          //             children: [
          //               // кнопка со страной, по тапу - переходим на экран со всеми странами,
          //               // которые представлены в заметках
          //               Flexible(
          //                 flex: 1,
          //                 fit: FlexFit.loose,
          //                 child: GestureDetector(
          //                   onTap: () => Navigator.pushNamed(
          //                       context, CountriesOverview.routName),
          //                   child: const ItemColumn(
          //                     icon: MyCustomIcons.flag,
          //                     title: 'Страны',
          //                   ),
          //                 ),
          //               ),

          //               //кнопка для перехода на экран с производителями
          //               Flexible(
          //                 flex: 1,
          //                 fit: FlexFit.loose,
          //                 child: GestureDetector(
          //                   onTap: () => Navigator.pushNamed(
          //                     context,
          //                     ManufGrapeOverviewScreen.routName,
          //                     arguments: WineNoteFields.manufacturer,
          //                   ),
          //                   child: const ItemColumn(
          //                     icon: MyCustomIcons.manufacturer,
          //                     title: 'Производители',
          //                   ),
          //                 ),
          //               ),

          //               //кнопка для перехода на экран с производителями
          //               Flexible(
          //                 flex: 1,
          //                 fit: FlexFit.loose,
          //                 child: GestureDetector(
          //                   onTap: () => Navigator.pushNamed(
          //                     context,
          //                     ManufGrapeOverviewScreen.routName,
          //                     arguments: WineNoteFields.grapeVariety,
          //                   ),
          //                   child: const ItemColumn(
          //                     icon: MyCustomIcons.grape,
          //                     title: 'Сорта винограда',
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //   ),
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
