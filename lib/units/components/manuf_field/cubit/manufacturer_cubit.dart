import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manufacturer_state.dart';

class ManufacturerCubit extends Cubit<ManufacturerState> {
  ManufacturerCubit() : super(ManufacturerInitial());

  final _listOfManuf = ['one, two, three, four'];

  void initialInput() {
    emit(ManufacturerButtonState());
  }

  void searchHint(String title) {
    var searchList = <String>[];
    searchList.addAll(_listOfManuf.where((element) => element.contains(title)));
    if (searchList.isNotEmpty) {
      emit(ManufacturerSuccesefulSearchState(searchList));
    } else {
      emit(ManufacturerEmptySearchState());
    }
  }

  void inputSucceful() {
    emit(ManufacturerButtonState());
  }
}
