import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/widgets/bold_title.dart';
import 'package:gocast/widgets/podcast_list_item.dart';
import 'package:gocast/widgets/shimmer_box.dart';

class PodcastsCarousel extends StatefulWidget {
  const PodcastsCarousel({
    Key key,
    this.title,
    this.podcasts,
    this.onNavigate,
  }) : super(key: key);

  final String title;
  final List<PodcastModel> podcasts;
  final VoidCallback onNavigate;

  @override
  _PodcastsCarouselState createState() => _PodcastsCarouselState();
}

class _PodcastsCarouselState extends State<PodcastsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 342,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BoldTitle(
            title: widget.title,
            onNavigate: widget.onNavigate,
          ),
          Container(
            height: 250,
            child: widget.podcasts != null
                ? ListView(
                    padding: const EdgeInsetsDirectional.only(start: kPaddingM),
                    scrollDirection: Axis.horizontal,
                    children: widget.podcasts.map((PodcastModel podcast) {
                      return Container(
                        width: 340,
                        padding:
                            const EdgeInsetsDirectional.only(end: kPaddingS),
                        margin:
                            const EdgeInsets.only(bottom: 1), // For card shadow
                        child: PodcastListItem(
                          podcast: podcast,
                          viewType: PodcastListItemViewType.block,
                        ),
                      );
                    }).toList(),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        const ShimmerBox(width: 340, height: 250),
                    itemCount:
                        List<int>.generate(2, (int index) => index).length,
                  ),
          ),
        ],
      ),
    );
  }
}
