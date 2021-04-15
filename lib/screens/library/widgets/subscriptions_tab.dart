import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/podcast_list_item.dart';

class SubscriptionsTab extends StatefulWidget {
  const SubscriptionsTab({Key key, this.podcasts}) : super(key: key);
  final List<PodcastModel> podcasts;

  @override
  _SubscriptionsTabState createState() => _SubscriptionsTabState();
}

class _SubscriptionsTabState extends State<SubscriptionsTab> {
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
                    viewType: PodcastListItemViewType.list,
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
