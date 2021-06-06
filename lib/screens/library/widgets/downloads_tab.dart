import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/podcast_list_item.dart';
import 'package:gocast/widgets/shimmer_box.dart';

class DownloadsTab extends StatefulWidget {
  const DownloadsTab({Key key, this.podcasts}) : super(key: key);

  final List<PodcastModel> podcasts;

  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {
  final SlidableController _slideController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.podcasts != null
            ? widget.podcasts
                .map(
                  (PodcastModel item) => Column(
                    children: [
                      Slidable(
                        controller: _slideController,
                        actionPane: const SlidableDrawerActionPane(),
                        child: PodcastListItem(
                          podcast: item,
                          viewType: PodcastListItemViewType.downloadEpisode,
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {},
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                )
                .toList()
            : kTenNumberList.map(
                (int e) => ListTile(
                  leading: ShimmerBox(width: 50, height: 50),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShimmerBox(height: 10),
                      SizedBox(height: 8),
                      ShimmerBox(height: 15),
                      SizedBox(height: kPaddingM),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
