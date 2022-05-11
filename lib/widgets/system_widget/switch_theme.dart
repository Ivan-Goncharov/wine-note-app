import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/models/my_themes.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class SwitchThemeMode extends StatelessWidget {
  const SwitchThemeMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ChangeThemeProvider>(context);

    // return Switch.adaptive(
    //   value: themeProvider.isDark,
    //   onChanged: (value) {
    //     final provider =
    //         Provider.of<ChangeThemeProvider>(context, listen: false);
    //     provider.isDark = value;
    //   },
    // );

    return FlutterSwitch(
      value: themeProvider.isDark,
      onToggle: (value) {
        final provider =
            Provider.of<ChangeThemeProvider>(context, listen: false);
        provider.isDark = value;
      },
      height: MediaQuery.of(context).size.height * 0.045,
      activeIcon: const Icon(
        Icons.mode_night,
        color: Color(0xFF381E72),
      ),
      activeColor: const Color(0xFF49454F),
      activeToggleColor: const Color(0xFFD0BCFF),
      inactiveIcon: const Icon(
        Icons.light_mode,
        color: Colors.yellow,
      ),
      inactiveColor: const Color(0xFFE7E0EC),
      inactiveToggleColor: const Color(0xFF6750A4),
    );
  }
}
