import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/constants/string_resources.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/components/manuf_text_field/cubit/mauf_search_hint_cubit.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';

class ManufTextInputField extends StatelessWidget {
  const ManufTextInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManufSearchHintCubit>(),
      child: const _ManufTextInputFieldBody(),
    );
  }
}

class _ManufTextInputFieldBody extends StatelessWidget {
  const _ManufTextInputFieldBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final wineEditState = BlocProvider.of<EditWineBloc>(context).state
        as EditWineLoadedState;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.only(
            top: 15,
            left: 16,
            right: 16,
          ),
          child: TextField(
            decoration: InputDecoration(
              labelText: SResources.manufactorTitle,
              hintText: SResources.manufactorHint,
              enabledBorder: _inputBorder(theme.colorScheme.onBackground),
              focusedBorder: _inputBorder(theme.colorScheme.primary),
              labelStyle: theme.textTheme.bodyMedium,
              hintStyle: TextStyle(
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            onChanged: (value) =>
                BlocProvider.of<ManufSearchHintCubit>(context).searchHint(value),
            controller: wineEditState.editWineModel.manufTextController,
          ),
        ),
        const _ManufHintWidget(),
      ],
    );
  }

  //метод для создания рамки для ввода
  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}

class _ManufHintWidget extends StatelessWidget {
  const _ManufHintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManufSearchHintCubit, ManufHintSearchState>(
      builder: (context, state) {
        if (state is ManufSuccesefulSearchState) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              itemBuilder: (_, index) {
                return Text(state.listOfSearch[index]);
              },
              itemCount: state.listOfSearch.length,
            ),
          );
        } else if (state is ManufEmptySearchState) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
