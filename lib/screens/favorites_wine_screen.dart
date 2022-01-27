import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/providers/wine_notes_list_provider.dart';
import 'package:flutter_my_wine_app/widgets/wine_note_item.dart';
import 'package:provider/provider.dart';

//экран для отображения любимых вин
class FavoritesWineScreen extends StatelessWidget {
  const FavoritesWineScreen({Key? key}) : super(key: key);

  //переменная для записи экрана в пункты навигации
  static const routName = './screen/favorites_screen';

  @override
  Widget build(BuildContext context) {
    final wineList = Provider.of<WineNotesListProvider>(context).favoriteItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Любимые вина'),
      ),
      body: ListView.builder(
        itemCount: wineList.length,
        itemBuilder: (context, index) {
          return WineNoteItem(wineList[index]);
        },
      ),
    );
  }
}
