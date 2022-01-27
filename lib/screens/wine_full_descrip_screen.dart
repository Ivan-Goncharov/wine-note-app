import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/icons/my_custom_icons.dart';
import 'package:flutter_my_wine_app/screens/edit_wine_screen.dart';
import 'package:flutter_my_wine_app/widgets/detailed_expanded_notes.dart';
import '../providers/wine_item_provider.dart';

//Экран для полного описания вина
class WineFullDescripScreen extends StatefulWidget {
  static const routname = './wine_full_description';

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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                wineNote.toogleStatusFavorite();
              });
            },
            icon: wineNote.isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditWineScreen.routName, arguments: wineNote.id);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
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
