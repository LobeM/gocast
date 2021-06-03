import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/player/player_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    EpisodeModel episode =
        podcast.episodes.firstWhere((e) => e.id == episodeId);
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Theme.of(context).cardColor,
                child: SingleChildScrollView(
                  controller: scrollController,
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
                                      padding: const EdgeInsets.only(
                                          left: kPaddingM),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                    child:
                                                        Text('Mark as played'),
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
                                                episode.duration
                                                    .toDuration(context),
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
                                                episode.uploadDate
                                                    .toLocalDateString,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                BlocProvider.of<PlayerBloc>(context).add(
                                    SelectedPodcastPlayerEvent(
                                        podcast, episodeId));
                              },
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
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
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPaddingM),
                        child: Text(episode.description),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
