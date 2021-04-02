part of 'explore_bloc.dart';

@immutable
abstract class ExploreState {
  @override
  String toString() => '$runtimeType';
}

class InitialExploreState extends ExploreState {}

class RefreshSuccessExploreState extends ExploreState {
  RefreshSuccessExploreState(this.session);

  final ExploreSessionModel session;
}
