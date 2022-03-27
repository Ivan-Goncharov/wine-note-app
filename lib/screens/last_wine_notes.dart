import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/models/wine_item_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/country_edit.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LastWine')),
      body: Center(
          child: TextButton(
        child: Text('Bottom'),
        onPressed: () => _showMultiSelect(context),
      )),
    );
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => MultiSelectBottomSheet(
        items: [
          Text('один'),
          Text('два'),
          Text('три'),
        ].map((e) => MultiSelectItem(e, e)).toList(),
        initialValue: ['два'],
        unselectedColor: Colors.black,
        searchable: true,
      ),
    );
  }
}
