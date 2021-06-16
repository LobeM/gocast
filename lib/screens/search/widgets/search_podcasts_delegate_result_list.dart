import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/search/search_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/jumbotron.dart';
import 'package:gocast/widgets/podcast_list_item.dart';

class SearchPodcastsDelegateResultList extends StatefulWidget {
  const SearchPodcastsDelegateResultList({Key key, this.query})
      : super(key: key);

  final String query;

  @override
  _SearchPodcastsDelegateResultListState createState() {
    return _SearchPodcastsDelegateResultListState();
  }
}

class _SearchPodcastsDelegateResultListState
    extends State<SearchPodcastsDelegateResultList> {
  SearchBloc _searchBloc;

  List<PodcastModel> _podcasts;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String q = widget.query.trim();

    _searchBloc.add(QuickSearchRequestedSearchEvent(q));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is RefreshSuccessSearchState) {
          if (state.session.isLoading) {
            return const Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          } else {
            if (q.length >= kMinimalNameQueryLength) {
              _podcasts = state.session.podcasts;
              if (_podcasts.isEmpty) {
                return Center(
                  child: Jumbotron(
                    title: 'No results',
                    icon: Icons.not_listed_location,
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(
                    left: kPaddingM, right: kPaddingM, top: 5),
                itemCount: _podcasts.length,
                itemBuilder: (BuildContext context, int index) {
                  return PodcastListItem(
                    podcast: _podcasts[index],
                    viewType: PodcastListItemViewType.search,
                    wordToStyle: q,
                  );
                },
              );
            }
          }
        }

        // if (_podcasts != null) {
        //   _podcasts.branches.clear();
        // }

        return Container();
      },
    );
  }
}
