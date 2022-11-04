part of 'general_info_edit_cubit.dart';

@immutable
abstract class GeneralInfoEditState {}

class GeneralInfoEditInitial extends GeneralInfoEditState {}

class GeneralInfoEditIsOpenState extends GeneralInfoEditState {
  final bool isOpen;
  GeneralInfoEditIsOpenState(this.isOpen);
}
