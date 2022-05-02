import 'package:flutter/material.dart';

import 'edit_screens/edit_wine_screen.dart';
import 'overview_screens/wine_overview_screen.dart';
import '../../screens/last_wine_notes.dart';
import '../../widgets/bottom_app_bar.dart';

//экран для навигации между вкладками

class TabsScreen extends StatefulWidget {
  static const routName = './tabScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //список экранов для навигации по вкладкам
  final _pages = <Widget>[
    const LastWineNote(),
    const WineOverViewScreen(),
  ];

  //переменная для отслеживания текущего индекса экрана в списке
  int _currentSelectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //выводим текущий экран из списка
      body: _pages[_currentSelectIndex],
      backgroundColor: Theme.of(context).colorScheme.background,

      //навигационный бар, передаем текущий индекс и функцию для изменения индекса
      bottomNavigationBar: CustomBottomNavigation(
        index: _currentSelectIndex,
        onChangedTab: onChangeTab,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatButton(),
    );
  }

  //метод, который меняет вкладку, взависимости от нажатой кнопки
  void onChangeTab(int index) {
    setState(() {
      _currentSelectIndex = index;
    });
  }
}

//вызов окна для создания новой заметки по нажатию плавающей кнопки
class FloatButton extends StatelessWidget {
  const FloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        size: 40,
      ),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () => Navigator.of(context)
          .pushNamed(EditWineScreen.routName, arguments: null),
    );
  }
}
