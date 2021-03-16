import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gocast/screens/explore/widgets/explore_header.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
