import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';

import '../../screens/edit_screens/search_screen.dart';
import 'button_container.dart';

class SearchRegion extends StatefulWidget {
  final String regionName;
  final String countryName;
  final Function function;
  const SearchRegion(
      {Key? key,
      required this.regionName,
      required this.countryName,
      required this.function})
      : super(key: key);

  @override
  State<SearchRegion> createState() => _SearchRegionState();
}

class _SearchRegionState extends State<SearchRegion> {
  late List<String> _listRegions;
  late String _regionName;

  @override
  Widget build(BuildContext context) {
    _regionName = widget.regionName;
    return GestureDetector(
      onTap: () async {
        _listRegions = Country.regionsOfCountry(widget.countryName);
        final result = await Navigator.pushNamed(
          context,
          SearchScreen.routName,
          arguments: {
            'list': _listRegions,
            'type': SearchType.regionType,
            'text': _regionName
          },
        );

        if (result == null) {
          return;
        } else if (result is List<String>) {
          setState(() {
            _regionName = result[0];
            widget.function(_regionName);
          });
        }
      },
      child: ButtonContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Регион'),
            Row(
              children: [
                Text(_regionName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
