part of 'manufacturer_cubit.dart';

@immutable
abstract class ManufacturerState {}

class ManufacturerInitial extends ManufacturerState {}

class ManufacturerButtonState extends ManufacturerState{}

class ManufacturerEmptySearchState extends ManufacturerState {}

class ManufacturerSuccesefulSearchState extends ManufacturerState {
  final List<String> listOfSearch;
  ManufacturerSuccesefulSearchState(this.listOfSearch);
}
