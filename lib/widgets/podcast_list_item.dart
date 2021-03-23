import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/string.dart';

enum PodcastListItemViewType { search, list, grid, block }

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({
    Key key,
    this.podcast,
    this.viewType,
    this.wordToStyle,
    // this.showFavoriteButton,
    this.isFavourite,
    this.onFavopriteButtonPressed,
  }) : super(key: key);

  final PodcastModel podcast;
  final PodcastListItemViewType viewType;
  final String wordToStyle;
  // final bool showFavoriteButton;
  final bool isFavourite;
  final VoidCallback onFavopriteButtonPressed;

  void _showPodcastScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case PodcastListItemViewType.block:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
            ),
            child: InkWell(
              onTap: () => _showPodcastScreen(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(podcast.image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(kBoxDecorationRadius),
                            topRight: Radius.circular(kBoxDecorationRadius),
                          ),
                        ),
                      ),
                      // if (showFavoriteButton)
                      //   IconButton(
                      //     icon: Icon(isFavourite
                      //         ? Icons.favorite
                      //         : Icons.favorite_border),
                      //     color: kPrimaryColor,
                      //     onPressed: onFavopriteButtonPressed ?? () {},
                      //   )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPaddingS,
                      right: kPaddingS,
                      top: kPaddingS,
                      bottom: kPaddingS / 2,
                    ),
                    child: StrutText(
                      podcast.title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1.fs18.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kPaddingS,
                      right: kPaddingS,
                      bottom: kPaddingS / 2,
                    ),
                    child: StrutText(
                      podcast.author,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Theme.of(context).hintColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case PodcastListItemViewType.grid:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
            ),
            child: InkWell(
              onTap: () => _showPodcastScreen(context),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(podcast.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kBoxDecorationRadius),
                          topRight: Radius.circular(kBoxDecorationRadius),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: kPaddingS, start: kPaddingS, end: kPaddingS),
                      child: StrutText(
                        podcast.title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: kPaddingS, end: kPaddingS, top: 2),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: StrutText(
                              podcast.author,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Theme.of(context).hintColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        break;

      case PodcastListItemViewType.list:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
            ),
            child: InkWell(
              onTap: () => _showPodcastScreen(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(podcast.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(kBoxDecorationRadius),
                        bottomStart: Radius.circular(kBoxDecorationRadius),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: kPaddingS,
                        bottom: kPaddingS,
                        left: kPaddingS,
                        right: kPaddingS,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StrutText(
                            podcast.image,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.subtitle1.w600,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 2)),
                          StrutText(
                            podcast.author,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Theme.of(context).hintColor),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;

      case PodcastListItemViewType.search:
        return InkWell(
          onTap: () => _showPodcastScreen(context),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: kPaddingS),
                  child: Icon(
                    Icons.radio,
                    color: Theme.of(context).disabledColor,
                    size: 36,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: kPaddingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (wordToStyle.isEmpty)
                          StrutText(
                            podcast.title,
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.subtitle1,
                              children: podcast.title.getSpans(
                                matchWord: wordToStyle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        StrutText(
                          podcast.author,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Theme.of(context).hintColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;

      default:
        return Container();
    }
  }
}
