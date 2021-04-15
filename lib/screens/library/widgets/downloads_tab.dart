import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/podcast_list_item.dart';

class DownloadsTab extends StatefulWidget {
  const DownloadsTab({Key key, this.podcasts}) : super(key: key);

  final List<PodcastModel> podcasts;

  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.podcasts
            .map(
              (PodcastModel item) => Column(
                children: [
                  PodcastListItem(
                    podcast: item,
                    viewType: PodcastListItemViewType.episodeTile,
                  ),
                  Divider(),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
