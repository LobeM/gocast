import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/search_history_model.dart';
import 'package:gocast/main.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/screens/search/widgets/search_podcasts_delegate_history.dart';
import 'package:gocast/screens/search/widgets/search_podcasts_delegate_result_list.dart';

class SearchPodcastsDelegate extends SearchDelegate<String> {
  SearchPodcastsDelegate({this.hintText}) : super(searchFieldLabel: hintText);

  final String hintText;

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => close(context, query),
        )
      ];
    }
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        getIt.get<AppGlobals>().isRTL
            ? Icons.keyboard_arrow_right
            : Icons.keyboard_arrow_left,
        size: 38,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPodcastsDelegateResultList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ///show suggested queries based on past queries or the current context.
    if (query.isNotEmpty) {
      return SearchPodcastsDelegateResultList(query: query);
    }

    return SearchPodcastsDelegateHistory(
      onQuerySelected: (SearchHistoryModel model) => query = model.query,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: theme.appBarTheme.color,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme:
          theme.textTheme.copyWith(headline6: theme.textTheme.headline6.white),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: kWhite),
      textTheme:
          theme.textTheme.copyWith(headline6: theme.textTheme.headline6.white),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
