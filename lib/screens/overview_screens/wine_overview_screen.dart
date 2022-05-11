import 'package:flutter/material.dart';

import '../../screens/search_wine_note.dart';
import '../../widgets/overview_widget/wine_navig_sections.dart';

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
              : const WineNavigatSections()),
    );
  }
}
