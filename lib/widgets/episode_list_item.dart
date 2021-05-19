import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/episode_model.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/datetime.dart';
import 'package:gocast/utils/int.dart';

enum EpisodeListItemViewType { basicEpisode1, basicEpisode2, detailedEpisode }

class EpisodeListItem extends StatelessWidget {
  final EpisodeModel episode;
  final EpisodeListItemViewType viewType;

  const EpisodeListItem({
    Key key,
    this.episode,
    this.viewType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case EpisodeListItemViewType.basicEpisode1:
        return ListTile(
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
              Icon(
                Icons.play_arrow,
                color: kPrimaryColor,
              ),
              SizedBox(width: 8.0),
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
                  Icons.file_download,
                  color: kPrimaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
