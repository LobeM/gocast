import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/player/player_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/user_repository.dart';
import 'package:gocast/widgets/episode_bottom_sheet.dart';
import 'package:gocast/widgets/shimmer_box.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/datetime.dart';
import 'package:gocast/utils/int.dart';
import 'package:gocast/utils/list.dart';
import 'package:gocast/utils/text_style.dart';

enum EpisodeListItemViewType {
  basic1,
  basicEpisode2,
  detailedEpisode,
  download
}

class EpisodeListItem extends StatelessWidget {
  final PodcastModel podcast;
  final int episodeId;
  final EpisodeListItemViewType viewType;

  const EpisodeListItem({
    Key key,
    this.podcast,
    this.episodeId,
    this.viewType,
  }) : super(key: key);

  void _episodeTapped(
      BuildContext context, PodcastModel podcast, int episodeId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => EpisodeBottomSheet(
        podcast: podcast,
        episodeId: episodeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EpisodeModel episode =
        podcast.episodes.firstWhere((e) => e.id == episodeId);
    if (episode == null) {
      return Container();
    }
    switch (viewType) {
      case EpisodeListItemViewType.basic1:
        return ListTile(
          onTap: () => _episodeTapped(context, podcast, episodeId),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StrutText(
                episode.uploadDate.elapsedTime(context),
                style: Theme.of(context).textTheme.caption,
              ),
              StrutText(
                episode.title,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          subtitle: Row(
            children: [
              InkWell(
                onTap: () => BlocProvider.of<PlayerBloc>(context)
                    .add(SelectedPodcastPlayerEvent(podcast, episodeId)),
                child: Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 8.0),
                    StrutText(
                      episode.duration.toDuration(context),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (UserRepository().isSignedIn())
                IconButton(
                  icon: Icon(
                    Icons.playlist_add,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {},
                ),
              if (UserRepository().isSignedIn())
                IconButton(
                  icon: Icon(
                    Icons.file_download,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {},
                ),
            ],
          ),
        );

      case EpisodeListItemViewType.download:
        if (!podcast.episodes.isNotNullOrEmpty) {
          return SizedBox.shrink();
        }
        EpisodeModel episode =
            podcast.episodes.firstWhere((e) => e.id == episodeId);
        if (episode == null) {
          return Container();
        }
        return ListTile(
          onTap: () => _episodeTapped(context, podcast, episodeId),
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StrutText(
                episode.uploadDate.elapsedTime(context),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              StrutText(
                episode.title,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: kPaddingS),
            child: Row(
              children: [
                InkWell(
                  onTap: () => BlocProvider.of<PlayerBloc>(context)
                      .add(SelectedPodcastPlayerEvent(podcast, episodeId)),
                  child: Icon(
                    Icons.play_arrow,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 8.0),
                StrutText(
                  episode.duration.toDuration(context),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        );
      case EpisodeListItemViewType.detailedEpisode:
        if (!podcast.episodes.isNotNullOrEmpty) {
          return SizedBox.shrink();
        }
        EpisodeModel episode =
            podcast.episodes.firstWhere((e) => e.id == episodeId);
        if (episode == null) {
          return Container();
        }
        return InkWell(
          onTap: () => _episodeTapped(context, podcast, episodeId),
          child: Card(
            elevation: 1,
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
                        onPressed: () => BlocProvider.of<PlayerBloc>(context)
                            .add(
                                SelectedPodcastPlayerEvent(podcast, episodeId)),
                      ),
                      StrutText(
                        episode.duration.toDuration(context),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      if (UserRepository().isSignedIn())
                        IconButton(
                          icon: Icon(
                            Icons.playlist_add,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {},
                        ),
                      if (UserRepository().isSignedIn())
                        IconButton(
                          icon: Icon(
                            Icons.file_download,
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
      default:
        return Container();
    }
  }
}
