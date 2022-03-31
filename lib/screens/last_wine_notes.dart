import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/search_screen.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/wine_sort.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';
import 'package:flutter_my_wine_app/widgets/edit_wine/image_pick.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class LastWineNote extends StatefulWidget {
  const LastWineNote({Key? key}) : super(key: key);

  @override
  State<LastWineNote> createState() => _LastWineNoteState();
}

String _string = '';

class _LastWineNoteState extends State<LastWineNote> {
  late Size _size;
  late ColorScheme _colorScheme;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    _colorScheme = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LastWine')),
      // body: const Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: WineImagePick(),
      // ),
    );
  }
}
