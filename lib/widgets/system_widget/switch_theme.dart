import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../models/my_themes.dart';

//свитч переключатель темы
class SwitchThemeMode extends StatelessWidget {
  const SwitchThemeMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ChangeThemeProvider>(context);

    return FlutterSwitch(
      //начальное значение получаем из провайдера
      value: themeProvider.isDark,

      // меняем значение выбранной темы
      onToggle: (value) {
        final provider =
            Provider.of<ChangeThemeProvider>(context, listen: false);
        provider.isDark = value;
      },
      height: MediaQuery.of(context).size.height * 0.045,

      //active toogle - темная тема
      activeIcon: const Icon(
        Icons.mode_night,
        color: Color(0xFF381E72),
      ),
      activeColor: const Color(0xFF49454F),
      activeToggleColor: const Color(0xFFD0BCFF),

      //innactive toogle - светлая тема
      inactiveIcon: const Icon(
        Icons.light_mode,
        color: Colors.yellow,
      ),
      inactiveColor: const Color(0xFFE7E0EC),
      inactiveToggleColor: const Color(0xFF6750A4),
    );
  }
}
