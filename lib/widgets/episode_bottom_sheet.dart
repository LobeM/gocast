import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';
import 'package:gocast/utils/int.dart';
import 'package:gocast/utils/datetime.dart';

class EpisodeBottomSheet extends StatelessWidget {
  final PodcastModel podcast;
  final int episodeId;

  const EpisodeBottomSheet({
    Key key,
    this.podcast,
    this.episodeId,
  }) : super(key: key);

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EpisodeModel episode =
        podcast.episodes.firstWhere((e) => e.id == episodeId);
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      podcast.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: Container(
                                height: 150,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: kPaddingM),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StrutText(
                                          podcast.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .bold
                                              .copyWith(color: kWhite),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        PopupMenuButton(
                                          icon: Icon(Icons.more_vert,
                                              color: kWhite),
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem(
                                              child: Text('Mark as played'),
                                              value: 0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    StrutText(
                                      episode.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .bold
                                          .copyWith(color: kWhite),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: kPaddingS),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: kWhite,
                                          size: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .fontSize,
                                        ),
                                        SizedBox(width: 4),
                                        StrutText(
                                          episode.duration.toDuration(context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .bold
                                              .copyWith(color: kWhite),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 16),
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: kWhite,
                                          size: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .fontSize,
                                        ),
                                        SizedBox(width: 4),
                                        StrutText(
                                          episode.uploadDate.toLocalDateString,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .bold
                                              .copyWith(color: kWhite),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.file_download),
                              onPressed: () {},
                              color: kPrimaryColor,
                            ),
                            IconButton(
                              icon: Icon(Icons.playlist_add),
                              onPressed: () {},
                              color: kPrimaryColor,
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {},
                              color: kPrimaryColor,
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {},
                              color: Theme.of(context).cardColor,
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      right: kPaddingM,
                      top: 120,
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(50.0)),
                          border: new Border.all(
                            color: Theme.of(context).cardColor,
                            width: 4.0,
                          ),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: kPaddingL,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                  child: Text(episode.description),
                )
              ],
            ),
          );
        },
      ),
    );
    // return Container(
    //   padding: EdgeInsets.only(
    //     left: kPaddingM,
    //     right: kPaddingM,
    //     bottom: kPaddingL,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).cardColor,
    //     borderRadius: const BorderRadius.only(
    //       topLeft: Radius.circular(kCardRadius),
    //       topRight: Radius.circular(kCardRadius),
    //     ),
    //   ),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       _buildHandle(context),
    //       Row(
    //         children: [
    //           CachedNetworkImage(
    //             imageUrl: podcast.imageUrl,
    //             height: 100,
    //             width: 100,
    //           )
    //         ],
    //       ),
    //       Text(episode.description),
    //     ],
    //   ),
    // );
  }
}
