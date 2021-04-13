import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/shimmer_box.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/datetime.dart';
import 'package:gocast/utils/int.dart';

enum PodcastListItemViewType { block, detailEpisode, episodeTile }

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
            // height: 220,
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
                            image: CachedNetworkImageProvider(podcast.imageUrl),
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

      case PodcastListItemViewType.detailEpisode:
        final EpisodeModel episode = podcast.episodes[0];

        return InkWell(
          onTap: () {},
          child: Card(
            elevation: 1,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(kBoxDecorationRadius),
            // ),
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: kPaddingM,
                    right: kPaddingM,
                    top: kPaddingM,
                  ),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: podcast.imageUrl,
                        imageBuilder: (BuildContext context,
                                ImageProvider<Object> imageProvider) =>
                            Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraits) {
                          return ShimmerBox(width: 50, height: 50);
                        }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: kPaddingS),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StrutText(
                              podcast.title,
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            StrutText(
                              episode.uploadDate.elapsedTime(context),
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: kPaddingM,
                    right: kPaddingM,
                    top: kPaddingS,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StrutText(
                        episode.title,
                        style: Theme.of(context).textTheme.subtitle1.fs18.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      StrutText(
                        episode.description,
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: kPaddingM,
                    right: kPaddingM,
                    top: kPaddingS,
                    bottom: kPaddingS,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      ),
                      StrutText(
                        episode.duration.toDuration(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.playlist_add,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.download_rounded,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        break;

      case PodcastListItemViewType.episodeTile:
        final EpisodeModel episode = podcast.episodes[0];
        return ListTile(
          title: Text(episode.title),
          subtitle: Text(episode.duration.toDuration(context)),
        );
      // case PodcastListItemViewType.grid:
      //   return Card(
      //     elevation: 1,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(kBoxDecorationRadius),
      //     ),
      //     margin: EdgeInsets.zero,
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).cardColor,
      //         borderRadius:
      //             const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
      //       ),
      //       child: InkWell(
      //         onTap: () => _showPodcastScreen(context),
      //         child: Container(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Container(
      //                 height: 120,
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                     image: CachedNetworkImageProvider(podcast.imageUrl),
      //                     fit: BoxFit.cover,
      //                   ),
      //                   borderRadius: const BorderRadius.only(
      //                     topLeft: Radius.circular(kBoxDecorationRadius),
      //                     topRight: Radius.circular(kBoxDecorationRadius),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsetsDirectional.only(
      //                     top: kPaddingS, start: kPaddingS, end: kPaddingS),
      //                 child: StrutText(
      //                   podcast.title,
      //                   maxLines: 1,
      //                   style: Theme.of(context).textTheme.bodyText2.bold,
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsetsDirectional.only(
      //                     start: kPaddingS, end: kPaddingS, top: 2),
      //                 child: Row(
      //                   children: <Widget>[
      //                     Expanded(
      //                       child: StrutText(
      //                         podcast.author,
      //                         maxLines: 1,
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .bodyText2
      //                             .copyWith(color: Theme.of(context).hintColor),
      //                         overflow: TextOverflow.ellipsis,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   );
      //   break;

      // case PodcastListItemViewType.list:
      //   return Card(
      //     elevation: 1,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(kBoxDecorationRadius),
      //     ),
      //     margin: EdgeInsets.zero,
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).cardColor,
      //         borderRadius:
      //             const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
      //       ),
      //       child: InkWell(
      //         onTap: () => _showPodcastScreen(context),
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Container(
      //               width: 96,
      //               height: 96,
      //               decoration: BoxDecoration(
      //                 image: DecorationImage(
      //                   image: CachedNetworkImageProvider(podcast.imageUrl),
      //                   fit: BoxFit.cover,
      //                 ),
      //                 borderRadius: const BorderRadiusDirectional.only(
      //                   topStart: Radius.circular(kBoxDecorationRadius),
      //                   bottomStart: Radius.circular(kBoxDecorationRadius),
      //                 ),
      //               ),
      //             ),
      //             Expanded(
      //               child: Padding(
      //                 padding: const EdgeInsets.only(
      //                   top: kPaddingS,
      //                   bottom: kPaddingS,
      //                   left: kPaddingS,
      //                   right: kPaddingS,
      //                 ),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     StrutText(
      //                       podcast.imageUrl,
      //                       maxLines: 1,
      //                       style: Theme.of(context).textTheme.subtitle1.w600,
      //                     ),
      //                     const Padding(padding: EdgeInsets.only(top: 2)),
      //                     StrutText(
      //                       podcast.author,
      //                       maxLines: 1,
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .bodyText2
      //                           .copyWith(color: Theme.of(context).hintColor),
      //                       overflow: TextOverflow.ellipsis,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
      //   break;

      // case PodcastListItemViewType.search:
      //   return InkWell(
      //     onTap: () => _showPodcastScreen(context),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         border: Border(
      //           bottom: BorderSide(
      //             width: 1,
      //             color: Theme.of(context).dividerColor,
      //           ),
      //         ),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsetsDirectional.only(end: kPaddingS),
      //             child: Icon(
      //               Icons.radio,
      //               color: Theme.of(context).disabledColor,
      //               size: 36,
      //             ),
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: const EdgeInsetsDirectional.only(end: kPaddingM),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   if (wordToStyle.isEmpty)
      //                     StrutText(
      //                       podcast.title,
      //                       style: Theme.of(context).textTheme.subtitle1,
      //                       maxLines: 1,
      //                       overflow: TextOverflow.ellipsis,
      //                     )
      //                   else
      //                     RichText(
      //                       text: TextSpan(
      //                         style: Theme.of(context).textTheme.subtitle1,
      //                         children: podcast.title.getSpans(
      //                           matchWord: wordToStyle,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ),
      //                       maxLines: 1,
      //                       overflow: TextOverflow.ellipsis,
      //                     ),
      //                   StrutText(
      //                     podcast.author,
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodyText2
      //                         .copyWith(color: Theme.of(context).hintColor),
      //                     maxLines: 1,
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      //   break;

      default:
        return Container();
    }
  }
}
