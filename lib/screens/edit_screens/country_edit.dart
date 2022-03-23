import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/string_resourses.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryEdit extends StatefulWidget {
  static const routName = '/countryEdit';
  const CountryEdit({Key? key}) : super(key: key);

  @override
  State<CountryEdit> createState() => _CountryEditState();
}

class _CountryEditState extends State<CountryEdit> {
  TextEditingController? _textController;
  List<Map<String, String>> _listCountry = [];

  @override
  void initState() {
    _textController = TextEditingController();
    _textController!.addListener(_inputListener);
    super.initState();
  }

  void _inputListener() {
    if (_textController!.text.isNotEmpty) {
      setState(() {
        _listCountry = Country.searchCountry(_textController!.text);
      });
    }
  }

  @override
  void didChangeDependencies() {
    final country = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      _textController!.text = country;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Введите страну производителя',
                  ),
                  controller: _textController,
                  autofocus: true,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == _listCountry.length &&
                        _textController!.text.isNotEmpty) {
                      return rowButtons(colorScheme, size, context);
                    } else if (_textController!.text.isEmpty) {
                      return SizedBox();
                    }

                    final element = _listCountry[index];

                    return itemCountry(context, element, size);
                  },
                  itemCount: _listCountry.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector itemCountry(
      BuildContext context, Map<String, String> element, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, [element]);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SvgPicture.asset(
                element['svg']!,
                width: size.width * 0.05,
                height: size.height * 0.05,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              element['country']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowButtons(ColorScheme colorScheme, Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Назад',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        buttonContainer(
          colorScheme: colorScheme,
          size: size,
          button: TextButton(
            child: Text(
              'Сохранить',
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, [_textController!.text]);
            },
          ),
        )
      ],
    );
  }

  Widget buttonContainer(
      {required ColorScheme colorScheme,
      required Size size,
      required Widget button}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.primary,
      ),
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: button,
    );
  }
}
