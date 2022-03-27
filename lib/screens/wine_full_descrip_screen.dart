import 'package:flutter/material.dart';

import '../widgets/detailed_expanded_notes.dart';
import '../models/wine_item_provider.dart';

//Экран для полного описания вина
class WineFullDescripScreen extends StatefulWidget {
  static const routName = './wine_full_description';

  const WineFullDescripScreen({Key? key}) : super(key: key);

  @override
  State<WineFullDescripScreen> createState() => _WineFullDescripScreenState();
}

class _WineFullDescripScreenState extends State<WineFullDescripScreen> {
  @override
  Widget build(BuildContext context) {
    //в качестве аргумента - принимаем заметку о вине
    final wineNote =
        ModalRoute.of(context)?.settings.arguments as WineItemProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(wineNote.name),
      ),
      body: Column(
        children: [
          //выводим изображение вина
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(
                  wineNote.imageUrl,
                ),
                width: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
          ),

          //выводим поочередно факты о вине
          DetailedExpanded(wineNote),
        ],
      ),
    );
  }
}
