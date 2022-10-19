import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_wine_app/get_it.dart';
import 'package:flutter_my_wine_app/units/edit_wine/bloc/edit_wine_bloc.dart';
import 'package:flutter_my_wine_app/units/edit_wine/view/components/edit_wine_loaded_body.dart';

class EditWineScreen extends StatelessWidget {
  final String? id;
  const EditWineScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditWineBloc>()..add(EditWineInitialEvent(id)),
      child: const _EditWineBody(),
    );
  }
}

class _EditWineBody extends StatelessWidget {
  const _EditWineBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWineBloc, EditWineState>(builder: (context, state) {
      if (state is EditWineLoadingState) {
        return const CircularProgressIndicator();
      } else if (state is EditWineErrorLoadedState) {
        return const Center(
          child: Text('Просим прощения, что-то пошло не так'),
        );
      } else if (state is EditWineLoadedState) {
        return EditWineLoadedBody(state: state);
      } else {
        return const SizedBox();
      }
    });
  }
}


