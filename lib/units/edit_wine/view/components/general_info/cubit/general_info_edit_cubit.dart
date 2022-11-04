import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'general_info_edit_state.dart';

class GeneralInfoEditCubit extends Cubit<GeneralInfoEditState> {
  GeneralInfoEditCubit() : super(GeneralInfoEditInitial());

  bool _isOpen = false;

  void initial() {
    emit(GeneralInfoEditIsOpenState(_isOpen));
  }

  void changeVisible() {
    _isOpen = !_isOpen;
    emit(GeneralInfoEditIsOpenState(_isOpen));
  }
}
