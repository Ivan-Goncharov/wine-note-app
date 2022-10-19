import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/splash/listener/splash_listener.dart';
import 'package:provider/provider.dart';

/// Экран, который появляется при первом входе в приложении,
/// На нем грузятся все основные процессы в начале
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<SplachListener>(),
      child: const _SplashScreenBody(),
    );
  }
}

class _SplashScreenBody extends StatelessWidget {
  const _SplashScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplachListener>().init(context);
    return SafeArea(
      child: Image.asset(
        'assets/images/splash_screen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
