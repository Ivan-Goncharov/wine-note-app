import 'package:flutter/material.dart';

//навигационный бар
class CustomBottomNavigation extends StatefulWidget {
  //принимает индекс выбранной вкладки и функцию для изменения вкладки
  final int index;
  final ValueChanged<int> onChangedTab;

  const CustomBottomNavigation({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //FAB должна быть в центре, впадать в бар
      notchMargin: 5,
      shape: const CircularNotchedRectangle(),

      //наши вкладки
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //вкладки со последними винами
            buildTabItem(
              index: 0,
              icon: const Icon(Icons.history_rounded, size: 50),
            ),
            opacityTab(),

            //вкладка со всеми винами
            buildTabItem(
              index: 1,
              icon: const Icon(
                Icons.wine_bar_sharp,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

//метод для создания вкладок
  Widget buildTabItem({required int index, required Icon icon}) {
    //смотрим, выбрана ли вкладка в данный момент
    final isSelected = index == widget.index;

    return IconTheme(
      //меняем цвет вкладки, взависимости от того, выбрана она или нет
      data: IconThemeData(
        color: isSelected ? Colors.red : Colors.amber,
      ),

      // по нажатию на вкладку, вызываем метод смены вкладки и передаем индекс
      child: IconButton(
        onPressed: () => widget.onChangedTab(index),
        icon: icon,
      ),
    );
  }

  //прозрачная вкладка, чтобы было пространством между двумя остальынми вклдаками
  Widget opacityTab() {
    return const Opacity(
      opacity: 0,
      child: IconButton(
        icon: Icon(
          Icons.no_cell,
          size: 50,
        ),
        onPressed: null,
      ),
    );
  }
}
