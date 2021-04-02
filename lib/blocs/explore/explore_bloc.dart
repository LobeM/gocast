import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gocast/data/models/explore_session_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(InitialExploreState());

  @override
  Stream<ExploreState> mapEventToState(ExploreEvent event) async* {
    if (event is SessionInitiatedExploreEvent) {
      yield* _mapInitSessionExploreEventToState(event);
    } else if (event is FilteredListRequestedExploreEvent) {
      yield* _mapFilteredListRequestedExploreEventToState();
    } else if (event is CategoryFilteredExploreEvent) {
      yield* _mapCategoryFilteredExploreEventToState(event);
    }
  }

  Stream<ExploreState> _mapInitSessionExploreEventToState(
      SessionInitiatedExploreEvent event) async* {
    yield RefreshSuccessExploreState(
      ExploreSessionModel(
        activeExploreTab: event.activeExploreTab,
      ),
    );

    add(FilteredListRequestedExploreEvent());
  }

  Stream<ExploreState> _mapFilteredListRequestedExploreEventToState() async* {
    if (state is RefreshSuccessExploreState) {
      final ExploreSessionModel session =
          (state as RefreshSuccessExploreState).session;

      yield RefreshSuccessExploreState(session.rebuild(isLoading: true));

      const PodcastRepository podcastRepository = PodcastRepository();
      // Gets should be by category ID
      List<PodcastModel> _topPodcasts =
          await podcastRepository.getTopPodcasts();
      List<PodcastModel> _topEpisodes =
          await podcastRepository.getTopEpisodes();

      yield RefreshSuccessExploreState(session.rebuild(
        topPodcasts: _topPodcasts,
        topEpisodes: _topEpisodes,
        isLoading: false,
      ));
    }
  }

  Stream<ExploreState> _mapCategoryFilteredExploreEventToState(
      CategoryFilteredExploreEvent event) async* {
    if (state is RefreshSuccessExploreState) {
      final ExploreSessionModel session =
          (state as RefreshSuccessExploreState).session;

      yield RefreshSuccessExploreState(session.rebuild(
        activeExploreTab: event.activeExploreTab,
        isLoading: true,
      ));

      add(FilteredListRequestedExploreEvent());
    }
  }
}
