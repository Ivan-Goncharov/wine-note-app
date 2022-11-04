part of 'mauf_search_hint_cubit.dart';

@immutable
abstract class ManufHintSearchState {}

class ManufTextInputInitial extends ManufHintSearchState {}

class ManufEmptySearchState extends ManufHintSearchState {}

class ManufSuccesefulSearchState extends ManufHintSearchState {
  final List<String> listOfSearch;
  ManufSuccesefulSearchState(this.listOfSearch);
}
