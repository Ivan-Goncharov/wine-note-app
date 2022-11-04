import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mauf_search_hint_state.dart';

class ManufSearchHintCubit extends Cubit<ManufHintSearchState> {
  ManufSearchHintCubit() : super(ManufTextInputInitial());

  final _listOfManuf = ['one, two, three, four'];

  void searchHint(String title) {
    var searchList = <String>[];
    searchList.addAll(_listOfManuf.where((element) => element.contains(title)));
    if (searchList.isNotEmpty) {
      emit(ManufSuccesefulSearchState(searchList));
    } else {
      emit(ManufEmptySearchState());
    }
  }
}
