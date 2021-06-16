import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/configs/routes.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/episode_list_item.dart';
import 'package:gocast/widgets/shimmer_box.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/list.dart';
import 'package:gocast/utils/string.dart';

enum PodcastListItemViewType {
  block,
  detailEpisode,
  downloadEpisode,
  basicTitle,
  search,
}

class PodcastListItem extends StatelessWidget {
  const PodcastListItem({
    Key key,
    this.podcast,
    this.viewType,
    this.wordToStyle,
    this.isFavourite,
    this.onFavopriteButtonPressed,
  }) : super(key: key);

  final PodcastModel podcast;
  final PodcastListItemViewType viewType;
  final String wordToStyle;
  final bool isFavourite;
  final VoidCallback onFavopriteButtonPressed;

  void _showPodcastScreen(BuildContext context, int id) {
    Navigator.pushNamed(context, Routes.podcast, arguments: id);
  }

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
              onTap: () => _showPodcastScreen(context, podcast.id),
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
        if (!podcast.episodes.isNotNullOrEmpty) {
          return SizedBox.shrink();
        }
        final EpisodeModel episode = podcast.episodes[0];
        if (episode == null) {
          return SizedBox.shrink();
        }
        return EpisodeListItem(
          podcast: podcast,
          episodeId: episode.id,
          viewType: EpisodeListItemViewType.detailedEpisode,
        );

      case PodcastListItemViewType.downloadEpisode:
        if (!podcast.episodes.isNotNullOrEmpty) {
          return SizedBox.shrink();
        }
        final EpisodeModel episode = podcast.episodes[0];
        if (episode == null) {
          return SizedBox.shrink();
        }
        return EpisodeListItem(
          podcast: podcast,
          episodeId: episode.id,
          viewType: EpisodeListItemViewType.download,
        );

      case PodcastListItemViewType.basicTitle:
        return ListTile(
          onTap: () => _showPodcastScreen(context, podcast.id),
          leading: CachedNetworkImage(
            imageUrl: podcast.imageUrl,
            imageBuilder:
                (BuildContext context, ImageProvider<Object> imageProvider) =>
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
            placeholder: (context, url) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraits) {
              return ShimmerBox(width: 50, height: 50);
            }),
          ),
          title: Text(podcast.title),
          trailing: Icon(Icons.navigate_next),
        );

      case PodcastListItemViewType.search:
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              //color: Theme.of(context).cardColor,
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
                    Icons.location_on,
                    color: Theme.of(context).disabledColor,
                    size: 36,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPaddingM),
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
                          // StrutText(
                          //   sprintf('%s, %s', <String>[location.address, location.city]),
                          //   style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).hintColor),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                        ]),
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
