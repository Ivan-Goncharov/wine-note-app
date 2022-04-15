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
  late Size _size;
  late ColorScheme _colors;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _size = MediaQuery.of(context).size;
      _colors = Theme.of(context).colorScheme;
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //FAB должна быть в центре, впадать в бар
      notchMargin: 7,
      shape: const CircularNotchedRectangle(),
      color: _colors.background,

      //наши вкладки
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: _colors.surfaceVariant,
        ),
        height: _size.height * 0.09,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //вкладки со последними винами
            buildTabItem(
              index: 0,
              iconData: Icons.home_outlined,
            ),
            opacityTab(),

            //вкладка со всеми винами
            buildTabItem(
              index: 1,
              iconData: Icons.access_time_rounded,
            ),
          ],
        ),
      ),
    );
  }

//метод для создания вкладок
  Widget buildTabItem({required int index, required IconData iconData}) {
    //смотрим, выбрана ли вкладка в данный момент
    final isSelected = index == widget.index;

    return GestureDetector(
      onTap: () => widget.onChangedTab(index),
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color:
              isSelected ? _colors.onSurfaceVariant : _colors.onInverseSurface,
          size: 40,
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
