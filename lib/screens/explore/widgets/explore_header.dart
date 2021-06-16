import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/search_session_model.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/screens/search/widgets/search_podcasts_delegate.dart';
import 'package:gocast/widgets/strut_text.dart';

/// Delegate for configuring a [SliverPersistentHeader].
///
/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
class ExploreHeader extends SliverPersistentHeaderDelegate {
  ExploreHeader({this.expandedHeight});

  /// The max height of the header
  final double expandedHeight;

  Future<String> _quickSearch(
      BuildContext context, SearchSessionModel session) async {
    final String queryString = await showSearch(
      context: context,
      delegate: SearchPodcastsDelegate(hintText: 'Search for podcast'),
      query: session.q,
    );

    if (queryString == null) {
      // _searchBloc.add(FilteredListRequestedSearchEvent());
    } else {
      // _searchBloc.add(KeywordChangedSearchEvent(queryString));
    }

    return queryString;
  }

  SearchSessionModel session = SearchSessionModel();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: kPaddingM,
                left: kPaddingS,
                right: kPaddingS,
              ),
              child: Card(
                color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                    ? Theme.of(context).accentColor
                    : Theme.of(context).cardColor,
                margin: const EdgeInsets.all(4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBoxDecorationRadius)),
                elevation: 2,
                child: Container(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(kBoxDecorationRadius / 2),
                        ),
                      ),
                    ),
                    onPressed: () => _quickSearch(context, session),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Theme.of(context).hintColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StrutText(
                              L10n.of(context).explorePlaceholderSearch,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Theme.of(context).hintColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// The size of the header when it is not shrinking at the top of the
  /// viewport.
  ///
  /// This must return a value equal to or greater than [minExtent].
  @override
  double get maxExtent => expandedHeight;

  /// The smallest size to allow the header to reach, when it shrinks at the
  /// start of the viewport.
  ///
  /// This must return a value equal to or less than [maxExtent].
  @override
  double get minExtent => 75;

  /// Whether this delegate is meaningfully different from the old delegate.
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
