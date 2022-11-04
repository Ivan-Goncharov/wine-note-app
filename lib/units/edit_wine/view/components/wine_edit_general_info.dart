import 'package:flutter/material.dart';
import 'package:flutter_my_wine_app/constants/string_resources.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/text_field_container.dart';

class WineEditGeneralInfo extends StatelessWidget {
  final EditWineLoadedState state;
  const WineEditGeneralInfo({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state.screenState.isVisGeneralInfo,
      child: Column(
        children: [
         

          // //Производитель вина
          //               TextInputWithHint(
          //                 fieldType: WineNoteFields.manufacturer,
          //                 changeData: _changeManufactor,
          //                 data: _note.manufacturer,
          //                 hintText: 'Введите название производителя',
          //                 title: 'Производитель',
          //               ),
        ],
      ),
    );
  }
}

// Visibility(
                  //   visible: _isVisGeneralInfo,
                  //   child: Column(
                  //     children: [
                  //       
                  //       //Производитель вина
                  //       TextInputWithHint(
                  //         fieldType: WineNoteFields.manufacturer,
                  //         changeData: _changeManufactor,
                  //         data: _note.manufacturer,
                  //         hintText: 'Введите название производителя',
                  //         title: 'Производитель',
                  //       ),

                  //       // указываем год вина
                  //       WineYear(
                  //         currentWineYear: _note.year,
                  //         changeDateNote: _changeWineDate,
                  //       ),

                  //       //Страна вина
                  //       TextFieldCountry(
                  //         countryName: _countryName,
                  //         func: _changeNoteCountry,
                  //       ),

                  //       //Регион вина
                  //       TextInputWithHint(
                  //         changeData: _changeNoteRegion,
                  //         fieldType: WineNoteFields.region,
                  //         data: _regionName,
                  //         hintText: 'Укажите регион',
                  //         countryName: _countryName,
                  //         title: 'Регион',
                  //       ),

                  //       //цена
                  //       TextFieldInput(
                  //         //если цена не указана, то передаем пустую строку
                  //         initialValue:
                  //             _note.price == 0.0 ? '' : _note.price.toString(),

                  //         //сохраняем данные
                  //         changeNote: (value) {
                  //           //парсимм значение в double и сохраняем в заметку
                  //           _note = _note.copyWith(
                  //               price: double.parse(parseDoubleInfo(value)));
                  //         },
                  //         fieldAction: TextInputAction.done,
                  //         hintText: 'Укажите стоимость вина',
                  //         lableText: 'Цена',
                  //         keyboardType: TextInputType.number,
                  //       ),

                  //       //поставщик
                  //       TextInputWithHint(
                  //         fieldType: WineNoteFields.vendor,
                  //         changeData: (vendor) {
                  //           _note = _note.copyWith(vendor: vendor);
                  //         },
                  //         data: _note.vendor,
                  //         hintText: 'Введите название поставщика',
                  //         title: 'Поставщик',
                  //       ),
                  //     ],
                  //   ),
                  