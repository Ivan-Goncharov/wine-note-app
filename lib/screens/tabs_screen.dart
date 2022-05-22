import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'edit_wine_screen.dart';
import 'overview_screens/wine_overview_screen.dart';
import '../../screens/last_wine_notes.dart';
import '../../widgets/bottom_app_bar.dart';
import '../../widgets/system_widget/custom_showcase.dart';

//экран для навигации между вкладками
class TabsScreen extends StatefulWidget {
  static const routName = './tabScreen';

  //ключи к показу инструкции для приложения
  static final keyLastWineIcon = GlobalKey();
  static final keyWineNavigation = GlobalKey();
  static final keySwitchTheme = GlobalKey();

  //ключ для sharedPrefernces
  static const preferncesKey = 'isFirstLaunch';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final keyFloatButton = GlobalKey();
  //список экранов для навигации по вкладкам
  late final List<Widget> _pages;

  //переменная для скрытия bottomBar
  //true - необходимо скрыть
  //false - показать
  bool _isHide = false;

  //метод для изменения переменной _isHide
  void _changeHide(bool flag) {
    setState(() {
      _isHide = flag;
    });
  }

  @override
  void initState() {
    //инициализируем страницы навигации
    _pages = <Widget>[
      const LastWineNote(),
      WineOverviewScreen(hideBottomBar: _changeHide),
    ];

    //showCase инструкция пользования приложением
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        //проверяем - запущено ли приложение впервые
        _isFirstLaunch().then(
          (result) {
            //если впервые, то запускаем инструкцию пользователя
            if (result) {
              ShowCaseWidget.of(context)?.startShowCase(
                [
                  keyFloatButton,
                  TabsScreen.keyLastWineIcon,
                  TabsScreen.keyWineNavigation,
                  TabsScreen.keySwitchTheme,
                ],
              );
            }
          },
        );
      },
    );
    super.initState();
  }

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
      bottomNavigationBar: _isHide
          ? const SizedBox()
          : CustomBottomNavigation(
              index: _currentSelectIndex,
              onChangedTab: onChangeTab,
            ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //плавающаяя кнопка
      floatingActionButton: _isHide
          ? const SizedBox()
          : CustomShowCaseWidget(
              widget: const FloatButton(),
              showCaseKey: keyFloatButton,
              widgetDescription: 'Кнопка для добавления вина',
            ),
    );
  }

  //метод, который меняет вкладку, взависимости от нажатой кнопки
  void onChangeTab(int index) {
    setState(() {
      _currentSelectIndex = index;
    });
  }

  //метод для запроса sharedPreferences
  //проверяем впервые ли запущено приложение
  Future<bool> _isFirstLaunch() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //получаем результат
    bool isFirstLaunch =
        sharedPreferences.getBool(TabsScreen.preferncesKey) ?? true;

    //если запустили впервые, то изменяем переменную на false
    if (isFirstLaunch) {
      sharedPreferences.setBool(TabsScreen.preferncesKey, false);
    }
    return isFirstLaunch;
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
