part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  @override
  String toString() => '$runtimeType';
}

class InitialSearchState extends SearchState {}

class RefreshSuccessSearchState extends SearchState {
  RefreshSuccessSearchState(this.session);

  final SearchSessionModel session;
}
