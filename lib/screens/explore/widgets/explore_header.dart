import 'package:flutter/material.dart';
import 'package:gocast/configs/app_globals.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/main.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';

/// Delegate for configuring a [SliverPersistentHeader].
///
/// A sliver whose size varies when the sliver is scrolled to the edge
/// of the viewport opposite the sliver's [GrowthDirection].
class ExploreHeader extends SliverPersistentHeaderDelegate {
  ExploreHeader({this.expandedHeight});

  /// The max height of the header
  final double expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // TODO: add image header
          Padding(
            padding: const EdgeInsets.only(
              bottom: kPaddingL,
              left: kPaddingL,
              right: kPaddingL,
              top: kToolbarHeight + kPaddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: StrutText(
                        getIt.get<AppGlobals>().user != null
                            ? L10n.of(context).exploreTitleUser(
                                getIt.get<AppGlobals>().user?.fullName)
                            : L10n.of(context).exploreTitleGuest,
                        style: Theme.of(context).textTheme.headline4.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: kPaddingS),
                    child: StrutText(
                      L10n.of(context).exploreHeaderSubtitle,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: kBlack.withOpacity(.85)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kPaddingL,
                left: kPaddingL,
                right: kPaddingL,
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
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(kBoxDecorationRadius / 2)),
                    onPressed: () {
                      // Switch to search tab
                    },
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

  @override
  // TODO: implement maxExtent
  double get maxExtent => throw UnimplementedError();

  @override
  // TODO: implement minExtent
  double get minExtent => throw UnimplementedError();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
}
