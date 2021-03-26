import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/podcast_list_item.dart';
import 'package:gocast/widgets/shimmer_box.dart';

class EpisodesList extends StatefulWidget {
  const EpisodesList({Key key, this.podcasts}) : super(key: key);

  final List<PodcastModel> podcasts;

  @override
  _EpisodesListState createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      child: widget.podcasts != null
          // ? ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     itemCount: widget.podcasts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return EpisodeListItem(podcast: widget.podcasts[index]);
          //     })
          ? Column(
              // scrollDirection: Axis.vertical,
              children: widget.podcasts.map((PodcastModel podcast) {
                return Container(
                  padding: EdgeInsets.only(bottom: kPaddingM),
                  child: PodcastListItem(
                    podcast: podcast,
                    viewType: PodcastListItemViewType.detailEpisode,
                  ),
                );
              }).toList(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  const ShimmerBox(width: 340, height: 250),
              itemCount: List<int>.generate(2, (int index) => index).length,
            ),
    );
  }
}
