import 'package:flutter/material.dart';
import 'package:gocast/data/models/podcast_model.dart';

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
    return Container();
  }
}
