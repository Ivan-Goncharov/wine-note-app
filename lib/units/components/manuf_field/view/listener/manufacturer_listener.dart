import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/units/components/manuf_field/view/manuf_field.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ManufacturerListener extends ChangeNotifier {
  Future<void> openDialog(BuildContext context) async {
    final state =
        BlocProvider.of<EditWineBloc>(context).state as EditWineLoadedState;
    final result = await SmartDialog.show(
      builder: (context) => ManufacturerDialog(
          textController: state.editWineModel.manufTextController),
    );
    print('DEBUG $result');
  }
}
