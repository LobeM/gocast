import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:gocast/utils/text_style.dart';

class PodcastHeader extends StatefulWidget {
  final String imageUrl;
  final String title;

  const PodcastHeader({Key key, this.imageUrl, this.title}) : super(key: key);

  @override
  _PodcastHeaderState createState() => _PodcastHeaderState();
}

class _PodcastHeaderState extends State<PodcastHeader> {
  ScrollPosition _position;
  bool _visible;

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: !_visible,
                child: Padding(
                  padding: EdgeInsets.only(left: kPaddingS),
                  child: Container(
                    height: AppBar().preferredSize.height + 30,
                    width: AppBar().preferredSize.height + 30,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.white),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: !_visible
                      ? const EdgeInsets.only(left: 8.0)
                      : const EdgeInsets.only(left: 48.0),
                  child: StrutText(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .bold
                        .w600
                        .copyWith(color: kWhite),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}