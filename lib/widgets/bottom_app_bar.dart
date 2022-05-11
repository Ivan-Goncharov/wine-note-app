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
      notchMargin: 7,
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).colorScheme.background,

      //наши вкладки
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        height: MediaQuery.of(context).size.height * 0.09,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //вкладка со последними винам
            TabItem(
                selectIndex: widget.index,
                iconData: Icons.access_time_rounded,
                tabIndex: 0,
                changeTab: widget.onChangedTab),
            opacityTab(),

            //вкладка со всеми винами

            TabItem(
                selectIndex: widget.index,
                iconData: Icons.home_outlined,
                tabIndex: 1,
                changeTab: widget.onChangedTab),
          ],
        ),
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

//одна вкладка в таббаре
class TabItem extends StatelessWidget {
  //индекс выбранной вкладки
  final int selectIndex;
  //индекс создаваемой вкладки
  final int tabIndex;
  //иконка вкладки
  final IconData iconData;
  //функция для изменеия выбранной вкладки
  final Function changeTab;

  const TabItem(
      {Key? key,
      required this.selectIndex,
      required this.iconData,
      required this.tabIndex,
      required this.changeTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = tabIndex == selectIndex;
    return GestureDetector(
      onTap: () => changeTab(tabIndex),
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: isSelected
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.onInverseSurface,
          size: 40,
        ),
      ),
    );
  }
}
