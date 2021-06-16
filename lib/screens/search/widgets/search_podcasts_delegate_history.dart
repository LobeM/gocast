import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/search_history_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/utils/list.dart';
import 'package:gocast/widgets/uppercase_title.dart';

/// Signature for when a tap on search history query has occurred.
typedef SearchHistoryTapCallback = void Function(SearchHistoryModel model);

class SearchPodcastsDelegateHistory extends StatefulWidget {
  const SearchPodcastsDelegateHistory({
    Key key,
    this.onQuerySelected,
  }) : super(key: key);

  final SearchHistoryTapCallback onQuerySelected;

  @override
  _SearchPodcastsDelegateHistoryState createState() =>
      _SearchPodcastsDelegateHistoryState();
}

class _SearchPodcastsDelegateHistoryState
    extends State<SearchPodcastsDelegateHistory> {
  List<SearchHistoryModel> _searchHistory;

  @override
  void initState() {
    _loadHistory();
    super.initState();
  }

  Future<void> _loadHistory() async {
    const PodcastRepository locationRepository = PodcastRepository();

    _searchHistory = await locationRepository.getSearchHistory();

    if (_searchHistory.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_searchHistory.isNullOrEmpty) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UppercaseTitle(title: 'Recent searches'),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingM, bottom: kPaddingL),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              children: _searchHistory.map((SearchHistoryModel item) {
                return InputChip(
                  deleteIconColor: kPrimaryColor,
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 1,
                  onPressed: () {
                    if (widget.onQuerySelected != null) {
                      widget.onQuerySelected(item);
                    }
                  },
                  label: Text(item.query),
                  onDeleted: () {
                    _searchHistory.remove(item);
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
