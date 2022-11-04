import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/constants/string_resources.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/helpers/inputBorderHelper.dart';
import 'package:flutter_my_wine_app/units/components/manuf_field/cubit/manufacturer_cubit.dart';
import 'package:flutter_my_wine_app/units/components/manuf_field/view/listener/manufacturer_listener.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_my_wine_app/widgets/system_widget/button_container.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class ManufacturerField extends StatelessWidget {
  const ManufacturerField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ManufacturerListener>(),
      child: const _ManufacturerFieldBody(),
    );
  }
}

class _ManufacturerFieldBody extends StatelessWidget {
  const _ManufacturerFieldBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<ManufacturerListener>();
    final wineEditState =
        BlocProvider.of<EditWineBloc>(context).state as EditWineLoadedState;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async => listener.openDialog(context),
      child: InputButtonWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(SResources.manufactorTitle),
            Text(
              wineEditState.editWineModel.manufTextController.text,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

class ManufacturerDialog extends StatelessWidget {
  final TextEditingController textController;
  const ManufacturerDialog({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          TextField(
            controller: textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: SResources.manufactorHint,
              enabledBorder: inputBorder(theme.colorScheme.onBackground),
              focusedBorder: inputBorder(theme.colorScheme.primary),
              labelStyle: theme.textTheme.bodyMedium,
              hintStyle: TextStyle(
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
              //кнопка для удаления ввода
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => textController.clear(),
              ),
            ),
            onSubmitted: (value) => Navigator.of(context).pop([value]),
          )
        ],
      ),
    );
  }
}
