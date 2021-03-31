part of 'explore_bloc.dart';

@immutable
abstract class ExploreEvent {
  @override
  String toString() => '$runtimeType';
}

class SessionInitiatedExploreEvent extends ExploreEvent {
  SessionInitiatedExploreEvent(this.activeExploreTab);

  final int activeExploreTab;
}

class FilteredListRequestedExploreEvent extends ExploreEvent {}

class CategoryFilteredExploreEvent extends ExploreEvent {}
