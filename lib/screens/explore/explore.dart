import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/screens/explore/widgets/explore_header.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isDataLoaded = false;

  Widget _showSubscribedPodcasts() {}
  Widget _showTopPodcasts() {}
  Widget _showTrendingPodcasts() {}

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // Load data
    setState(() => _isDataLoaded = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: ExploreHeader(expandedHeight: 280),
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
