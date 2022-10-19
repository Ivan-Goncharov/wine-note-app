import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/splash/domain/shared_repo.dart';

/// Listener для переключения
class PagesIntroListener extends ChangeNotifier {
  final _controller = PageController(initialPage: 0);
  var _currentPage = 0;
  late Timer _timer;

  PageController get controller => _controller;

  void init() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      }
      _controller.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  Future<void> saveFirstLaunchApp() async {
    await getIt<SharedPrefRepo>().saveFirstLaunch();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
