part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitedSearchEvent extends SearchEvent {}

class KeywordChangedSearchEvent extends SearchEvent {
  KeywordChangedSearchEvent(this.q);

  final String q;
}

class QuickSearchRequestedSearchEvent extends SearchEvent {
  QuickSearchRequestedSearchEvent(this.q);

  final String q;
}
