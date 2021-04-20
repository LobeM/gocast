import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/podcast_list_item.dart';
import 'package:gocast/widgets/shimmer_box.dart';

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
        children: widget.podcasts != null
            ? widget.podcasts
                .map(
                  (PodcastModel item) => Column(
                    children: [
                      PodcastListItem(
                        podcast: item,
                        viewType: PodcastListItemViewType.basicTitle,
                      ),
                      Divider(),
                    ],
                  ),
                )
                .toList()
            : kTenNumberList.map(
                (e) => ListTile(
                  leading: ShimmerBox(width: 50, height: 50),
                  title: ShimmerBox(height: 25),
                ),
              ),
      ),
    );
  }
}
