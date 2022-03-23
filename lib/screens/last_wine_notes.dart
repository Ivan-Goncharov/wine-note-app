import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/database/databse.dart';
import 'package:flutter_my_wine_app/providers/wine_item_provider.dart';
import 'package:flutter_my_wine_app/screens/edit_screens/country_edit.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';

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
          child: Text('Страна производитель'),
          onPressed: () async {
            final result =
                await Navigator.pushNamed(context, CountryEdit.routName);
            if (result == null) {
              return;
            } else if (result is List<String>) {
              print(result[0]);
            } else {
              final map = (result as List)[0] as Map<String, String>;
              print(map['country']);
            }
          },
        ),
      ),
    );
  }
}
