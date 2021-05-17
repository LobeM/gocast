import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/podcast_model.dart';
import 'package:gocast/data/repositories/podcasts_repository.dart';
import 'package:gocast/generated/l10n.dart';
import 'package:gocast/screens/podcast/widgets/podcast_header.dart';
import 'package:gocast/widgets/blured_image.dart';

class PodcastScreen extends StatefulWidget {
  final int podcastId;

  const PodcastScreen({Key key, this.podcastId = 0}) : super(key: key);
  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  PodcastModel _podcast;

  Future<void> _loadData() async {
    _podcast = await const PodcastRepository().getPodcast(widget.podcastId);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.podcastId > 0) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              leading: BackButton(),
              expandedHeight: 200.0,
              primary: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: PodcastHeader(
                  imageUrl: _podcast.imageUrl,
                  title: _podcast.title,
                ),
                background: BluredImage(_podcast.imageUrl),
              ),
            )
          ],
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
                child: Column(
                  children: [
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(L10n.of(context).subscribe),
                            ],
                          ),
                        ),
                        SizedBox(width: kPaddingS),
                        IconButton(
                          icon: Icon(
                            Icons.public_sharp,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: kPaddingS),
                    ExpandableText(
                      _podcast.description,
                      expandText: L10n.of(context).more,
                      collapseText: L10n.of(context).less,
                      maxLines: 5,
                      linkColor: kPrimaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
