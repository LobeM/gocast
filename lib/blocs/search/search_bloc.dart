import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/search_session_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SessionInitedSearchEvent) {
      yield* _mapInitSessionSearchEventToState(event);
    } else if (event is KeywordChangedSearchEvent) {
      yield* _mapKeywordSearchEventToState(event);
    } else if (event is QuickSearchRequestedSearchEvent) {
      yield* _mapQuickSearchEventToState(event);
    }
  }

  Stream<SearchState> _mapInitSessionSearchEventToState(
      SessionInitedSearchEvent event) async* {
    yield RefreshSuccessSearchState(
      SearchSessionModel(),
    );

    //if ((event.selectedCity.id.isEmpty && getIt.get<AppGlobals>().currentPosition != null) || event.selectedCity.id.isNotEmpty) {
    // add(FilteredListRequestedSearchEvent());
    //}
  }

  Stream<SearchState> _mapKeywordSearchEventToState(
      KeywordChangedSearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      final SearchSessionModel session =
          (state as RefreshSuccessSearchState).session;

      yield RefreshSuccessSearchState(session.rebuild(
        q: event.q,
        isLoading: true,
      ));

      // add(FilteredListRequestedSearchEvent());
    }
  }

  Stream<SearchState> _mapQuickSearchEventToState(
      QuickSearchRequestedSearchEvent event) async* {
    if (state is RefreshSuccessSearchState) {
      if (event.q.length >= kMinimalNameQueryLength) {
        final SearchSessionModel session =
            (state as RefreshSuccessSearchState).session;

        yield RefreshSuccessSearchState(session.rebuild(
          isLoading: true,
          podcasts: null,
        ));

        // const LocationRepository locationRepository = LocationRepository();

        // List<LocationModel> _locations;

        // _locations = await locationRepository.search();

        // if (_locations.isNotEmpty) {
        //   _locations = _locations.where((LocationModel location) => location.name.toLowerCase().contains(event.q.toLowerCase())).toList();
        // }

        yield RefreshSuccessSearchState(session.rebuild(
          isLoading: false,
        ));
      }
    }
  }
}
