import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(InitialExploreState());

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
