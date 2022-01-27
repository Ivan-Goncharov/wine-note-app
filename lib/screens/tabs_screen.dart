import 'package:flutter/material.dart';

import './edit_wine_screen.dart';
import './wine_overview_screen.dart';
import './favorites_wine_screen.dart';

//экран для навигации между вкладками

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //список экранов для навигации по вкладкам
  // также передаем текст для названия appBar
  final List<Map<String, Object>> _pages = [
    {'page': const FavoritesWineScreen()},
    {'page': const WineOverViewScreen()},
    {'page': const EditWineScreen()},
  ];

  //переменная для отслеживания текущего индекса экрана в списке
  late int _currentSelectIndex;

  void changeSelect() {
    _selectPage(1);
  }

  // метод для изменения индекса, взависимости от выбранной вкладки
  void _selectPage(int index) {
    setState(() {
      _currentSelectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // //устанавливаем текст для appbar, взависимости от выбранной вкладки
      // appBar: AppBar(
      //   title: Text(
      //     _pages[_currentSelectIndex]['title'] as String,
      //   ),
      // ),

      //выводим текущий экран из списка
      body: _pages[_currentSelectIndex]['page'] as Widget,

      //нижняя панель навигации
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectIndex,

        onTap: _selectPage,
        //вкладки панели навигации
        items: const [
          //любимые
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: 'Favorites',
          ),

          //все вина
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar, size: 30),
            label: 'All Wine',
          ),

          //редактирование заметок
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
